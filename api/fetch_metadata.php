<?php
require_once 'config.php';

// 验证token
$headers = getallheaders();
$token = isset($headers['Authorization']) ? $headers['Authorization'] : '';

if (!verifyToken($token)) {
    http_response_code(401);
    sendResponse(false, '未授权访问');
}

// 只接受POST请求
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendResponse(false, '不支持的请求方法');
}

// 获取请求数据
$input = file_get_contents('php://input');
$data = json_decode($input, true);

if (!$data || !isset($data['url'])) {
    sendResponse(false, '缺少URL参数');
}

$url = trim($data['url']);

// 验证URL格式
if (!filter_var($url, FILTER_VALIDATE_URL)) {
    sendResponse(false, '无效的URL格式');
}

try {
    $metadata = fetchWebsiteMetadata($url);
    sendResponse(true, '获取成功', ['data' => $metadata]);
} catch (Exception $e) {
    sendResponse(false, '获取失败: ' . $e->getMessage());
}

/**
 * 获取网站元数据（标题、图标、描述）
 */
function fetchWebsiteMetadata($url) {
    $result = [
        'title' => '',
        'icon' => '',
        'description' => ''
    ];

    // 解析URL获取域名
    $parsedUrl = parse_url($url);
    $baseUrl = $parsedUrl['scheme'] . '://' . $parsedUrl['host'];

    // 设置cURL选项
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_MAXREDIRS => 5,
        CURLOPT_TIMEOUT => 10,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        CURLOPT_HTTPHEADER => [
            'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8',
            'Cache-Control: no-cache'
        ]
    ]);

    $html = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode !== 200 || !$html) {
        throw new Exception('无法访问该网站');
    }

    // 创建DOMDocument解析HTML
    $dom = new DOMDocument();
    @$dom->loadHTML($html);
    $xpath = new DOMXPath($dom);

    // 1. 获取标题
    // 优先级: og:title > twitter:title > title标签
    $titleNode = $xpath->query('//meta[@property="og:title"]/@content');
    if ($titleNode->length > 0) {
        $result['title'] = trim($titleNode->item(0)->nodeValue);
    } else {
        $titleNode = $xpath->query('//meta[@name="twitter:title"]/@content');
        if ($titleNode->length > 0) {
            $result['title'] = trim($titleNode->item(0)->nodeValue);
        } else {
            $titleNode = $xpath->query('//title');
            if ($titleNode->length > 0) {
                $result['title'] = trim($titleNode->item(0)->nodeValue);
            }
        }
    }

    // 2. 获取描述
    // 优先级: og:description > twitter:description > meta description
    $descNode = $xpath->query('//meta[@property="og:description"]/@content');
    if ($descNode->length > 0) {
        $result['description'] = trim($descNode->item(0)->nodeValue);
    } else {
        $descNode = $xpath->query('//meta[@name="twitter:description"]/@content');
        if ($descNode->length > 0) {
            $result['description'] = trim($descNode->item(0)->nodeValue);
        } else {
            $descNode = $xpath->query('//meta[@name="description"]/@content');
            if ($descNode->length > 0) {
                $result['description'] = trim($descNode->item(0)->nodeValue);
            }
        }
    }

    // 3. 获取图标
    // 优先级: og:image > twitter:image > apple-touch-icon > shortcut icon > icon > favicon.ico
    $iconUrl = '';

    // 尝试获取 og:image
    $iconNode = $xpath->query('//meta[@property="og:image"]/@content');
    if ($iconNode->length > 0) {
        $iconUrl = trim($iconNode->item(0)->nodeValue);
    }

    // 尝试获取 twitter:image
    if (!$iconUrl) {
        $iconNode = $xpath->query('//meta[@name="twitter:image"]/@content');
        if ($iconNode->length > 0) {
            $iconUrl = trim($iconNode->item(0)->nodeValue);
        }
    }

    // 尝试获取 apple-touch-icon
    if (!$iconUrl) {
        $iconNode = $xpath->query('//link[@rel="apple-touch-icon"]/@href');
        if ($iconNode->length > 0) {
            $iconUrl = trim($iconNode->item(0)->nodeValue);
        }
    }

    // 尝试获取 shortcut icon
    if (!$iconUrl) {
        $iconNode = $xpath->query('//link[@rel="shortcut icon"]/@href');
        if ($iconNode->length > 0) {
            $iconUrl = trim($iconNode->item(0)->nodeValue);
        }
    }

    // 尝试获取普通 icon
    if (!$iconUrl) {
        $iconNode = $xpath->query('//link[@rel="icon"]/@href');
        if ($iconNode->length > 0) {
            $iconUrl = trim($iconNode->item(0)->nodeValue);
        }
    }

    // 如果以上都没有找到，尝试默认的 favicon.ico
    if (!$iconUrl) {
        $iconUrl = '/favicon.ico';
    }

    // 转换为完整URL
    if ($iconUrl) {
        if (strpos($iconUrl, 'http') === 0) {
            // 已经是完整URL
            $result['icon'] = $iconUrl;
        } elseif (strpos($iconUrl, '//') === 0) {
            // 协议相对URL
            $result['icon'] = $parsedUrl['scheme'] . ':' . $iconUrl;
        } elseif (strpos($iconUrl, '/') === 0) {
            // 绝对路径
            $result['icon'] = $baseUrl . $iconUrl;
        } else {
            // 相对路径
            $result['icon'] = $baseUrl . '/' . $iconUrl;
        }

        // 验证图标URL是否可访问
        if (!validateIconUrl($result['icon'])) {
            // 如果图标无法访问，尝试使用 Google Favicon 服务
            $result['icon'] = 'https://www.google.com/s2/favicons?domain=' . $parsedUrl['host'] . '&sz=128';
        }
    }

    return $result;
}

/**
 * 验证图标URL是否可访问
 */
function validateIconUrl($iconUrl) {
    $ch = curl_init($iconUrl);
    curl_setopt_array($ch, [
        CURLOPT_NOBODY => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_MAXREDIRS => 3,
        CURLOPT_TIMEOUT => 5,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    ]);

    curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return $httpCode === 200;
}
?>
