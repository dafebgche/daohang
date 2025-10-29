<?php
require_once 'config.php';

try {
    $pdo = getPDO();
    $stmt = $pdo->query('SELECT id, name, click_count FROM sites ORDER BY click_count DESC LIMIT 15');
    $sites = $stmt->fetchAll();
    
    echo "<h2>网站点击统计</h2>";
    echo "<table border='1' cellpadding='10'>";
    echo "<tr><th>ID</th><th>网站名称</th><th>点击次数</th></tr>";
    
    foreach ($sites as $site) {
        echo "<tr>";
        echo "<td>{$site['id']}</td>";
        echo "<td>{$site['name']}</td>";
        echo "<td>{$site['click_count']}</td>";
        echo "</tr>";
    }
    
    echo "</table>";
    
    // 检查是否有点击记录
    $totalClicks = array_sum(array_column($sites, 'click_count'));
    echo "<p>总点击数: {$totalClicks}</p>";
    
    // 检查是否有click_count字段
    $columns = $pdo->query("SHOW COLUMNS FROM sites LIKE 'click_count'")->fetchAll();
    if (count($columns) > 0) {
        echo "<p>✓ click_count 字段存在</p>";
    } else {
        echo "<p>✗ click_count 字段不存在</p>";
    }
    
} catch (Exception $e) {
    echo "错误: " . $e->getMessage();
}
?>