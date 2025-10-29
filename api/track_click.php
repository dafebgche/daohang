<?php
require_once 'config.php';

// 允许 POST 请求跟踪点击
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (!$data || !isset($data['site_id'])) {
        sendResponse(false, '缺少网站ID');
    }
    
    try {
        $pdo = getPDO();
        $stmt = $pdo->prepare('UPDATE sites SET click_count = click_count + 1 WHERE id = ?');
        $stmt->execute([intval($data['site_id'])]);
        
        if ($stmt->rowCount() > 0) {
            sendResponse(true, '点击已记录');
        } else {
            sendResponse(false, '网站不存在');
        }
    } catch (Exception $e) {
        sendResponse(false, '记录失败: ' . $e->getMessage());
    }
} else {
    sendResponse(false, '仅支持POST请求');
}
?>