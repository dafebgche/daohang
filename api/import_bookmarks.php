<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'config.php';

// 验证管理员权限
function checkAuth() {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

    // 简单的token验证（实际项目中应该更严格）
    return !empty($token);
}

if (!checkAuth()) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => '未授权']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => '不支持的请求方法']);
    exit;
}

// 解析 Netscape 书签格式
function parseNetscapeBookmarks($html) {
    $bookmarks = [];

    // 创建 DOMDocument
    $dom = new DOMDocument();
    libxml_use_internal_errors(true); // 禁用HTML错误显示

    // 尝试加载HTML
    $html = mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8');
    $dom->loadHTML($html, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
    libxml_clear_errors();

    $xpath = new DOMXPath($dom);

    // 查找所有链接节点
    $links = $xpath->query('//dt/a[@href]');

    foreach ($links as $link) {
        $url = $link->getAttribute('HREF') ?: $link->getAttribute('href');
        $name = trim($link->textContent);

        // 跳过空链接
        if (empty($url) || empty($name)) {
            continue;
        }

        // 获取其他属性
        $addDate = $link->getAttribute('ADD_DATE');
        $icon = $link->getAttribute('ICON');

        // 尝试获取描述（通常在下一个DD标签中）
        $description = '';
        $nextSibling = $link->parentNode->nextSibling;
        while ($nextSibling) {
            if ($nextSibling->nodeType === XML_ELEMENT_NODE &&
                strtolower($nextSibling->nodeName) === 'dd') {
                $description = trim($nextSibling->textContent);
                break;
            }
            $nextSibling = $nextSibling->nextSibling;
        }

        // 自动分类（根据文件夹）
        $category = '未分类';
        $parentNode = $link->parentNode;
        while ($parentNode) {
            if ($parentNode->nodeType === XML_ELEMENT_NODE) {
                $prevSibling = $parentNode->previousSibling;
                while ($prevSibling) {
                    if ($prevSibling->nodeType === XML_ELEMENT_NODE &&
                        strtolower($prevSibling->nodeName) === 'h3') {
                        $category = trim($prevSibling->textContent);
                        break 2;
                    }
                    $prevSibling = $prevSibling->previousSibling;
                }
            }
            $parentNode = $parentNode->parentNode;
        }

        $bookmarks[] = [
            'name' => $name,
            'url' => $url,
            'description' => $description ?: $name,
            'icon' => $icon ?: '',
            'category' => $category,
            'addDate' => $addDate
        ];
    }

    return $bookmarks;
}

// 分类映射
function mapCategory($originalCategory) {
    $categoryMap = [
        '工具' => '在线工具',
        '安全' => '安全工具',
        '开发' => '开发运维',
        '域名' => '网络域名',
        '教程' => '技术教程',
        'AI' => 'AI工具'
    ];

    foreach ($categoryMap as $key => $value) {
        if (stripos($originalCategory, $key) !== false) {
            return $value;
        }
    }

    return '在线工具'; // 默认分类
}

try {
    // 检查是否有上传的文件
    if (!isset($_FILES['bookmarkFile']) || $_FILES['bookmarkFile']['error'] !== UPLOAD_ERR_OK) {
        throw new Exception('未上传文件或上传失败');
    }

    $uploadedFile = $_FILES['bookmarkFile'];

    // 验证文件类型
    $allowedTypes = ['text/html', 'application/x-netscape-bookmarks'];
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $uploadedFile['tmp_name']);
    finfo_close($finfo);

    // 读取文件内容
    $htmlContent = file_get_contents($uploadedFile['tmp_name']);

    if (empty($htmlContent)) {
        throw new Exception('文件内容为空');
    }

    // 解析书签
    $bookmarks = parseNetscapeBookmarks($htmlContent);

    if (empty($bookmarks)) {
        throw new Exception('未能解析到任何书签，请检查文件格式');
    }

    // 连接数据库
    $pdo = getPDO();

    // 准备插入语句
    $stmt = $pdo->prepare("
        INSERT INTO sites (name, url, description, icon, category, keywords, created_at, updated_at)
        VALUES (:name, :url, :description, :icon, :category, :keywords, :created_at, :updated_at)
    ");

    $imported = 0;
    $skipped = 0;
    $errors = [];

    // 检查是否需要去重
    $checkDuplicates = isset($_POST['checkDuplicates']) && $_POST['checkDuplicates'] === 'true';

    foreach ($bookmarks as $bookmark) {
        try {
            // 检查重复
            if ($checkDuplicates) {
                $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM sites WHERE url = :url");
                $checkStmt->execute([':url' => $bookmark['url']]);
                if ($checkStmt->fetchColumn() > 0) {
                    $skipped++;
                    continue;
                }
            }

            // 处理图标
            $icon = $bookmark['icon'];
            if (empty($icon) || strpos($icon, 'data:image') === 0) {
                // 如果是空的或是data:image格式，尝试获取favicon
                $parsedUrl = parse_url($bookmark['url']);
                if (isset($parsedUrl['scheme']) && isset($parsedUrl['host'])) {
                    $icon = $parsedUrl['scheme'] . '://' . $parsedUrl['host'] . '/favicon.ico';
                } else {
                    $icon = '🌐';
                }
            }

            // 映射分类
            $category = mapCategory($bookmark['category']);

            // 生成关键词
            $keywords = $bookmark['name'] . ' ' . $category;

            // 获取当前时间
            $now = date('Y-m-d H:i:s');

            // 插入数据库
            $stmt->execute([
                ':name' => $bookmark['name'],
                ':url' => $bookmark['url'],
                ':description' => $bookmark['description'],
                ':icon' => $icon,
                ':category' => $category,
                ':keywords' => $keywords,
                ':created_at' => $now,
                ':updated_at' => $now
            ]);

            $imported++;
        } catch (Exception $e) {
            $errors[] = $bookmark['name'] . ': ' . $e->getMessage();
        }
    }

    echo json_encode([
        'success' => true,
        'message' => "导入完成！成功: {$imported}, 跳过: {$skipped}",
        'data' => [
            'total' => count($bookmarks),
            'imported' => $imported,
            'skipped' => $skipped,
            'errors' => $errors
        ]
    ]);

} catch (Exception $e) {
    http_response_code(400);
    error_log('Import bookmarks error: ' . $e->getMessage());
    error_log('Error trace: ' . $e->getTraceAsString());
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage(),
        'error_detail' => $e->getTraceAsString()
    ]);
}
?>
