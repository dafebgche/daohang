<?php
require_once 'config.php';

// 处理不同的请求方法
switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        getVisitorStats();
        break;
    case 'POST':
        recordVisit();
        break;
    default:
        sendResponse(false, '不支持的请求方法');
}

// 记录访问
function recordVisit() {
    try {
        $pdo = getPDO();
        
        // 创建访客统计表（如果不存在）
        $pdo->exec('CREATE TABLE IF NOT EXISTS visitor_stats (
            id INT AUTO_INCREMENT PRIMARY KEY,
            visit_date DATE NOT NULL UNIQUE,
            visit_count INT DEFAULT 0,
            updated_at DATETIME NOT NULL,
            INDEX idx_visit_date (visit_date)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;');
        
        $today = date('Y-m-d');
        $now = date('Y-m-d H:i:s');
        
        // 使用 INSERT ... ON DUPLICATE KEY UPDATE 原子性更新
        $stmt = $pdo->prepare('
            INSERT INTO visitor_stats (visit_date, visit_count, updated_at) 
            VALUES (?, 1, ?)
            ON DUPLICATE KEY UPDATE 
                visit_count = visit_count + 1,
                updated_at = ?
        ');
        $stmt->execute([$today, $now, $now]);
        
        // 获取今日访问数
        $stmt2 = $pdo->prepare('SELECT visit_count FROM visitor_stats WHERE visit_date = ?');
        $stmt2->execute([$today]);
        $result = $stmt2->fetch();
        
        sendResponse(true, '记录成功', [
            'today_visits' => $result ? (int)$result['visit_count'] : 1
        ]);
    } catch (Exception $e) {
        error_log('recordVisit error: ' . $e->getMessage());
        sendResponse(false, '记录失败');
    }
}

// 获取访客统计
function getVisitorStats() {
    try {
        $pdo = getPDO();
        
        // 确保表存在
        $pdo->exec('CREATE TABLE IF NOT EXISTS visitor_stats (
            id INT AUTO_INCREMENT PRIMARY KEY,
            visit_date DATE NOT NULL UNIQUE,
            visit_count INT DEFAULT 0,
            updated_at DATETIME NOT NULL,
            INDEX idx_visit_date (visit_date)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;');
        
        $today = date('Y-m-d');
        
        // 获取今日访问数
        $stmt = $pdo->prepare('SELECT visit_count FROM visitor_stats WHERE visit_date = ?');
        $stmt->execute([$today]);
        $todayResult = $stmt->fetch();
        $todayVisits = $todayResult ? (int)$todayResult['visit_count'] : 0;
        
        // 获取总访问数
        $stmt2 = $pdo->query('SELECT COALESCE(SUM(visit_count), 0) as total FROM visitor_stats');
        $totalResult = $stmt2->fetch();
        $totalVisits = (int)$totalResult['total'];
        
        sendResponse(true, '', [
            'today_visits' => $todayVisits,
            'total_visits' => $totalVisits
        ]);
    } catch (Exception $e) {
        error_log('getVisitorStats error: ' . $e->getMessage());
        sendResponse(false, '获取失败', [
            'today_visits' => 0,
            'total_visits' => 0
        ]);
    }
}
?>