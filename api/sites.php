<?php
require_once 'config.php';

// 验证token (除了GET请求)
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? $headers['Authorization'] : '';
    
    if (!verifyToken($token)) {
        http_response_code(401);
        sendResponse(false, '未授权访问');
    }
}

// 处理不同的请求方法
switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        getSites();
        break;
    case 'POST':
        addSite();
        break;
    case 'PUT':
        updateSite();
        break;
    case 'DELETE':
        deleteSite();
        break;
    default:
        sendResponse(false, '不支持的请求方法');
}

// 获取所有网站（MySQL）
function getSites() {
    try {
        $pdo = getPDO();
        $stmt = $pdo->query('SELECT id, name, url, icon, category, description, keywords, click_count, created_at, updated_at FROM sites ORDER BY id ASC');
        $sites = $stmt->fetchAll();
        // 确保click_count是整数类型
        foreach ($sites as &$site) {
            $site['click_count'] = (int)$site['click_count'];
        }
        sendResponse(true, '', ['sites' => $sites]);
    } catch (Exception $e) {
        sendResponse(false, '读取失败', ['sites' => []]);
    }
}

// 添加网站（MySQL）
function addSite() {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (!$data || !isset($data['name']) || !isset($data['url']) || !isset($data['category']) || !isset($data['description'])) {
        sendResponse(false, '缺少必要参数');
    }
    
    try {
        $pdo = getPDO();
        $stmt = $pdo->prepare('INSERT INTO sites (name, url, icon, category, description, keywords, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)');
        $now = date('Y-m-d H:i:s');
        $stmt->execute([
            trim($data['name']),
            trim($data['url']),
            isset($data['icon']) ? trim($data['icon']) : '🌐',
            trim($data['category']),
            trim($data['description']),
            isset($data['keywords']) ? trim($data['keywords']) : '',
            $now,
            $now
        ]);
        $id = (int)$pdo->lastInsertId();
        $stmt2 = $pdo->prepare('SELECT id, name, url, icon, category, description, keywords, click_count, created_at, updated_at FROM sites WHERE id = ?');
        $stmt2->execute([$id]);
        $site = $stmt2->fetch();
        sendResponse(true, '添加成功', ['site' => $site]);
    } catch (Exception $e) {
        sendResponse(false, '保存失败: ' . $e->getMessage());
    }
}

// 更新网站（MySQL）
function updateSite() {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (!$data || !isset($data['id'])) {
        sendResponse(false, '缺少网站ID');
    }
    
    try {
        $pdo = getPDO();
        // 检查存在
        $stmt = $pdo->prepare('SELECT id FROM sites WHERE id = ?');
        $stmt->execute([intval($data['id'])]);
        if (!$stmt->fetch()) {
            sendResponse(false, '网站不存在');
        }
        
        // 动态拼接更新字段
        $fields = [];
        $params = [];
        $map = ['name','url','icon','category','description','keywords'];
        foreach ($map as $key) {
            if (isset($data[$key])) {
                $fields[] = "$key = ?";
                $params[] = trim($data[$key]);
            }
        }
        $fields[] = 'updated_at = ?';
        $params[] = date('Y-m-d H:i:s');
        $params[] = intval($data['id']);
        
        $sql = 'UPDATE sites SET ' . implode(', ', $fields) . ' WHERE id = ?';
        $upd = $pdo->prepare($sql);
        $upd->execute($params);
        
        sendResponse(true, '更新成功');
    } catch (Exception $e) {
        sendResponse(false, '保存失败: ' . $e->getMessage());
    }
}

// 删除网站（MySQL）
function deleteSite() {
    if (!isset($_GET['id'])) {
        sendResponse(false, '缺少网站ID');
    }
    
    try {
        $pdo = getPDO();
        $stmt = $pdo->prepare('DELETE FROM sites WHERE id = ?');
        $stmt->execute([intval($_GET['id'])]);
        if ($stmt->rowCount() === 0) {
            sendResponse(false, '网站不存在');
        }
        sendResponse(true, '删除成功');
    } catch (Exception $e) {
        sendResponse(false, '删除失败');
    }
}
?>