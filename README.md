# 🚀 我的导航站

一个简洁、现代化的网址导航站系统,支持网站管理、书签导入、访问统计等功能。

## ✨ 功能特性

### 前台功能
- 🎨 **现代化界面设计** - 简洁美观的响应式设计,支持移动端
- 📚 **侧边栏分类导航** - 左侧固定分类导航,支持展开/收起
- 🔍 **实时搜索功能** - 支持网站名称、网址、描述和关键词搜索
- ⌨️ **快捷键支持** - 按 `/` 或 `Ctrl+K` 快速聚焦搜索框
- ⭐ **我的常用** - 自动展示点击次数最多的前12个网站
- 📊 **访问统计** - 显示今日访问量、收录网站数和分类数量
- 🎯 **点击追踪** - 记录网站点击次数,自动生成常用网站

### 后台管理
- 🔐 **安全登录系统** - JWT身份认证,确保数据安全
- 📝 **网站增删改查** - 完整的网站信息管理功能
- 📥 **书签导入功能** - 支持导入Chrome、Firefox、Edge等浏览器书签
- 🔄 **自动获取元数据** - 自动抓取网站标题、图标和描述
- 📊 **统计数据面板** - 实时显示网站总数、分类数量和访问量
- 🗂️ **分类管理** - 支持多个预设分类,按分类分组显示

## 🛠️ 技术栈

- **前端**: HTML5 + CSS3 + JavaScript (原生)
- **后端**: PHP 7.4+
- **数据库**: MySQL 5.7+
- **认证**: JWT (JSON Web Token)

## 📋 环境要求

- PHP >= 7.4
- MySQL >= 5.7
- Web服务器 (Apache/Nginx/PHPStudy等)
- PHP扩展: pdo_mysql, json

## 🚀 快速开始

### 1. 克隆项目

```bash
git clone <your-repository-url>
cd daohang
```

### 2. 配置数据库

创建MySQL数据库:

```sql
CREATE DATABASE daohang CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

创建数据库用户:

```sql
CREATE USER 'daohang'@'localhost' IDENTIFIED BY '你的密码';
GRANT ALL PRIVILEGES ON daohang.* TO 'daohang'@'localhost';
FLUSH PRIVILEGES;
```

### 3. 修改配置

编辑 [`api/config.php`](api/config.php:32) 文件,修改数据库连接信息:

```php
$dsn = 'mysql:host=localhost;port=3306;dbname=daohang;charset=utf8mb4';
$user = 'daohang';
$pass = '你的密码';
```

修改默认管理员账号(可选):

```php
define('ADMIN_USERNAME', 'admin');
define('ADMIN_PASSWORD', 'admin123');
```

**重要**: 修改JWT密钥以增强安全性:

```php
define('JWT_SECRET', '你的随机密钥字符串');
```

### 4. 部署项目

将项目文件放置到Web服务器目录,例如:

```
/var/www/html/daohang/
```

或PHPStudy的WWW目录:

```
D:\phpstudy_pro\WWW\daohang\
```

### 5. 访问系统

- **前台**: `http://localhost/daohang/`
- **后台**: `http://localhost/daohang/admin/`
- **默认账号**: 
  - 用户名: `admin`
  - 密码: `admin123`

⚠️ **首次登录后请立即修改默认密码!**

## 📁 项目结构

```
daohang/
├── index.html              # 前台页面
├── admin/
│   ├── index.html         # 后台管理页面
│   └── login.html         # 登录页面
├── api/
│   ├── config.php         # 数据库配置和公共函数
│   ├── sites.php          # 网站CRUD接口
│   ├── login.php          # 登录接口
│   ├── visitor.php        # 访问统计接口
│   ├── track_click.php    # 点击追踪接口
│   ├── fetch_metadata.php # 网站元数据获取接口
│   ├── import_bookmarks.php # 书签导入接口
│   └── check_clicks.php   # 点击数据检查工具
└── README.md              # 项目说明文档
```

## 💡 使用说明

### 添加网站

1. 登录后台管理系统
2. 点击右上角"+ 添加网站"按钮
3. 填写网站信息:
   - **网站名称**: 必填,显示在导航卡片上
   - **网站网址**: 必填,必须以http://或https://开头
   - **网站图标**: 可选,支持emoji或自动获取favicon
   - **分类**: 必选,选择适合的分类
   - **网站描述**: 必填,鼠标悬停时显示
   - **关键词**: 可选,用空格分隔,便于搜索
4. 输入网址后系统会自动获取网站标题和图标
5. 点击"保存"完成添加

### 导入书签

1. 从浏览器导出书签为HTML格式:
   - **Chrome**: 设置 → 书签 → 书签管理器 → 导出书签
   - **Firefox**: 书签 → 管理所有书签 → 导入和备份 → 导出书签为HTML
   - **Edge**: 收藏夹 → 导出收藏夹
2. 在后台点击"📥 导入书签"
3. 选择导出的HTML文件
4. 勾选"跳过重复的网址"(推荐)
5. 点击"开始导入",等待完成

### 自定义分类

编辑 [`api/config.php`](api/config.php) 或前端页面,修改分类列表:

```javascript
// 前台 index.html
const categoryIcons = {
    '在线工具': '📚',
    '安全工具': '🛡️',
    '开发运维': '💻',
    '网络域名': '🌐',
    '技术教程': '📚',
    'AI工具': '🤖'
};
```

## 🔧 API接口文档

### 获取网站列表

```http
GET /api/sites.php
Authorization: Bearer <token> (可选)
```

响应:
```json
{
    "success": true,
    "sites": [
        {
            "id": 1,
            "name": "Google",
            "url": "https://www.google.com",
            "icon": "🔍",
            "category": "搜索引擎",
            "description": "全球最大的搜索引擎",
            "keywords": "搜索 引擎",
            "click_count": 10,
            "created_at": "2025-01-01 12:00:00",
            "updated_at": "2025-01-01 12:00:00"
        }
    ]
}
```

### 添加网站

```http
POST /api/sites.php
Authorization: Bearer <token>
Content-Type: application/json

{
    "name": "网站名称",
    "url": "https://example.com",
    "icon": "🌐",
    "category": "分类",
    "description": "网站描述",
    "keywords": "关键词1 关键词2"
}
```

### 更新网站

```http
PUT /api/sites.php?id=<site_id>
Authorization: Bearer <token>
Content-Type: application/json

{
    "name": "更新的名称",
    ...
}
```

### 删除网站

```http
DELETE /api/sites.php?id=<site_id>
Authorization: Bearer <token>
```

### 登录

```http
POST /api/login.php
Content-Type: application/json

{
    "username": "admin",
    "password": "admin123"
}
```

响应:
```json
{
    "success": true,
    "message": "登录成功",
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### 访问统计

```http
GET /api/visitor.php
POST /api/visitor.php
```

### 点击追踪

```http
POST /api/track_click.php
Content-Type: application/json

{
    "site_id": 1
}
```

## 🔒 安全建议

1. **修改默认密码**: 首次登录后立即修改
2. **更新JWT密钥**: 在 [`config.php`](api/config.php:10) 中设置强随机密钥
3. **数据库安全**: 使用强密码,限制数据库用户权限
4. **HTTPS部署**: 生产环境建议启用HTTPS
5. **定期备份**: 定期备份数据库数据

## 🐛 常见问题

### 1. 页面显示"加载失败"

- 检查数据库连接配置是否正确
- 确认PHP的pdo_mysql扩展已启用
- 查看浏览器控制台和PHP错误日志

### 2. 登录后立即跳转回登录页

- 检查浏览器是否允许localStorage
- 确认JWT_SECRET已设置
- 清除浏览器缓存和localStorage

### 3. 自动获取图标失败

- 某些网站可能没有favicon
- 可能被目标网站的CORS策略阻止
- 可以手动输入emoji或图标URL

### 4. 书签导入失败

- 确认文件格式为HTML (Netscape Bookmark格式)
- 检查文件大小和PHP上传限制
- 查看网络请求响应详情

### 5. 点击统计不准确

- 运行 [`api/check_clicks.php`](api/check_clicks.php) 检查数据
- 确认click_count字段已添加到数据库
- 检查浏览器是否阻止了追踪请求

## 📝 更新日志

### v1.0.0 (2025-01-29)

- ✅ 初始版本发布
- ✅ 完整的前后台功能
- ✅ 支持书签导入
- ✅ 访问统计和点击追踪
- ✅ 响应式设计

## 📄 许可证

本项目采用 MIT 许可证

## 🤝 贡献

欢迎提交Issue和Pull Request!

## 📮 联系方式

如有问题或建议,请通过以下方式联系:

- 提交Issue
- 发送邮件

---

⭐ 如果这个项目对你有帮助,请给一个Star支持!
