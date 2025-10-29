<?php
// 数据库配置
define('DB_FILE', __DIR__ . '/database.json');

// 默认管理员账号（仅用于初始化到数据库，可自行修改）
define('ADMIN_USERNAME', 'admin');
define('ADMIN_PASSWORD', 'admin123');

// JWT密钥
define('JWT_SECRET', 'your-secret-key-change-this');

// 设置响应头
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// 处理OPTIONS请求
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 使用 127.0.0.1:3306 的 MySQL 连接
function getPDO() {
    static $pdo = null;
    if ($pdo === null) {
        // 先检查扩展
        if (!extension_loaded('pdo_mysql')) {
            throw new Exception('pdo_mysql extension not loaded');
        }
        $dsn = 'mysql:host=localhost;port=3306;dbname=daohang;charset=utf8mb4';
        $user = 'daohang';
        $pass = 'daohang';
        $pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4'
        ]);
    }
    return $pdo;
}

// 简单的JWT生成函数
function generateToken($username) {
    $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
    $payload = json_encode([
        'username' => $username,
        'exp' => time() + (3600 * 24)
    ]);
    $base64UrlHeader = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($header));
    $base64UrlPayload = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($payload));
    $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, JWT_SECRET, true);
    $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));
    return $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;
}

// 验证JWT
function verifyToken($token) {
    if (empty($token)) return false;
    $token = str_replace('Bearer ', '', $token);
    $parts = explode('.', $token);
    if (count($parts) !== 3) return false;
    list($header, $payload, $signature) = $parts;
    $validSignature = hash_hmac('sha256', $header . "." . $payload, JWT_SECRET, true);
    $validBase64Signature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($validSignature));
    if ($signature !== $validBase64Signature) return false;
    $payloadData = json_decode(base64_decode(str_replace(['-', '_'], ['+', '/'], $payload)), true);
    if ($payloadData['exp'] < time()) return false;
    return true;
}

// 读取网站数据（MySQL）
function readDatabase() {
    try {
        $pdo = getPDO();
        $stmt = $pdo->query('SELECT id, name, url, icon, category, description, keywords, created_at, updated_at FROM sites ORDER BY id ASC');
        $sites = $stmt->fetchAll();
        return ['sites' => $sites];
    } catch (Exception $e) {
        return ['sites' => []];
    }
}

// JSON写入占位（兼容旧代码调用）
function writeDatabase($data) { return true; }

// 初始化数据库：sites 与 admins
function initDatabase() {
    try {
        $pdo = getPDO();
        // 设置连接字符集为 utf8mb4（防止历史库/连接不一致）
        $pdo->exec("SET NAMES utf8mb4");
        
        // sites 表
        $pdo->exec('CREATE TABLE IF NOT EXISTS sites (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            url TEXT NOT NULL,
            icon VARCHAR(255) DEFAULT "🌐",
            category VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            keywords VARCHAR(255) DEFAULT "",
            click_count INT DEFAULT 0,
            created_at DATETIME NOT NULL,
            updated_at DATETIME NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;');
        
        // 添加 click_count 列（如果表已存在）
        try {
            $pdo->exec('ALTER TABLE sites ADD COLUMN click_count INT DEFAULT 0');
        } catch (Exception $e) {
            // 列已存在，忽略错误
        }

        // admins 表
        $pdo->exec('CREATE TABLE IF NOT EXISTS admins (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(100) NOT NULL UNIQUE,
            password_hash VARCHAR(255) NOT NULL,
            created_at DATETIME NOT NULL,
            updated_at DATETIME NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;');

        // 初始化默认管理员（如不存在）
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM admins WHERE username = ?');
        $stmt->execute([ADMIN_USERNAME]);
        if ((int)$stmt->fetchColumn() === 0) {
            $now = date('Y-m-d H:i:s');
            $hash = password_hash(ADMIN_PASSWORD, PASSWORD_DEFAULT);
            $ins = $pdo->prepare('INSERT INTO admins (username, password_hash, created_at, updated_at) VALUES (?,?,?,?)');
            $ins->execute([ADMIN_USERNAME, $hash, $now, $now]);
        }

        // 如 sites 表为空则导入初始化数据
        $count = (int)$pdo->query('SELECT COUNT(*) FROM sites')->fetchColumn();
        if ($count === 0) {
            $initFile = __DIR__ . '/init_data.json';
            if (file_exists($initFile)) {
                $initContent = file_get_contents($initFile);
                $initialData = json_decode($initContent, true);
                if (isset($initialData['sites']) && is_array($initialData['sites'])) {
                    $stmt2 = $pdo->prepare('INSERT INTO sites (name, url, icon, category, description, keywords, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)');
                    foreach ($initialData['sites'] as $site) {
                        $now = date('Y-m-d H:i:s');
                        $stmt2->execute([
                            $site['name'],
                            $site['url'],
                            isset($site['icon']) ? $site['icon'] : '🌐',
                            $site['category'],
                            $site['description'],
                            isset($site['keywords']) ? $site['keywords'] : '',
                            $now,
                            $now
                        ]);
                    }
                }
            }
        }
    } catch (Exception $e) {
        // 记录初始化错误以便排查
        error_log('initDatabase error: ' . $e->getMessage());
    }
}

// 标准响应
function sendResponse($success, $message = '', $data = null) {
    $response = ['success' => $success];
    if ($message) $response['message'] = $message;
    if ($data !== null) $response = array_merge($response, $data);
    echo json_encode($response, JSON_UNESCAPED_UNICODE);
    exit();
}

initDatabase();
?>