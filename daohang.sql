/*
 Navicat Premium Dump SQL

 Source Server         : 3
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : daohang

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 29/10/2025 22:49:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'admin', '$2y$10$MbS8PHTp605FfHaBwHe8YOxvfG9Ym3ph/qSGv0mppDExb73SMX7KG', '2025-10-29 17:06:42', '2025-10-29 17:06:42');

-- ----------------------------
-- Table structure for sites
-- ----------------------------
DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '?',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `click_count` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sites
-- ----------------------------
INSERT INTO `sites` VALUES (1, '在线图书馆', 'http://lib.bimuchachong.com/#/', 'http://lib.bimuchachong.com/favicon.ico', '在线工具', '在线图书馆', '在线图书馆 在线工具', '2025-10-29 19:31:57', '2025-10-29 19:31:57', 0);
INSERT INTO `sites` VALUES (2, '饭太硬 | 导航', 'https://www.xn--sss604efuw.com/', 'https://www.xn--sss604efuw.com/favicon.ico', '在线工具', '饭太硬 | 导航', '饭太硬 | 导航 在线工具', '2025-10-29 19:31:57', '2025-10-29 19:31:57', 12);
INSERT INTO `sites` VALUES (3, 'ssh.hax.co.id', 'https://ssh.hax.co.id/', 'https://ssh.hax.co.id/favicon.ico', '开发运维', 'ssh.hax.co.id', 'ssh.hax.co.id 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:47:59', 0);
INSERT INTO `sites` VALUES (4, 'frp内网穿透教程 - tlanyan', 'https://itlanyan.com/frp-tunnel-tutorial/', 'https://itlanyan.com/favicon.ico', '开发运维', 'frp内网穿透教程 - tlanyan', 'frp内网穿透教程 - tlanyan 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:48:12', 0);
INSERT INTO `sites` VALUES (5, '用quic协议解决frp被运营商阻断的问题 - ZRHan\'s Blog', 'https://blog.zrhan.top/2024/07/14/%E7%94%A8quic%E5%8D%8F%E8%AE%AE%E8%A7%A3%E5%86%B3frp%E8%A2%AB%E8%BF%90%E8%90%A5%E5%95%86%E9%98%BB%E6%96%AD%E7%9A%84%E9%97%AE%E9%A2%98/', 'https://blog.zrhan.top/favicon.ico', '开发运维', '用quic协议解决frp被运营商阻断的问题 - ZRHan\'s Blog', '用quic协议解决frp被运营商阻断的问题 - ZRHan\'s Blog 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:48:15', 0);
INSERT INTO `sites` VALUES (6, '搜索 恩山无线论坛', 'https://www.right.com.cn/forum/search.php?mod=forum', 'https://www.right.com.cn/favicon.ico', '技术教程', '搜索 恩山无线论坛', '搜索 恩山无线论坛 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:38:10', 0);
INSERT INTO `sites` VALUES (7, 'SegFault', 'https://shell.segfault.net/#/dashboard', 'https://shell.segfault.net/favicon.ico', '开发运维', 'SegFault', 'SegFault 在线工具', '2025-10-29 19:31:57', '2025-10-29 21:02:27', 0);
INSERT INTO `sites` VALUES (8, 'NodeSeek', 'https://www.nodeseek.com/', 'https://www.nodeseek.com/favicon.ico', '技术教程', 'NodeSeek', 'NodeSeek 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:38:27', 0);
INSERT INTO `sites` VALUES (9, 'R2 对象存储', 'https://dash.cloudflare.com/7f2718f6a034e12b2530867cbe1f56d6/r2/overview', 'https://dash.cloudflare.com/favicon.ico', '网络域名', 'R2 对象存储', 'R2 对象存储', '2025-10-29 19:31:57', '2025-10-29 21:02:37', 0);
INSERT INTO `sites` VALUES (10, '门户首页 - Nomao', 'https://port.nomao.top/', 'https://port.nomao.top/favicon.ico', '开发运维', '门户首页 - Nomao', '门户首页 - Nomao 在线工具', '2025-10-29 19:31:57', '2025-10-29 21:02:44', 0);
INSERT INTO `sites` VALUES (11, '克隆窝 | 助互联网玩家寻找每一条道路', 'https://www.uy5.net/', 'https://www.uy5.net/favicon.ico', '在线工具', '克隆窝 | 助互联网玩家寻找每一条道路', '克隆窝 | 助互联网玩家寻找每一条道路 在线工具', '2025-10-29 19:31:57', '2025-10-29 19:31:57', 0);
INSERT INTO `sites` VALUES (12, 'DigitalPlat Domain Dashboard', 'https://dash.domain.digitalplat.org/panel/main?page=%2Fpanel%2Foverview', 'https://dash.domain.digitalplat.org/favicon.ico', '网络域名', 'DigitalPlat Domain Dashboard', 'DigitalPlat Domain Dashboard 在线工具', '2025-10-29 19:31:57', '2025-10-29 21:02:54', 0);
INSERT INTO `sites` VALUES (13, '7iNet', 'https://www.7inet.moe/', 'https://www.7inet.moe/favicon.ico', '开发运维', '7iNet', '7iNet 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:48:55', 0);
INSERT INTO `sites` VALUES (14, '用户面板 - YE.GS二级域名申请', 'https://nic.ye.gs/user/dashboard.php', 'https://nic.ye.gs/favicon.ico', '网络域名', '用户面板 - YE.GS二级域名申请', '用户面板 - YE.GS二级域名申请 在线工具', '2025-10-29 19:31:57', '2025-10-29 20:49:00', 1);
INSERT INTO `sites` VALUES (15, '网络空间测绘，网络空间安全搜索引擎，网络空间搜索引擎，安全态势感知 - FOFA网络空间测绘系统', 'https://fofa.info/', 'https://fofa.info/favicon.ico', '安全工具', '网络空间测绘，网络空间安全搜索引擎，网络空间搜索引擎，安全态势感知 - FOFA网络空间测绘系统', '网络空间测绘，网络空间安全搜索引擎，网络空间搜索引擎，安全态势感知 - FOFA网络空间测绘系统 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:34:47', 0);
INSERT INTO `sites` VALUES (16, '鹰图平台', 'https://hunter.qianxin.com/', 'https://hunter.qianxin.com/favicon.ico', '安全工具', '鹰图平台', '鹰图平台 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:35:19', 0);
INSERT INTO `sites` VALUES (17, '在线ping_多地ping_多线路ping_持续ping_网络延迟测试_服务器延迟测试', 'https://www.itdog.cn/ping/', 'https://www.itdog.cn/favicon.ico', '网络域名', '在线ping_多地ping_多线路ping_持续ping_网络延迟测试_服务器延迟测试', '在线ping_多地ping_多线路ping_持续ping_网络延迟测试_服务器延迟测试 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:49:11', 0);
INSERT INTO `sites` VALUES (18, 'HackTwo-FOFA 在线高级搜索小工具', 'http://45.152.64.161/app/fofa-vip', 'http://45.152.64.161/favicon.ico', '安全工具', 'HackTwo-FOFA 在线高级搜索小工具', 'HackTwo-FOFA 在线高级搜索小工具 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:35:27', 0);
INSERT INTO `sites` VALUES (19, 'ICP/IP地址/域名信息备案管理系统', 'https://beian.miit.gov.cn/#/Integrated/index', 'https://beian.miit.gov.cn/favicon.ico', '在线工具', 'ICP/IP地址/域名信息备案管理系统', 'ICP/IP地址/域名信息备案管理系统 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (20, 'md5在线解密破解,md5解密加密', 'https://cmd5.com/', 'https://cmd5.com/favicon.ico', '在线工具', 'md5在线解密破解,md5解密加密', 'md5在线解密破解,md5解密加密 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (21, '智谱清言', 'https://chatglm.cn/main/alltoolsdetail?lang=zh', 'https://chatglm.cn/favicon.ico', 'AI工具', '智谱清言', '智谱清言 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:37:19', 0);
INSERT INTO `sites` VALUES (22, 'SQLmap常用命令使用详解 - BIGBadMAN - 博客园', 'https://www.cnblogs.com/BIGBadman/p/18230547', 'https://www.cnblogs.com/favicon.ico', '技术教程', 'SQLmap常用命令使用详解 - BIGBadMAN - 博客园', 'SQLmap常用命令使用详解 - BIGBadMAN - 博客园 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:03:32', 0);
INSERT INTO `sites` VALUES (23, 'IP反查域名_同IP站点查询_同ip网站查询_爱站网', 'https://dns.aizhan.com/', 'https://dns.aizhan.com/favicon.ico', '网络域名', 'IP反查域名_同IP站点查询_同ip网站查询_爱站网', 'IP反查域名_同IP站点查询_同ip网站查询_爱站网 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:03:39', 0);
INSERT INTO `sites` VALUES (24, '360网络空间测绘 — 因为看见，所以安全', 'https://quake.360.net/quake/#/index', 'https://quake.360.net/favicon.ico', '安全工具', '360网络空间测绘 — 因为看见，所以安全', '360网络空间测绘 — 因为看见，所以安全 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:35:36', 0);
INSERT INTO `sites` VALUES (25, '菜鸟教程 - 学的不仅是技术，更是梦想！', 'https://www.runoob.com/', 'https://www.runoob.com/favicon.ico', '技术教程', '菜鸟教程 - 学的不仅是技术，更是梦想！', '菜鸟教程 - 学的不仅是技术，更是梦想！ 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:49:31', 0);
INSERT INTO `sites` VALUES (26, '密码字典生成器|在线密码字典生成', 'https://www.bugku.com/mima/', 'https://www.bugku.com/favicon.ico', '在线工具', '密码字典生成器|在线密码字典生成', '密码字典生成器|在线密码字典生成 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (27, '实验 - 使用 Microsoft Office 集成 - Training | Microsoft Learn', 'https://learn.microsoft.com/zh-cn/training/modules/implement-common-integration-features-finance-ops/10-exercise-1', 'https://learn.microsoft.com/favicon.ico', '开发运维', '实验 - 使用 Microsoft Office 集成 - Training | Microsoft Learn', '实验 - 使用 Microsoft Office 集成 - Training | Microsoft Learn 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:49:39', 0);
INSERT INTO `sites` VALUES (28, '手机号码归属地|IP地址查询|批量查IP', 'http://www.1234i.com/', 'http://www.1234i.com/favicon.ico', '在线工具', '手机号码归属地|IP地址查询|批量查IP', '手机号码归属地|IP地址查询|批量查IP 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (29, '首页 - 网络空间测绘,网络安全,漏洞分析,动态测绘,钟馗之眼,时空测绘,赛博测绘 - ZoomEye(\"钟馗之眼\")网络空间搜索引擎', 'https://www.zoomeye.org/', 'https://www.zoomeye.org/favicon.ico', '安全工具', '首页 - 网络空间测绘,网络安全,漏洞分析,动态测绘,钟馗之眼,时空测绘,赛博测绘 - ZoomEye(\"钟馗之眼\")网络空间搜索引擎', '首页 - 网络空间测绘,网络安全,漏洞分析,动态测绘,钟馗之眼,时空测绘,赛博测绘 - ZoomEye(\"钟馗之眼\")网络空间搜索引擎 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:35:45', 0);
INSERT INTO `sites` VALUES (30, 'Exploit Database - Exploits for Penetration Testers, Researchers, and Ethical Hackers', 'https://www.exploit-db.com/', 'https://www.exploit-db.com/favicon.ico', '在线工具', 'Exploit Database - Exploits for Penetration Testers, Researchers, and Ethical Hackers', 'Exploit Database - Exploits for Penetration Testers, Researchers, and Ethical Hackers 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (31, 'FOFA_Tips', 'https://mp.weixin.qq.com/s/NtB2R90wrHZlHq3Nw_KcTA', 'https://mp.weixin.qq.com/favicon.ico', '技术教程', 'FOFA_Tips', 'FOFA_Tips 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:00', 0);
INSERT INTO `sites` VALUES (32, 'MD5免费在线解密破解_MD5在线加密-SOMD5', 'https://www.somd5.com/', 'https://www.somd5.com/favicon.ico', '在线工具', 'MD5免费在线解密破解_MD5在线加密-SOMD5', 'MD5免费在线解密破解_MD5在线加密-SOMD5 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (33, 'FOFA在线查询验证-sanshiOK', 'https://sanshiok.com/verify.html', 'https://sanshiok.com/favicon.ico', '安全工具', 'FOFA在线查询验证-sanshiOK', 'FOFA在线查询验证-sanshiOK 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:35:56', 0);
INSERT INTO `sites` VALUES (34, 'Shodan Search Engine', 'https://www.shodan.io/', 'https://www.shodan.io/favicon.ico', '安全工具', 'Shodan Search Engine', 'Shodan Search Engine 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:36:01', 0);
INSERT INTO `sites` VALUES (35, '渗透安全HackTwo-知识星球', 'https://wx.zsxq.com/group/88885811181452', 'https://wx.zsxq.com/favicon.ico', '技术教程', '渗透安全HackTwo-知识星球', '渗透安全HackTwo-知识星球 在线工具', '2025-10-29 19:33:18', '2025-10-29 22:28:09', 0);
INSERT INTO `sites` VALUES (36, 'DNSLog Platform', 'http://www.dnslog.cn/', 'http://www.dnslog.cn/favicon.ico', '在线工具', 'DNSLog Platform', 'DNSLog Platform 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (37, 'sqlmap常用命令 - 桜、 - 博客园', 'https://www.cnblogs.com/-ying-/p/11759869.html', 'https://www.cnblogs.com/favicon.ico', '技术教程', 'sqlmap常用命令 - 桜、 - 博客园', 'sqlmap常用命令 - 桜、 - 博客园 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:08', 0);
INSERT INTO `sites` VALUES (38, '通用系统漏洞', 'http://wiki.tidesec.com/docs/Weapon', 'http://wiki.tidesec.com/favicon.ico', '技术教程', '通用系统漏洞', '通用系统漏洞 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:12', 0);
INSERT INTO `sites` VALUES (39, 'Hack街-黑客街-黑客技术入门-黑客零基础入门导航-网络安全爱好者的安全导航 | 黑客', 'https://www.hackjie.com/#term-379', 'https://www.hackjie.com/favicon.ico', '技术教程', 'Hack街-黑客街-黑客技术入门-黑客零基础入门导航-网络安全爱好者的安全导航 | 黑客', 'Hack街-黑客街-黑客技术入门-黑客零基础入门导航-网络安全爱好者的安全导航 | 黑客 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:16', 0);
INSERT INTO `sites` VALUES (40, '【安全工具】Httpx信息收集_httpx工具，2024年最新食堂大妈看完都会了-CSDN博客', 'https://blog.csdn.net/2401_83974020/article/details/137801791', 'https://blog.csdn.net/favicon.ico', '技术教程', '【安全工具】Httpx信息收集_httpx工具，2024年最新食堂大妈看完都会了-CSDN博客', '【安全工具】Httpx信息收集_httpx工具，2024年最新食堂大妈看完都会了-CSDN博客 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:21', 0);
INSERT INTO `sites` VALUES (41, '批量打开网页、网站 - IIS7站长之家', 'http://www.iis7.com/b/xgj/16.php', 'http://www.iis7.com/favicon.ico', '在线工具', '批量打开网页、网站 - IIS7站长之家', '批量打开网页、网站 - IIS7站长之家 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (42, 'DNS那点事儿--小白', 'http://wiki.tidesec.com/docs/jswz', 'http://wiki.tidesec.com/favicon.ico', '技术教程', 'DNS那点事儿--小白', 'DNS那点事儿--小白 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:26', 0);
INSERT INTO `sites` VALUES (43, 'RGCMS2.0存在phar反序列化漏洞', 'https://www.yuque.com/hacktwo/dtdx2v/iw6mdun49r2768k0#', 'https://www.yuque.com/favicon.ico', '技术教程', 'RGCMS2.0存在phar反序列化漏洞', 'RGCMS2.0存在phar反序列化漏洞 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:33', 0);
INSERT INTO `sites` VALUES (44, '2024HW漏洞POC汇总', 'https://www.yuque.com/hacktwo/gtsxpc/sue6l21lwipo0o9a#', 'https://www.yuque.com/favicon.ico', '技术教程', '2024HW漏洞POC汇总', '2024HW漏洞POC汇总 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:37', 0);
INSERT INTO `sites` VALUES (45, 'DeepSeek - 探索未至之境', 'https://chat.deepseek.com/a/chat/s/f9950c30-d241-47b9-acd6-cf5044e59946', 'https://chat.deepseek.com/favicon.ico', 'AI工具', 'DeepSeek - 探索未至之境', 'DeepSeek - 探索未至之境 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:44', 0);
INSERT INTO `sites` VALUES (46, 'Base64 编码/解码 - 锤子在线工具', 'https://www.toolhelper.cn/EncodeDecode/Base64', 'https://www.toolhelper.cn/favicon.ico', '在线工具', 'Base64 编码/解码 - 锤子在线工具', 'Base64 编码/解码 - 锤子在线工具 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (47, '1 panel 面板纯 ipv 6 网络使用全记录 | ulricTech游历科学', 'https://blog.ulric.tech/posts/others/1panel-ipv6-usage-record/', 'https://blog.ulric.tech/favicon.ico', '技术教程', '1 panel 面板纯 ipv 6 网络使用全记录 | ulricTech游历科学', '1 panel 面板纯 ipv 6 网络使用全记录 | ulricTech游历科学 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:04:51', 0);
INSERT INTO `sites` VALUES (48, 'Awesome-POC/OA产品漏洞/泛微OA E-Cology getSqlData SQL注入漏洞.md at master · Threekiii/Awesome-POC · GitHub', 'https://github.com/Threekiii/Awesome-POC/blob/master/OA%E4%BA%A7%E5%93%81%E6%BC%8F%E6%B4%9E/%E6%B3%9B%E5%BE%AEOA%20E-Cology%20getSqlData%20SQL%E6%B3%A8%E5%85%A5%E6%BC%8F%E6%B4%9E.md', 'https://github.com/favicon.ico', '技术教程', 'Awesome-POC/OA产品漏洞/泛微OA E-Cology getSqlData SQL注入漏洞.md at master · Threekiii/Awesome-POC · GitHub', 'Awesome-POC/OA产品漏洞/泛微OA E-Cology getSqlData SQL注入漏洞.md at master · Threekiii/Awesome-POC · GitHub 在线工具', '2025-10-29 19:33:18', '2025-10-29 22:28:16', 0);
INSERT INTO `sites` VALUES (49, '多个地点Ping服务器,网站测速 - 站长工具', 'https://ping.chinaz.com/', 'https://ping.chinaz.com/favicon.ico', '在线工具', '多个地点Ping服务器,网站测速 - 站长工具', '多个地点Ping服务器,网站测速 - 站长工具 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (50, 'Terminator by Aéza', 'https://terminator.aeza.net/en/', 'https://terminator.aeza.net/favicon.ico', '在线工具', 'Terminator by Aéza', 'Terminator by Aéza 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (51, 'Docker 使用教程 – DailyCheckIn', 'https://sitoi.github.io/dailycheckin/install/docker/', 'https://sitoi.github.io/favicon.ico', '技术教程', 'Docker 使用教程 – DailyCheckIn', 'Docker 使用教程 – DailyCheckIn 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:05:04', 0);
INSERT INTO `sites` VALUES (52, 'Server酱³ · 极简推送服务', 'https://sc3.ft07.com/sendkey', 'https://sc3.ft07.com/favicon.ico', '在线工具', 'Server酱³ · 极简推送服务', 'Server酱³ · 极简推送服务 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (53, '上传文件 - APK加固安全测试', 'https://56.al/upload.php', 'https://56.al/favicon.ico', '在线工具', '上传文件 - APK加固安全测试', '上传文件 - APK加固安全测试 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (54, 'IP/服务器file.camtj.com的信息 - 站长工具', 'https://ip.chinaz.com/file.camtj.com', 'https://ip.chinaz.com/favicon.ico', '在线工具', 'IP/服务器file.camtj.com的信息 - 站长工具', 'IP/服务器file.camtj.com的信息 - 站长工具 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (55, 'IPUU - IP地址查询|我的IP地址', 'https://www.ipuu.net/query/ip?search=111.33.175.22', 'https://www.ipuu.net/favicon.ico', '在线工具', 'IPUU - IP地址查询|我的IP地址', 'IPUU - IP地址查询|我的IP地址 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (56, '风鸟-企业查询平台-轻松查企业-查失信-查法人-企业信用-工商查询', 'https://riskbird.com/', 'https://riskbird.com/favicon.ico', '在线工具', '风鸟-企业查询平台-轻松查企业-查失信-查法人-企业信用-工商查询', '风鸟-企业查询平台-轻松查企业-查失信-查法人-企业信用-工商查询 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (57, '微步在线X情报社区-威胁情报查询_威胁分析平台_开放社区', 'https://x.threatbook.com/v5/domain/tsa13.t12hg.com', 'https://x.threatbook.com/favicon.ico', '技术教程', '微步在线X情报社区-威胁情报查询_威胁分析平台_开放社区', '微步在线X情报社区-威胁情报查询_威胁分析平台_开放社区 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:17:09', 0);
INSERT INTO `sites` VALUES (58, '图片转Excel - 图片转Excel在线转换 - 万能文字识别在线版', 'https://www.wannengshibie.com/img-to-excel/', 'https://www.wannengshibie.com/favicon.ico', '在线工具', '图片转Excel - 图片转Excel在线转换 - 万能文字识别在线版', '图片转Excel - 图片转Excel在线转换 - 万能文字识别在线版 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (59, 'CentOS7(Linux)详细安装教程（手把手图文详解版）-CSDN博客', 'https://blog.csdn.net/qq_57492774/article/details/131772646', 'https://blog.csdn.net/favicon.ico', '技术教程', 'CentOS7(Linux)详细安装教程（手把手图文详解版）-CSDN博客', 'CentOS7(Linux)详细安装教程（手把手图文详解版）-CSDN博客 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:17:02', 0);
INSERT INTO `sites` VALUES (60, '极核GetShell - 打破网络安全资源分享边界 - 最新发布 - 第2页', 'https://get-shell.com/page/2', 'https://get-shell.com/favicon.ico', '技术教程', '极核GetShell - 打破网络安全资源分享边界 - 最新发布 - 第2页', '极核GetShell - 打破网络安全资源分享边界 - 最新发布 - 第2页 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:58', 0);
INSERT INTO `sites` VALUES (61, 'IP地址查询 - 高精度IP归属地查询工具 - IPLark', 'https://iplark.com/search', 'https://iplark.com/favicon.ico', '在线工具', 'IP地址查询 - 高精度IP归属地查询工具 - IPLark', 'IP地址查询 - 高精度IP归属地查询工具 - IPLark 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (62, '恒脑安全垂域大模型系统', 'https://gc.das-ai.com/welcome', 'https://gc.das-ai.com/favicon.ico', '在线工具', '恒脑安全垂域大模型系统', '恒脑安全垂域大模型系统 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (63, '在线IP地址批量查询工具 | IP归属地查询 - UU在线工具', 'https://uutool.cn/ip-batch/', 'https://uutool.cn/favicon.ico', '在线工具', '在线IP地址批量查询工具 | IP归属地查询 - UU在线工具', '在线IP地址批量查询工具 | IP归属地查询 - UU在线工具 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (64, 'Md5.so', 'https://md5.so/', 'https://md5.so/favicon.ico', '在线工具', 'Md5.so', 'Md5.so 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (65, '临时邮箱 - 收件箱', 'https://mail.td/zh/mail/t9rua4c6@6n9.net', 'https://mail.td/favicon.ico', '网络域名', '临时邮箱 - 收件箱', '临时邮箱 - 收件箱 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:48', 1);
INSERT INTO `sites` VALUES (66, '豆包 - 字节跳动旗下 AI 智能助手', 'https://www.doubao.com/chat/?channel=gdt_sem&source=dbai_gdt_pz_web_36792358_pinp_zongh_tongy_tongy_6&keywordid=36297250785&account_id=36792358&ad_platform_id=gdt_lead&ug_ad_level_0_id=36792358&ug_ad_level_2_id=15111900542&ug_ad_level_3_id=15111900835&ug_semver=v1.1.0&qz_gdt=m7gma2adaaadrgjb5tta', 'https://www.doubao.com/favicon.ico', 'AI工具', '豆包 - 字节跳动旗下 AI 智能助手', '豆包 - 字节跳动旗下 AI 智能助手 在线工具', '2025-10-29 19:33:18', '2025-10-29 20:37:41', 0);
INSERT INTO `sites` VALUES (67, 'PyInstaller Extractor WEB', 'https://pyinstxtractor-web.netlify.app/', 'https://pyinstxtractor-web.netlify.app/favicon.ico', '在线工具', 'PyInstaller Extractor WEB', 'PyInstaller Extractor WEB 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (68, 'PyLingual', 'https://pylingual.io/', 'https://pylingual.io/favicon.ico', '在线工具', 'PyLingual', 'PyLingual 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (69, '感谢与我们共度时光 - LINUX DO', 'https://linux.do/t/topic/967113', 'https://linux.do/favicon.ico', '技术教程', '感谢与我们共度时光 - LINUX DO', '感谢与我们共度时光 - LINUX DO 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:38', 0);
INSERT INTO `sites` VALUES (70, 'ShareYourCC', 'https://shareyour.cc/dashboard', 'https://shareyour.cc/favicon.ico', 'AI工具', 'ShareYourCC', 'ShareYourCC 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:35', 0);
INSERT INTO `sites` VALUES (71, 'Any Router（可签到）', 'https://anyrouter.top/console', 'https://anyrouter.top/favicon.ico', 'AI工具', 'Any Router（可签到）', 'Any Router（可签到） 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:31', 0);
INSERT INTO `sites` VALUES (72, 'Claude Code中国站 - 管理后台（可重置）', 'https://claude.nonocode.cn/api-keys', 'https://claude.nonocode.cn/favicon.ico', 'AI工具', 'Claude Code中国站 - 管理后台（可重置）', 'Claude Code中国站 - 管理后台（可重置） 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:27', 0);
INSERT INTO `sites` VALUES (73, 'DuckCoding', 'https://duckcoding.com/console/token', 'https://duckcoding.com/favicon.ico', 'AI工具', 'DuckCoding', 'DuckCoding 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:24', 0);
INSERT INTO `sites` VALUES (74, 'B4U公益站', 'https://b4u.qzz.io/console/token', 'https://b4u.qzz.io/favicon.ico', 'AI工具', 'B4U公益站', 'B4U公益站 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:21', 0);
INSERT INTO `sites` VALUES (75, 'Veloera（可以签到）（cherry studio）', 'https://zone.veloera.org/app/tokens', 'https://zone.veloera.org/favicon.ico', 'AI工具', 'Veloera（可以签到）（cherry studio）', 'Veloera（可以签到）（cherry studio） 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:17', 0);
INSERT INTO `sites` VALUES (76, '23公益站', 'https://sdwfger.edu.kg/console/token', 'https://sdwfger.edu.kg/favicon.ico', 'AI工具', '23公益站', '23公益站 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:13', 0);
INSERT INTO `sites` VALUES (77, 'YesCode', 'https://co.yes.vg/dashboard', 'https://co.yes.vg/favicon.ico', 'AI工具', 'YesCode', 'YesCode 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:10', 0);
INSERT INTO `sites` VALUES (78, 'FreeKey API', 'https://api.freekey.site/', 'https://api.freekey.site/favicon.ico', 'AI工具', 'FreeKey API', 'FreeKey API 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:05', 0);
INSERT INTO `sites` VALUES (79, 'KYX API', 'https://api.kkyyxx.xyz/console/token', 'https://api.kkyyxx.xyz/favicon.ico', 'AI工具', 'KYX API', 'KYX API 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:16:01', 0);
INSERT INTO `sites` VALUES (80, '全国企业信息查询系统-复活版', 'https://ojx.me/', 'https://ojx.me/favicon.ico', '在线工具', '全国企业信息查询系统-复活版', '全国企业信息查询系统-复活版 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (81, '永久免费公共代理池', 'https://proxy.scdn.io/', 'https://proxy.scdn.io/favicon.ico', '在线工具', '永久免费公共代理池', '永久免费公共代理池 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (82, 'Yu Mail', 'https://mail.970410.xyz/login', 'https://mail.970410.xyz/favicon.ico', '网络域名', 'Yu Mail', 'Yu Mail 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:25', 0);
INSERT INTO `sites` VALUES (83, 'Veloera(可以签到)', 'https://api.colin1112.me/app/dashboard', 'https://api.colin1112.me/favicon.ico', 'AI工具', 'Veloera(可以签到)', 'Veloera(可以签到) 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:19', 0);
INSERT INTO `sites` VALUES (84, 'IKunCode', 'https://api.ikuncode.cc/app/tokens', 'https://api.ikuncode.cc/favicon.ico', 'AI工具', 'IKunCode', 'IKunCode 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:04', 0);
INSERT INTO `sites` VALUES (85, 'PanSou 盘搜', 'https://so.252035.xyz/', 'https://so.252035.xyz/favicon.ico', '在线工具', 'PanSou 盘搜', 'PanSou 盘搜 在线工具', '2025-10-29 19:33:18', '2025-10-29 19:33:18', 0);
INSERT INTO `sites` VALUES (86, '薄荷 API（gemini公益）', 'https://x666.me/console/token', 'https://x666.me/favicon.ico', 'AI工具', '薄荷 API（gemini公益）', '薄荷 API（gemini公益） 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:09', 0);
INSERT INTO `sites` VALUES (87, 'DeepFlood - AI和生活社区', 'https://www.deepflood.com/', 'https://www.deepflood.com/favicon.ico', '技术教程', 'DeepFlood - AI和生活社区', 'DeepFlood - AI和生活社区 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:15', 0);
INSERT INTO `sites` VALUES (88, 'Elysia（可签到）（cherry studio）', 'https://elysia.h-e.top/app/tokens', 'https://elysia.h-e.top/favicon.ico', 'AI工具', 'Elysia（可签到）（cherry studio）', 'Elysia（可签到）（cherry studio） 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:31', 0);
INSERT INTO `sites` VALUES (89, 'b4u抽奖', 'https://tw.b4u.qzz.io/', 'https://tw.b4u.qzz.io/favicon.ico', 'AI工具', 'b4u抽奖', 'b4u抽奖 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:38', 1);
INSERT INTO `sites` VALUES (90, 'Lucky DoneHub - 幸运大转盘包子', 'https://lucky.5202030.xyz/', 'https://lucky.5202030.xyz/favicon.ico', 'AI工具', 'Lucky DoneHub - 幸运大转盘包子', 'Lucky DoneHub - 幸运大转盘包子 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:42', 0);
INSERT INTO `sites` VALUES (91, '包子铺', 'https://api.5202030.xyz/login', 'https://api.5202030.xyz/favicon.ico', 'AI工具', '包子铺', '包子铺 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:46', 1);
INSERT INTO `sites` VALUES (92, 'API接口泄露事件 - 360全网威胁安全云', 'https://ssa.360.net/risk-alert/api', 'https://ssa.360.net/favicon.ico', '安全工具', 'API接口泄露事件 - 360全网威胁安全云', 'API接口泄露事件 - 360全网威胁安全云 在线工具', '2025-10-29 19:33:18', '2025-10-29 21:15:53', 0);

-- ----------------------------
-- Table structure for visitor_stats
-- ----------------------------
DROP TABLE IF EXISTS `visitor_stats`;
CREATE TABLE `visitor_stats`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_date` date NOT NULL,
  `visit_count` int(11) NULL DEFAULT 0,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `visit_date`(`visit_date`) USING BTREE,
  INDEX `idx_visit_date`(`visit_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visitor_stats
-- ----------------------------
INSERT INTO `visitor_stats` VALUES (1, '2025-10-29', 103, '2025-10-29 22:41:00');

SET FOREIGN_KEY_CHECKS = 1;
