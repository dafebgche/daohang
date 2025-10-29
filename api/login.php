<?php
require_once 'config.php';

// 只接受POST请求
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendResponse(false, '请求方法不正确');
}

// 获取POST数据
$input = file_get_contents('php://input');
$data = json_decode($input, true);

if (!$data || !isset($data['username']) || !isset($data['password'])) {
    sendResponse(false, '缺少必要参数');
}

$username = trim($data['username']);
$password = trim($data['password']);

try {
    $pdo = getPDO();
    $stmt = $pdo->prepare('SELECT id, username, password_hash FROM admins WHERE username = ? LIMIT 1');
    $stmt->execute([$username]);
    $row = $stmt->fetch();

    if ($row && password_verify($password, $row['password_hash'])) {
        $token = generateToken($username);
        sendResponse(true, '登录成功', ['token' => $token]);
    } else {
        sendResponse(false, '用户名或密码错误');
    }
} catch (Exception $e) {
    // 记录详细错误到日志，前端仍返回友好提示
    error_log('login.php error: ' . $e->getMessage());
    $msg = '服务器错误，请稍后再试';
    if (!extension_loaded('pdo_mysql')) {
        $msg = '未启用数据库驱动 (pdo_mysql)';
    } elseif (strpos($e->getMessage(), 'SQLSTATE') !== false) {
        $msg = '数据库连接失败，请检查配置';
    }
    sendResponse(false, $msg);
}
?>