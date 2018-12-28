-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.10 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 atp 的数据库结构
CREATE DATABASE IF NOT EXISTS `atp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `atp`;

-- 导出  表 atp.at_business_system 结构
CREATE TABLE IF NOT EXISTS `at_business_system` (
  `system_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '系统名称，包含详细，例如 服务集成平台-测试环境',
  `system_host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP地址',
  `system_port` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务端口',
  `default_path` text COLLATE utf8mb4_unicode_ci COMMENT '默认路径,如果在接口中没有配置路径则使用该路径<br>使用${name}表示接口名称,${path}表示在接口中或者报文中定义的路径',
  `protocol_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支持协议',
  `software_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 应用名称，自定义，如nginx、f5',
  `last_modify_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改用户',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态，1 - 不可用，0 - 可用',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试环境信息';

-- 正在导出表  atp.at_business_system 的数据：~0 rows (大约)
DELETE FROM `at_business_system`;
/*!40000 ALTER TABLE `at_business_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_business_system` ENABLE KEYS */;

-- 导出  表 atp.at_busi_menu_info 结构
CREATE TABLE IF NOT EXISTS `at_busi_menu_info` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `menu_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单页面路径',
  `icon_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字符图标名称,参考前端Hui图标',
  `parent_id` int(11) DEFAULT NULL COMMENT '父节点',
  `node_level` int(1) DEFAULT NULL COMMENT '节点等级',
  `seq` int(2) DEFAULT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '可用状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建用户',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`menu_id`),
  KEY `FK_at_busi_menu_info_at_busi_menu_info` (`parent_id`),
  KEY `FK_at_busi_menu_info_at_user` (`create_user`),
  CONSTRAINT `FK_at_busi_menu_info_at_busi_menu_info` FOREIGN KEY (`parent_id`) REFERENCES `at_busi_menu_info` (`menu_id`),
  CONSTRAINT `FK_at_busi_menu_info_at_user` FOREIGN KEY (`create_user`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务菜单表';

-- 正在导出表  atp.at_busi_menu_info 的数据：~52 rows (大约)
DELETE FROM `at_busi_menu_info`;
/*!40000 ALTER TABLE `at_busi_menu_info` DISABLE KEYS */;
INSERT INTO `at_busi_menu_info` (`menu_id`, `menu_name`, `menu_url`, `icon_name`, `parent_id`, `node_level`, `seq`, `status`, `create_time`, `create_user`, `mark`) VALUES
	(1, '接口自动化', '', 'Hui-iconfont-hetong', 26, 1, 10, '1', '2018-12-27 20:04:56', 1, '接口自动化模块'),
	(2, '接口管理', 'resource/message/interface.html', '', 1, 2, 10, '1', '2018-12-27 20:13:52', 1, ''),
	(3, '报文管理', 'resource/message/message.html', '', 1, 2, 20, '1', '2018-12-27 20:13:52', 1, ''),
	(4, '组合场景', 'resource/message/complexScene.html', '', 1, 2, 30, '1', '2018-12-27 20:13:52', 1, ''),
	(5, '测试集管理', 'resource/message/setCategoryList.html', '', 1, 2, 40, '1', '2018-12-28 09:26:05', 1, ''),
	(6, '测试执行', 'resource/message/autoTest.html', '', 1, 2, 50, '1', '2018-12-28 09:26:05', 1, ''),
	(7, '测试报告', 'resource/message/report.html', '', 1, 2, 60, '1', '2018-12-28 09:26:05', 1, ''),
	(8, '定时任务', 'resource/message/autoTask.html', '', 1, 2, 70, '1', '2018-12-28 09:26:05', 1, ''),
	(9, '高级测试', '', 'Hui-iconfont-html5', 26, 1, 20, '1', '2018-12-28 09:30:38', 1, ''),
	(10, '接口Mock', 'resource/advanced/mockTest.html', '', 9, 2, 10, '1', '2018-12-28 09:30:38', 1, ''),
	(11, '接口探测', 'resource/advanced/interfaceProbe.html', '', 9, 2, 20, '1', '2018-12-28 09:30:38', 1, ''),
	(12, '批量比对', 'nopower.html?v=2', '', 9, 2, 30, '1', '2018-12-28 09:30:38', 1, ''),
	(13, '性能自动化', 'resource/advanced/performanceTest.html', '', 9, 2, 40, '1', '2018-12-28 09:30:38', 1, ''),
	(14, '测试配置', '', 'Hui-iconfont-manage', 26, 1, 30, '1', '2018-12-28 09:39:00', 1, ''),
	(15, '数据池', 'resource/setting/dataPool.html', '', 14, 2, 10, '1', '2018-12-28 09:39:00', 1, ''),
	(16, '测试环境', 'resource/setting/businessSystem.html', '', 14, 2, 20, '1', '2018-12-28 09:39:00', 1, ''),
	(17, '变量模板', 'resource/setting/variable.html', '', 14, 2, 30, '1', '2018-12-28 09:39:00', 1, ''),
	(18, '数据源配置', 'resource/setting/queryDbList.html', '', 14, 2, 40, '1', '2018-12-28 09:39:00', 1, ''),
	(19, '测试工具', '', 'Hui-iconfont-manage2', 26, 1, 40, '1', '2018-12-28 09:39:00', 1, ''),
	(20, 'JSON格式化', 'resource/util/formatJson.html', '', 19, 2, 10, '1', '2018-12-28 09:39:00', 1, ''),
	(21, 'XML格式化', 'resource/util/formatXml.html', '', 19, 2, 20, '1', '2018-12-28 09:39:00', 1, ''),
	(22, '统计报表', '', 'Hui-iconfont-shujutongji', 26, 1, 50, '1', '2018-12-28 09:39:00', 1, ''),
	(23, '服务调用地图', 'resource/reporting/callMap.html', '', 22, 2, 10, '1', '2018-12-28 09:39:00', 1, ''),
	(24, '周期报表', 'nopower.html?v=4', '', 22, 2, 20, '1', '2018-12-28 09:39:00', 1, ''),
	(25, '配置选项', 'nopower.html?v=5', '', 22, 2, 30, '1', '2018-12-28 09:39:00', 1, ''),
	(26, '接口自动化', '', 'Hui-iconfont-chajian', NULL, 0, 10, '1', '2018-12-28 09:51:26', 1, ''),
	(27, 'Web自动化', '', 'Hui-iconfont-html5', NULL, 0, 20, '1', '2018-12-28 09:54:01', 1, ''),
	(28, 'web自动化', '', 'Hui-iconfont-moban-2', 27, 1, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(29, '测试用例', 'resource/web/webCase.html', '', 28, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(30, '元素对象', 'resource/web/webElementCategory.html', '', 28, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(31, '测试用例集', 'resource/web/webSuite.html', '', 28, 2, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(32, '测试报告', 'nopower.html?v=9', '', 28, 2, 40, '1', '2018-12-28 10:01:46', 1, ''),
	(33, '定制化', '', 'Hui-iconfont-gongsi', 27, 1, 20, '1', '2018-12-28 10:01:46', 1, '山西移动'),
	(34, '自动化模块', 'resource/webscript/module.html', '', 33, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(35, '任务管理', 'resource/webscript/task.html', '', 33, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(36, '自动化配置', '', 'Hui-iconfont-manage2', 27, 1, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(37, '测试配置', 'nopower.html?v=10', '', 36, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(38, '执行机', 'nopower.html?v=11', '', 36, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(39, '定时任务', 'nopower.html?v=12', '', 36, 2, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(40, '帮助', '', 'Hui-iconfont-dangan', 27, 1, 40, '1', '2018-12-28 10:01:46', 1, ''),
	(41, '操作手册', 'nopower.html?v=13', '', 40, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(42, '易大师UI自动化测试框架', 'nopower.html?v=14', '', 40, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(43, '资源下载', 'nopower.html?v=15', '', 40, 2, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(44, 'App自动化', '', 'Hui-iconfont-phone-android', NULL, 0, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(45, '平台管理', '', 'Hui-iconfont-system', NULL, 0, 40, '1', '2018-12-28 10:01:46', 1, ''),
	(46, '用户角色', '', 'Hui-iconfont-user-group', 45, 1, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(47, '用户管理', 'resource/user/user.html', '', 46, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(48, '角色管理', 'resource/user/role.html', '', 46, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(49, '系统管理', '', 'Hui-iconfont-manage2', 45, 1, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(50, '系统接口', 'resource/system/opInterface.html', '', 49, 2, 10, '1', '2018-12-28 10:01:46', 1, ''),
	(51, '菜单管理', 'resource/system/menu.html', '', 49, 2, 20, '1', '2018-12-28 10:01:46', 1, ''),
	(52, '系统日志', 'resource/system/logRecord.html', '', 49, 2, 30, '1', '2018-12-28 10:01:46', 1, ''),
	(53, '全局配置', 'resource/system/globalSetting.html', '', 49, 2, 40, '1', '2018-12-28 10:01:46', 1, ''),
	(54, 'Web监控', 'druid/index.html', '', 49, 2, 50, '1', '2018-12-28 10:01:46', 1, '');
/*!40000 ALTER TABLE `at_busi_menu_info` ENABLE KEYS */;

-- 导出  表 atp.at_complex_parameter 结构
CREATE TABLE IF NOT EXISTS `at_complex_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `self_parameter_id` int(11) DEFAULT NULL COMMENT ' 当前节点参数',
  `next_complex_parameter_id` int(11) DEFAULT NULL COMMENT '子节点参数',
  PRIMARY KEY (`id`),
  KEY `at_complex_parameter_fk_self_parameter_id` (`self_parameter_id`),
  KEY `at_complex_parameter_fk_next_complex_parameter_id` (`next_complex_parameter_id`),
  CONSTRAINT `at_complex_parameter_fk_next_complex_parameter_id` FOREIGN KEY (`next_complex_parameter_id`) REFERENCES `at_complex_parameter` (`id`),
  CONSTRAINT `at_complex_parameter_fk_self_parameter_id` FOREIGN KEY (`self_parameter_id`) REFERENCES `at_parameter` (`parameter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='复杂参数组成';

-- 正在导出表  atp.at_complex_parameter 的数据：~0 rows (大约)
DELETE FROM `at_complex_parameter`;
/*!40000 ALTER TABLE `at_complex_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_complex_parameter` ENABLE KEYS */;

-- 导出  表 atp.at_complex_scene 结构
CREATE TABLE IF NOT EXISTS `at_complex_scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complex_scene_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组合场景组成的新场景名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `config_info` text COLLATE utf8mb4_unicode_ci COMMENT '该MAP保存着该组合场景包含的测试场景和相关配置',
  `success_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组合场景的成功条件标记，0 - 要求所有场景必须测试成功，2 - 单独统计结果(即在测试报告中，所有测试详情结果不会出现组合场景中',
  `new_client` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否采用新的 httpclient客户端来测试此组合场景， 0 - 采用独立的httpclient客户端，1 - 使用共享客户端来测试',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试集中的组合场景';

-- 正在导出表  atp.at_complex_scene 的数据：~0 rows (大约)
DELETE FROM `at_complex_scene`;
/*!40000 ALTER TABLE `at_complex_scene` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_complex_scene` ENABLE KEYS */;

-- 导出  表 atp.at_data_db 结构
CREATE TABLE IF NOT EXISTS `at_data_db` (
  `db_id` int(11) NOT NULL,
  `db_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库类型 目前仅支持mysql和oracle',
  `db_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '连接地址',
  `db_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库名',
  `db_username` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库连接用户名',
  `db_passwd` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库密码',
  `db_mark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`db_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试查询数据源信息';

-- 正在导出表  atp.at_data_db 的数据：~0 rows (大约)
DELETE FROM `at_data_db`;
/*!40000 ALTER TABLE `at_data_db` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_data_db` ENABLE KEYS */;

-- 导出  表 atp.at_global_setting 结构
CREATE TABLE IF NOT EXISTS `at_global_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设置名称',
  `default_value` text COLLATE utf8mb4_unicode_ci COMMENT '设置默认值',
  `setting_value` text COLLATE utf8mb4_unicode_ci COMMENT '用户设定值',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全局设置项';

-- 正在导出表  atp.at_global_setting 的数据：~25 rows (大约)
DELETE FROM `at_global_setting`;
/*!40000 ALTER TABLE `at_global_setting` DISABLE KEYS */;
INSERT INTO `at_global_setting` (`setting_id`, `setting_name`, `default_value`, `setting_value`, `mark`) VALUES
	(1, 'home', '', 'http://localhost:8080/yi', '首页地址url'),
	(2, 'notice', '欢迎使用易大师自动化测试平台！', '未做完整测试，如果出现BUG或者有任何需求请联系我<br>邮箱：xuwangcheng14@163.com<br>谢谢支持！', '公告'),
	(3, 'version', '', '0.1.0beta', '系统版本'),
	(4, 'status', '0', NULL, '网站状态-0为开启,1为关闭'),
	(5, 'logSwitch', '0', '0', '系统日志记录开关'),
	(6, 'messageEncoding', 'UTF-8', 'UTF-8', 'xml报文编码'),
	(7, 'sendReportMail', '1', '0', '开启邮件通知-0为开启,1为关闭'),
	(8, 'mailUsername', NULL, '', '邮箱登录用户名'),
	(9, 'mailPassword', NULL, '', '邮箱登录密码'),
	(10, 'mailHost', NULL, 'smtp.qq.com', '邮箱服务器地址'),
	(11, 'mailPort', '25', '25', '邮箱服务器端口'),
	(12, 'mailReceiveAddress', NULL, '', '收件人邮箱列表,逗号分隔'),
	(13, 'mailCopyAddress', NULL, '', '抄送人邮箱列表,逗号分隔'),
	(14, 'mailSSL', '1', '1', '是否启用SSL连接,0为启用,1为不启用'),
	(15, 'siteName', '易大师自动化测试平台', '易大师自动化测试平台', '网站名称'),
	(16, 'copyright', 'Copyright  ©2018 MasterYI Devops All Rights Reserved.', 'Copyright  ©2018 MasterYI Devops All Rights Reserved.', '版权信息'),
	(17, 'webscriptWorkPlace', NULL, '', 'web自动化项目绝对路径'),
	(18, 'webscriptModulePath', NULL, '', 'web自动化项目模块文件夹绝对路径'),
	(19, 'webscriptExecutorHost', NULL, NULL, 'web自动化执行机IP'),
	(20, 'logRecordWhitelist', NULL, 'listModule', '日志记录请求地址白名单'),
	(21, 'logRecordBlacklist', '', '', '日志记录请求地址黑名单'),
	(22, 'messageReportTitle', '接口自动化测试报告', '接口自动化测试报告', '测试报告标题设置'),
	(23, 'mailPersonalName', '接口自动化测试平台', '接口自动化测试平台', '发件人邮箱显示名称'),
	(24, 'mailSendAddress', '', '610421185@qq.com', '发件人邮箱地址'),
	(25, 'messageMailStyle', '{"time":"","probe":""}', '{"time":"接口自动4534534534化平台在 ${time}完成一次定5345334时测试任务。\\n本次共执行测试分公司单方事故场景 ${totalCount}  个,其中测防守打法全文试成功 ${successCount}  个,测试失方式的发送到败 ${failCount} 个,异防守打法散发上方手动中断${stopCount} 个。\\n","probe":"<span style=\\"color:red;\\">88888888888888888888888888888888</span>\\n${level} \\n${time}\\n${status} \\n${code} \\n\\n"}', '邮件推送报告格式设置');
/*!40000 ALTER TABLE `at_global_setting` ENABLE KEYS */;

-- 导出  表 atp.at_global_variable 结构
CREATE TABLE IF NOT EXISTS `at_global_variable` (
  `variable_id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义的名称，例如：当前日期、正常号码1',
  `variable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变量类型',
  `variable_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '如果这个变量可以被使用,则需要设置key值',
  `variable_value` text COLLATE utf8mb4_unicode_ci COMMENT '根据variableType的不同，该值表示含义不同',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `user_id` int(11) DEFAULT NULL COMMENT '创建人',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`variable_id`),
  KEY `at_global_variable_fk_user_id` (`user_id`),
  CONSTRAINT `at_global_variable_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全局变量表\r\n目前可使用的场景(有key值)：\r\n1、所有字段的测试数据\r\n2、请求地址(报文中的mock/real/接口中定义的/测试集运行时配置中配置的自定义请求地址)\r\n3、接口参数中的默认值\r\n4、定时任务中的Cron表达式\r\n5、关联验证中验证值\r\n6、节点验证中验证值(取值方式为字符串、数据库时均有效)\r\n7、全文验证中验证报文\r\n 8、UUID';

-- 正在导出表  atp.at_global_variable 的数据：~0 rows (大约)
DELETE FROM `at_global_variable`;
/*!40000 ALTER TABLE `at_global_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_global_variable` ENABLE KEYS */;

-- 导出  表 atp.at_interface_info 结构
CREATE TABLE IF NOT EXISTS `at_interface_info` (
  `interface_Id` int(11) NOT NULL AUTO_INCREMENT,
  `interface_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口名称，必须为英文',
  `interface_cn_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口中文名',
  `request_url_mock` text COLLATE utf8mb4_unicode_ci COMMENT '模拟请求地址，已废弃',
  `request_url_real` text COLLATE utf8mb4_unicode_ci COMMENT '请求路径',
  `interface_type` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口类型，CX 查询类，SL 受理类',
  `interface_protocol` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口协议',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态，0 正常，1 禁用',
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `last_modify_user` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最近修改的用户名',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`interface_Id`),
  UNIQUE KEY `interface_name` (`interface_name`),
  KEY `at_interface_fk_user_id` (`user_id`),
  CONSTRAINT `at_interface_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口信息表';

-- 正在导出表  atp.at_interface_info 的数据：~0 rows (大约)
DELETE FROM `at_interface_info`;
/*!40000 ALTER TABLE `at_interface_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_interface_info` ENABLE KEYS */;

-- 导出  表 atp.at_interface_info_business_system 结构
CREATE TABLE IF NOT EXISTS `at_interface_info_business_system` (
  `system_id` int(11) NOT NULL DEFAULT '0',
  `interface_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`system_id`,`interface_id`),
  KEY `at_interface_info_business_system_fk_system_id` (`system_id`),
  KEY `at_interface_info_business_system_fk_interface_id` (`interface_id`),
  CONSTRAINT `at_interface_info_business_system_fk_interface_id` FOREIGN KEY (`interface_id`) REFERENCES `at_interface_info` (`interface_Id`),
  CONSTRAINT `at_interface_info_business_system_fk_system_id` FOREIGN KEY (`system_id`) REFERENCES `at_business_system` (`system_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口与环境关联表';

-- 正在导出表  atp.at_interface_info_business_system 的数据：~0 rows (大约)
DELETE FROM `at_interface_info_business_system`;
/*!40000 ALTER TABLE `at_interface_info_business_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_interface_info_business_system` ENABLE KEYS */;

-- 导出  表 atp.at_interface_mock 结构
CREATE TABLE IF NOT EXISTS `at_interface_mock` (
  `mock_id` int(11) NOT NULL AUTO_INCREMENT,
  `mock_name` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称，接口名或者释义',
  `mock_url` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义路径',
  `protocol_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '协议类型，支持http/htps/socket',
  `request_validate` text COLLATE utf8mb4_unicode_ci COMMENT '请求验证规则，json串',
  `response_mock` text COLLATE utf8mb4_unicode_ci COMMENT '返回模拟规则，json串',
  `call_count` int(11) DEFAULT NULL COMMENT '调用次数',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态0=启用，1=禁用',
  `create_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`mock_id`),
  KEY `at_interface_mock_fk_user_id` (`user_id`),
  CONSTRAINT `at_interface_mock_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口mock信息表';

-- 正在导出表  atp.at_interface_mock 的数据：~0 rows (大约)
DELETE FROM `at_interface_mock`;
/*!40000 ALTER TABLE `at_interface_mock` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_interface_mock` ENABLE KEYS */;

-- 导出  表 atp.at_interface_probe 结构
CREATE TABLE IF NOT EXISTS `at_interface_probe` (
  `probe_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `system_id` int(11) DEFAULT NULL COMMENT '关联测试环境',
  `scene_id` int(11) DEFAULT NULL COMMENT '关联测试场景',
  `probe_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '探测类型：1-普通测试场景，2-组合场景',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态，0-已停止，1-正在运行，2-缺少测试数据，3-执行出错',
  `call_count` int(11) DEFAULT NULL COMMENT '当前运行次数',
  `first_call_time` datetime DEFAULT NULL COMMENT '首次执行时间',
  `last_call_time` datetime DEFAULT NULL COMMENT '最近一次执行时间',
  `cycle_analysis_data` text COLLATE utf8mb4_unicode_ci COMMENT '该字段弃用',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `probe_config_json` text COLLATE utf8mb4_unicode_ci COMMENT '探测配置',
  PRIMARY KEY (`probe_id`),
  KEY `at_interface_probe_fk_user_id` (`user_id`),
  KEY `at_interface_probe_fk_system_id` (`system_id`),
  KEY `at_interface_probe_fk_sceene_id` (`scene_id`),
  CONSTRAINT `at_interface_probe_fk_sceene_id` FOREIGN KEY (`scene_id`) REFERENCES `at_message_scene` (`message_scene_id`) ON DELETE CASCADE,
  CONSTRAINT `at_interface_probe_fk_system_id` FOREIGN KEY (`system_id`) REFERENCES `at_business_system` (`system_id`) ON DELETE CASCADE,
  CONSTRAINT `at_interface_probe_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口探测信息表';

-- 正在导出表  atp.at_interface_probe 的数据：~0 rows (大约)
DELETE FROM `at_interface_probe`;
/*!40000 ALTER TABLE `at_interface_probe` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_interface_probe` ENABLE KEYS */;

-- 导出  表 atp.at_log_record 结构
CREATE TABLE IF NOT EXISTS `at_log_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '调用接口用户,对于调用api的为null',
  `op_id` int(11) DEFAULT NULL COMMENT '关联操作接口对象,可能为null',
  `op_time` datetime DEFAULT NULL COMMENT '调用时间',
  `call_url` text COLLATE utf8mb4_unicode_ci COMMENT '调用接口url',
  `intercept_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拦截状态， 0 - 正常， 1 - 无权限，2 - 未登录，3 - 放行，4 - token不正确，5 - 禁用接口，6 - 系统错误',
  `call_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用类型，0 - 用户调用，1 - 外部调用api接口，2 - 内部自调',
  `user_host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户ip',
  `browser_agent` text COLLATE utf8mb4_unicode_ci COMMENT '浏览器信息',
  `validate_time` int(11) DEFAULT NULL COMMENT '后台验证耗时',
  `execute_time` int(11) DEFAULT NULL COMMENT ' 后台执行耗时',
  `request_params` longtext COLLATE utf8mb4_unicode_ci COMMENT '入参',
  `response_params` longtext COLLATE utf8mb4_unicode_ci COMMENT '出参',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`record_id`),
  KEY `at_log_record_fk_user_id` (`user_id`),
  KEY `at_log_record_fk_op_id` (`op_id`),
  CONSTRAINT `at_log_record_fk_op_id` FOREIGN KEY (`op_id`) REFERENCES `at_operation_interface` (`op_id`),
  CONSTRAINT `at_log_record_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户操作记录信息表';

-- 正在导出表  atp.at_log_record 的数据：~119 rows (大约)
DELETE FROM `at_log_record`;
/*!40000 ALTER TABLE `at_log_record` DISABLE KEYS */;
INSERT INTO `at_log_record` (`record_id`, `user_id`, `op_id`, `op_time`, `call_url`, `intercept_status`, `call_type`, `user_host`, `browser_agent`, `validate_time`, `execute_time`, `request_params`, `response_params`, `mark`) VALUES
	(1, 1, 99, '2018-10-23 17:02:54', 'global-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 9, 23, '{"logSwitch":["0"]}', '{returnCode=0}', NULL),
	(2, NULL, NULL, '2018-10-31 05:38:52', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 3, '{}', '{returnCode=7}', NULL),
	(3, NULL, NULL, '2018-10-31 05:38:52', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 48, '{"loginIdentification":["498fbe6a0185a1baa47f552f24336599"],"password":[""],"username":["admin"]}', '{msg=账号或密码不正确,请重新输入!, returnCode=211}', NULL),
	(4, NULL, NULL, '2018-10-31 05:38:53', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 68, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-10-23 16:55:35, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-10-31 05:38:53.321, ifNew=atp, realName=超级管理员, loginIdentification=a708416d8ad5adefe443ecb5dc187311]}', NULL),
	(5, NULL, NULL, '2018-10-31 06:01:26', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 3, '{}', '{returnCode=7}', NULL),
	(6, NULL, NULL, '2018-10-31 06:01:26', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 117, '{"loginIdentification":["a708416d8ad5adefe443ecb5dc187311"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-10-31 05:38:54, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-10-31 06:01:26.119, ifNew=atp, realName=超级管理员, loginIdentification=a708416d8ad5adefe443ecb5dc187311]}', NULL),
	(7, NULL, NULL, '2018-12-27 11:52:48', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 16, '{}', '{returnCode=7}', NULL),
	(8, NULL, NULL, '2018-12-27 11:52:55', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 4, 101, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-10-31 06:03:04, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 11:52:55.309, ifNew=atp, realName=超级管理员, loginIdentification=8976c179fe5f984c21d1f4442cb9a082]}', NULL),
	(9, NULL, NULL, '2018-12-27 11:56:08', 'user-logout', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 2, '{}', '{returnCode=0}', NULL),
	(10, NULL, NULL, '2018-12-27 11:56:08', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 0, '{}', '{returnCode=7}', NULL),
	(11, NULL, NULL, '2018-12-27 11:56:10', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 1, '{}', '{returnCode=7}', NULL),
	(12, NULL, NULL, '2018-12-27 11:57:19', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 1, '{}', '{returnCode=7}', NULL),
	(13, NULL, NULL, '2018-12-27 11:59:38', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 19, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 11:56:06, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 11:59:37.736, ifNew=atp, realName=超级管理员, loginIdentification=6163817dcc323bddd8b2501c0eb2697c]}', NULL),
	(14, NULL, NULL, '2018-12-27 12:03:57', 'user-logout', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 2, '{}', '{returnCode=0}', NULL),
	(15, NULL, NULL, '2018-12-27 12:03:57', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 1, '{}', '{returnCode=7}', NULL),
	(16, NULL, NULL, '2018-12-27 12:04:04', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 0, '{}', '{returnCode=7}', NULL),
	(17, NULL, NULL, '2018-12-27 12:04:06', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 16, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 11:59:38, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 12:04:06.321, ifNew=atp, realName=超级管理员, loginIdentification=dbba39c22c077abc1584b2ae2d389239]}', NULL),
	(18, NULL, NULL, '2018-12-27 12:49:01', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 1, '{}', '{returnCode=0}', NULL),
	(19, NULL, NULL, '2018-12-27 14:59:02', 'user-logout', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 2, '{}', '{returnCode=0}', NULL),
	(20, NULL, NULL, '2018-12-27 14:59:02', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 1, '{}', '{returnCode=7}', NULL),
	(21, NULL, NULL, '2018-12-27 14:59:06', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 23, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 14:58:59, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 14:59:05.692, ifNew=atp, realName=超级管理员, loginIdentification=296556fbda51c6d54187bf6c5b39d64f]}', NULL),
	(22, NULL, NULL, '2018-12-27 15:01:16', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 1, '{}', '{returnCode=7}', NULL),
	(23, NULL, NULL, '2018-12-27 15:01:16', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 96, '{"loginIdentification":["296556fbda51c6d54187bf6c5b39d64f"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 14:59:06, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 15:01:15.698, ifNew=atp, realName=超级管理员, loginIdentification=296556fbda51c6d54187bf6c5b39d64f]}', NULL),
	(24, NULL, NULL, '2018-12-27 15:02:59', 'user-logout', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 3, '{}', '{returnCode=0}', NULL),
	(25, NULL, NULL, '2018-12-27 15:02:59', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 0, '{}', '{returnCode=7}', NULL),
	(26, NULL, NULL, '2018-12-27 15:03:06', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 0, '{}', '{returnCode=7}', NULL),
	(27, NULL, NULL, '2018-12-27 15:03:23', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 1, '{}', '{returnCode=7}', NULL),
	(28, NULL, NULL, '2018-12-27 15:03:48', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 94, '{"loginIdentification":[""],"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 15:01:16, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 15:03:47.82, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(29, NULL, NULL, '2018-12-27 15:12:28', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 3, '{}', '{returnCode=7}', NULL),
	(30, NULL, NULL, '2018-12-27 15:12:28', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 117, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 15:03:48, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 15:12:28.045, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(31, NULL, NULL, '2018-12-27 15:22:07', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 5, '{}', '{returnCode=7}', NULL),
	(32, NULL, NULL, '2018-12-27 15:22:07', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 100, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 15:21:13, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 15:22:07.444, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(33, 1, 128, '2018-12-27 15:26:16', 'user-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 30, 95, '{"createTime":[""],"lastLoginTime":[""],"realName":["32131"],"role.roleId":["1"],"status":[""],"userId":[""],"username":["321321"]}', '{returnCode=0}', NULL),
	(34, NULL, NULL, '2018-12-27 15:29:20', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 2, '{}', '{returnCode=7}', NULL),
	(35, NULL, NULL, '2018-12-27 15:29:20', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 87, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 15:24:05, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-27 15:29:19.665, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(36, NULL, NULL, '2018-12-27 20:01:20', 'menu-edit', '6', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 32, 0, '{"createTime":["2018-12-27 20:00:24"],"createUser.userId":[""],"iconName":["Hui-iconfont-hetong"],"mark":[""],"menuId":[""],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["1"]}', NULL, 'org.hibernate.exception.ConstraintViolationException: could not execute statement\r\n	at org.hibernate.exception.internal.SQLExceptionTypeDelegate.convert(SQLExceptionTypeDelegate.java:74)\r\n	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:49)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:125)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:110)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:136)\r\n	at org.hibernate.id.IdentityGenerator$GetGeneratedKeysDelegate.executeAndExtract(IdentityGenerator.java:96)\r\n	at org.hibernate.id.insert.AbstractReturningDelegate.performInsert(AbstractReturningDelegate.java:58)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:2975)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3487)\r\n	at org.hibernate.action.internal.EntityIdentityInsertAction.execute(EntityIdentityInsertAction.java:81)\r\n	at org.hibernate.engine.spi.ActionQueue.execute(ActionQueue.java:377)\r\n	at org.hibernate.engine.spi.ActionQueue.addResolvedEntityInsertAction(ActionQueue.java:214)\r\n	at org.hibernate.engine.spi.ActionQueue.addInsertAction(ActionQueue.java:194)\r\n	at org.hibernate.engine.spi.ActionQueue.addAction(ActionQueue.java:178)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.addInsertAction(AbstractSaveEventListener.java:321)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSaveOrReplicate(AbstractSaveEventListener.java:286)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSave(AbstractSaveEventListener.java:192)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.saveWithGeneratedId(AbstractSaveEventListener.java:125)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.saveTransientEntity(DefaultMergeEventListener.java:236)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.entityIsTransient(DefaultMergeEventListener.java:216)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.onMerge(DefaultMergeEventListener.java:154)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.onMerge(DefaultMergeEventListener.java:76)\r\n	at org.hibernate.internal.SessionImpl.fireMerge(SessionImpl.java:914)\r\n	at org.hibernate.internal.SessionImpl.merge(SessionImpl.java:898)\r\n	at org.hibernate.internal.SessionImpl.merge(SessionImpl.java:902)\r\n	at yi.master.business.base.dao.impl.BaseDaoImpl.edit(BaseDaoImpl.java:66)\r\n	at yi.master.business.base.service.impl.BaseServiceImpl.edit(BaseServiceImpl.java:40)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:317)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:98)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:262)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:207)\r\n	at com.sun.proxy.$Proxy39.edit(Unknown Source)\r\n	at yi.master.business.base.action.BaseAction.edit(BaseAction.java:200)\r\n	at yi.master.business.system.action.BusiMenuInfoAction.edit(BusiMenuInfoAction.java:32)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invokeAction(DefaultActionInvocation.java:450)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invokeActionOnly(DefaultActionInvocation.java:289)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:252)\r\n	at yi.master.interceptor.CallMethodInterceptor.intercept(CallMethodInterceptor.java:156)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.debugging.DebuggingInterceptor.intercept(DebuggingInterceptor.java:256)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ScopedModelDrivenInterceptor.intercept(ScopedModelDrivenInterceptor.java:141)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.impl.StrutsActionProxy.execute(StrutsActionProxy.java:54)\r\n	at org.apache.struts2.dispatcher.Dispatcher.serviceAction(Dispatcher.java:563)\r\n	at org.apache.struts2.dispatcher.ng.ExecuteOperations.executeAction(ExecuteOperations.java:77)\r\n	at org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter.doFilter(StrutsPrepareAndExecuteFilter.java:99)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.orm.hibernate4.support.OpenSessionInViewFilter.doFilterInternal(OpenSessionInViewFilter.java:149)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:122)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:171)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:102)\r\n	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:950)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:408)\r\n	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1040)\r\n	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:607)\r\n	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:314)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Column \'create_user\' cannot be null\r\n	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)\r\n	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)\r\n	at java.lang.reflect.Constructor.newInstance(Constructor.java:423)\r\n	at com.mysql.jdbc.Util.handleNewInstance(Util.java:404)\r\n	at com.mysql.jdbc.Util.getInstance(Util.java:387)\r\n	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:932)\r\n	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3878)\r\n	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3814)\r\n	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:2478)\r\n	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2625)\r\n	at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2551)\r\n	at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:1861)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdateInternal(PreparedStatement.java:2073)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdateInternal(PreparedStatement.java:2009)\r\n	at com.mysql.jdbc.PreparedStatement.executeLargeUpdate(PreparedStatement.java:5094)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:1994)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:2843)\r\n	at com.alibaba.druid.filter.FilterAdapter.preparedStatement_executeUpdate(FilterAdapter.java:1091)\r\n	at com.alibaba.druid.filter.FilterEventAdapter.preparedStatement_executeUpdate(FilterEventAdapter.java:491)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:2841)\r\n	at com.alibaba.druid.proxy.jdbc.PreparedStatementProxyImpl.executeUpdate(PreparedStatementProxyImpl.java:194)\r\n	at com.alibaba.druid.pool.DruidPooledPreparedStatement.executeUpdate(DruidPooledPreparedStatement.java:254)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:133)\r\n	... 163 more\r\n'),
	(37, NULL, NULL, '2018-12-27 20:01:26', 'menu-edit', '6', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 0, '{"createTime":["2018-12-27 20:00:24"],"createUser.userId":[""],"iconName":["Hui-iconfont-hetong"],"mark":[""],"menuId":[""],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["1"]}', NULL, 'org.hibernate.exception.ConstraintViolationException: could not execute statement\r\n	at org.hibernate.exception.internal.SQLExceptionTypeDelegate.convert(SQLExceptionTypeDelegate.java:74)\r\n	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:49)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:125)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:110)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:136)\r\n	at org.hibernate.id.IdentityGenerator$GetGeneratedKeysDelegate.executeAndExtract(IdentityGenerator.java:96)\r\n	at org.hibernate.id.insert.AbstractReturningDelegate.performInsert(AbstractReturningDelegate.java:58)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:2975)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3487)\r\n	at org.hibernate.action.internal.EntityIdentityInsertAction.execute(EntityIdentityInsertAction.java:81)\r\n	at org.hibernate.engine.spi.ActionQueue.execute(ActionQueue.java:377)\r\n	at org.hibernate.engine.spi.ActionQueue.addResolvedEntityInsertAction(ActionQueue.java:214)\r\n	at org.hibernate.engine.spi.ActionQueue.addInsertAction(ActionQueue.java:194)\r\n	at org.hibernate.engine.spi.ActionQueue.addAction(ActionQueue.java:178)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.addInsertAction(AbstractSaveEventListener.java:321)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSaveOrReplicate(AbstractSaveEventListener.java:286)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSave(AbstractSaveEventListener.java:192)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.saveWithGeneratedId(AbstractSaveEventListener.java:125)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.saveTransientEntity(DefaultMergeEventListener.java:236)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.entityIsTransient(DefaultMergeEventListener.java:216)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.onMerge(DefaultMergeEventListener.java:154)\r\n	at org.hibernate.event.internal.DefaultMergeEventListener.onMerge(DefaultMergeEventListener.java:76)\r\n	at org.hibernate.internal.SessionImpl.fireMerge(SessionImpl.java:914)\r\n	at org.hibernate.internal.SessionImpl.merge(SessionImpl.java:898)\r\n	at org.hibernate.internal.SessionImpl.merge(SessionImpl.java:902)\r\n	at yi.master.business.base.dao.impl.BaseDaoImpl.edit(BaseDaoImpl.java:66)\r\n	at yi.master.business.base.service.impl.BaseServiceImpl.edit(BaseServiceImpl.java:40)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:317)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:98)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:262)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:207)\r\n	at com.sun.proxy.$Proxy39.edit(Unknown Source)\r\n	at yi.master.business.base.action.BaseAction.edit(BaseAction.java:200)\r\n	at yi.master.business.system.action.BusiMenuInfoAction.edit(BusiMenuInfoAction.java:32)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invokeAction(DefaultActionInvocation.java:450)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invokeActionOnly(DefaultActionInvocation.java:289)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:252)\r\n	at yi.master.interceptor.CallMethodInterceptor.intercept(CallMethodInterceptor.java:156)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.debugging.DebuggingInterceptor.intercept(DebuggingInterceptor.java:256)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ScopedModelDrivenInterceptor.intercept(ScopedModelDrivenInterceptor.java:141)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.impl.StrutsActionProxy.execute(StrutsActionProxy.java:54)\r\n	at org.apache.struts2.dispatcher.Dispatcher.serviceAction(Dispatcher.java:563)\r\n	at org.apache.struts2.dispatcher.ng.ExecuteOperations.executeAction(ExecuteOperations.java:77)\r\n	at org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter.doFilter(StrutsPrepareAndExecuteFilter.java:99)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.orm.hibernate4.support.OpenSessionInViewFilter.doFilterInternal(OpenSessionInViewFilter.java:149)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:122)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:171)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:102)\r\n	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:950)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:408)\r\n	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1040)\r\n	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:607)\r\n	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:316)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Column \'create_user\' cannot be null\r\n	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)\r\n	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)\r\n	at java.lang.reflect.Constructor.newInstance(Constructor.java:423)\r\n	at com.mysql.jdbc.Util.handleNewInstance(Util.java:404)\r\n	at com.mysql.jdbc.Util.getInstance(Util.java:387)\r\n	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:932)\r\n	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3878)\r\n	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3814)\r\n	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:2478)\r\n	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2625)\r\n	at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2551)\r\n	at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:1861)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdateInternal(PreparedStatement.java:2073)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdateInternal(PreparedStatement.java:2009)\r\n	at com.mysql.jdbc.PreparedStatement.executeLargeUpdate(PreparedStatement.java:5094)\r\n	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:1994)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:2843)\r\n	at com.alibaba.druid.filter.FilterAdapter.preparedStatement_executeUpdate(FilterAdapter.java:1091)\r\n	at com.alibaba.druid.filter.FilterEventAdapter.preparedStatement_executeUpdate(FilterEventAdapter.java:491)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:2841)\r\n	at com.alibaba.druid.proxy.jdbc.PreparedStatementProxyImpl.executeUpdate(PreparedStatementProxyImpl.java:194)\r\n	at com.alibaba.druid.pool.DruidPooledPreparedStatement.executeUpdate(DruidPooledPreparedStatement.java:254)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:133)\r\n	... 163 more\r\n'),
	(38, NULL, NULL, '2018-12-27 20:05:12', 'menu-edit', '6', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 23, 0, '{"createTime":["2018-12-27 20:04:56"],"createUser.userId":[""],"iconName":["Hui-iconfont-hetong"],"mark":[""],"menuId":[""],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["1"]}', NULL, 'org.apache.struts2.json.JSONException: java.lang.reflect.InvocationTargetException\r\n	at org.apache.struts2.json.JSONWriter.bean(JSONWriter.java:246)\r\n	at org.apache.struts2.json.JSONWriter.processCustom(JSONWriter.java:178)\r\n	at org.apache.struts2.json.JSONWriter.process(JSONWriter.java:168)\r\n	at org.apache.struts2.json.JSONWriter.value(JSONWriter.java:134)\r\n	at org.apache.struts2.json.JSONWriter.map(JSONWriter.java:436)\r\n	at org.apache.struts2.json.JSONWriter.process(JSONWriter.java:154)\r\n	at org.apache.struts2.json.JSONWriter.value(JSONWriter.java:134)\r\n	at org.apache.struts2.json.JSONWriter.write(JSONWriter.java:102)\r\n	at org.apache.struts2.json.JSONUtil.serialize(JSONUtil.java:116)\r\n	at org.apache.struts2.json.JSONResult.createJSONString(JSONResult.java:197)\r\n	at org.apache.struts2.json.JSONResult.execute(JSONResult.java:171)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.executeResult(DefaultActionInvocation.java:371)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:275)\r\n	at yi.master.interceptor.CallMethodInterceptor.intercept(CallMethodInterceptor.java:156)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.debugging.DebuggingInterceptor.intercept(DebuggingInterceptor.java:256)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ScopedModelDrivenInterceptor.intercept(ScopedModelDrivenInterceptor.java:141)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor.doIntercept(DefaultWorkflowInterceptor.java:167)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.validator.ValidationInterceptor.doIntercept(ValidationInterceptor.java:265)\r\n	at org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor.doIntercept(AnnotationValidationInterceptor.java:68)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ConversionErrorInterceptor.intercept(ConversionErrorInterceptor.java:138)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.StaticParametersInterceptor.intercept(StaticParametersInterceptor.java:191)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.FileUploadInterceptor.intercept(FileUploadInterceptor.java:252)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor.intercept(ModelDrivenInterceptor.java:100)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ChainingInterceptor.intercept(ChainingInterceptor.java:145)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.PrepareInterceptor.doIntercept(PrepareInterceptor.java:171)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.ServletConfigInterceptor.intercept(ServletConfigInterceptor.java:164)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ParametersInterceptor.doIntercept(ParametersInterceptor.java:239)\r\n	at com.opensymphony.xwork2.interceptor.MethodFilterInterceptor.intercept(MethodFilterInterceptor.java:98)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.MultiselectInterceptor.intercept(MultiselectInterceptor.java:73)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.interceptor.CheckboxInterceptor.intercept(CheckboxInterceptor.java:91)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.I18nInterceptor.intercept(I18nInterceptor.java:161)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.AliasInterceptor.intercept(AliasInterceptor.java:193)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor.intercept(ExceptionMappingInterceptor.java:189)\r\n	at com.opensymphony.xwork2.DefaultActionInvocation.invoke(DefaultActionInvocation.java:246)\r\n	at org.apache.struts2.impl.StrutsActionProxy.execute(StrutsActionProxy.java:54)\r\n	at org.apache.struts2.dispatcher.Dispatcher.serviceAction(Dispatcher.java:563)\r\n	at org.apache.struts2.dispatcher.ng.ExecuteOperations.executeAction(ExecuteOperations.java:77)\r\n	at org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter.doFilter(StrutsPrepareAndExecuteFilter.java:99)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.orm.hibernate4.support.OpenSessionInViewFilter.doFilterInternal(OpenSessionInViewFilter.java:149)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:108)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:122)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:171)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:102)\r\n	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:950)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:408)\r\n	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1040)\r\n	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:607)\r\n	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:316)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.apache.struts2.json.JSONWriter.bean(JSONWriter.java:226)\r\n	... 129 more\r\nCaused by: java.lang.NullPointerException\r\n	at yi.master.business.system.bean.BusiMenuInfo.getParentNodeId(BusiMenuInfo.java:80)\r\n	... 134 more\r\n'),
	(39, NULL, NULL, '2018-12-27 20:14:12', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 28, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["接口管理"],"menuUrl":["resource/message/interface.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["1"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@683169be}', NULL),
	(40, NULL, NULL, '2018-12-27 20:15:07', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 11, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["报文管理"],"menuUrl":["resource/message/message.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["2"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@74dca616}', NULL),
	(41, NULL, NULL, '2018-12-27 20:15:35', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 15, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["组合场景"],"menuUrl":["resource/message/complexScene.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["3"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1da9f339}', NULL),
	(42, NULL, NULL, '2018-12-28 09:26:02', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 4, '{}', '{returnCode=7}', NULL),
	(43, NULL, NULL, '2018-12-28 09:26:02', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 79, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-27 20:13:50, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-28 09:26:01.987, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(44, NULL, NULL, '2018-12-28 09:26:38', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 11, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试集管理"],"menuUrl":["resource/message/setCategoryList.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["4"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@564ae383}', NULL),
	(45, NULL, NULL, '2018-12-28 09:27:09', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 13, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试执行"],"menuUrl":["resource/message/autoTest.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["5"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@36f20d03}', NULL),
	(46, NULL, NULL, '2018-12-28 09:27:45', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 10, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试报告"],"menuUrl":["resource/message/report.html"],"nodeLevel":["1"],"parentNodeId":["1"],"seq":["6"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@6ad76d88}', NULL),
	(47, NULL, NULL, '2018-12-28 09:28:26', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 4, 10, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["定时任务"],"menuUrl":["resource/message/autoTask.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["7"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7038ce6}', NULL),
	(48, NULL, NULL, '2018-12-28 09:28:33', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 19, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["7"],"menuName":["测试报告"],"menuUrl":["resource/message/report.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["6"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@61e11712}', NULL),
	(49, NULL, NULL, '2018-12-28 09:30:59', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 10, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":["接口自动化"],"menuId":["8"],"menuName":["定时任务"],"menuUrl":["resource/message/autoTask.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["7"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@331b96f0}', NULL),
	(50, NULL, NULL, '2018-12-28 09:31:24', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-27 20:04:56"],"createUser.userId":["1"],"iconName":["Hui-iconfont-hetong"],"mark":[""],"menuId":["1"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1f77369}', NULL),
	(51, NULL, NULL, '2018-12-28 09:31:29', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 18, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["2"],"menuName":["接口管理"],"menuUrl":["resource/message/interface.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@6549bd05}', NULL),
	(52, NULL, NULL, '2018-12-28 09:31:37', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 9, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["3"],"menuName":["报文管理"],"menuUrl":["resource/message/message.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@75c8bb6f}', NULL),
	(53, NULL, NULL, '2018-12-28 09:31:42', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-27 20:13:52"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["4"],"menuName":["组合场景"],"menuUrl":["resource/message/complexScene.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@3099503d}', NULL),
	(54, NULL, NULL, '2018-12-28 09:31:47', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 10, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["5"],"menuName":["测试集管理"],"menuUrl":["resource/message/setCategoryList.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@73f9d0f2}', NULL),
	(55, NULL, NULL, '2018-12-28 09:31:52', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 10, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["6"],"menuName":["测试执行"],"menuUrl":["resource/message/autoTest.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["50"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@11efafa5}', NULL),
	(56, NULL, NULL, '2018-12-28 09:31:59', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["7"],"menuName":["测试报告"],"menuUrl":["resource/message/report.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["60"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@74350d81}', NULL),
	(57, NULL, NULL, '2018-12-28 09:32:05', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":["接口自动化"],"menuId":["8"],"menuName":["定时任务"],"menuUrl":["resource/message/autoTask.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["70"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@2734c265}', NULL),
	(58, NULL, NULL, '2018-12-28 09:32:15', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 13, '{"createTime":["2018-12-28 09:26:05"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["8"],"menuName":["定时任务"],"menuUrl":["resource/message/autoTask.html"],"nodeLevel":["2"],"parentNodeId":["1"],"seq":["70"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@4423174}', NULL),
	(59, NULL, NULL, '2018-12-28 09:33:47', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 9, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":[""],"iconName":["Hui-iconfont-html5"],"mark":[""],"menuId":[""],"menuName":["高级测试"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@c2aee0c}', NULL),
	(60, NULL, NULL, '2018-12-28 09:34:23', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["接口Mock"],"menuUrl":["resource/advanced/mockTest.html"],"nodeLevel":["2"],"parentNodeId":["9"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1dba04c3}', NULL),
	(61, NULL, NULL, '2018-12-28 09:36:10', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 12, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["接口探测"],"menuUrl":["resource/advanced/interfaceProbe.html"],"nodeLevel":["2"],"parentNodeId":["9"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@56a08a7}', NULL),
	(62, NULL, NULL, '2018-12-28 09:36:40', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 9, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["批量比对"],"menuUrl":["nopower.html?v=2"],"nodeLevel":["2"],"parentNodeId":["9"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@2344e6f5}', NULL),
	(63, NULL, NULL, '2018-12-28 09:37:01', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["性能自动化"],"menuUrl":["resource/advanced/performanceTest.html"],"nodeLevel":["2"],"parentNodeId":["9"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@55c98c1c}', NULL),
	(64, NULL, NULL, '2018-12-28 09:39:59', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":["Hui-iconfont-manage"],"mark":[""],"menuId":[""],"menuName":["测试配置"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@6ac0270a}', NULL),
	(65, NULL, NULL, '2018-12-28 09:40:27', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["数据池"],"menuUrl":["resource/setting/dataPool.html"],"nodeLevel":["2"],"parentNodeId":["14"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@10c7c3d6}', NULL),
	(66, NULL, NULL, '2018-12-28 09:40:47', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试环境"],"menuUrl":["resource/setting/businessSystem.html"],"nodeLevel":["2"],"parentNodeId":["14"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@67f0440}', NULL),
	(67, NULL, NULL, '2018-12-28 09:41:12', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 10, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["变量模板"],"menuUrl":["resource/setting/variable.html"],"nodeLevel":["2"],"parentNodeId":["14"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7b65c27b}', NULL),
	(68, NULL, NULL, '2018-12-28 09:41:34', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["数据源配置"],"menuUrl":["resource/setting/queryDbList.html"],"nodeLevel":["2"],"parentNodeId":["14"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@159dcc95}', NULL),
	(69, NULL, NULL, '2018-12-28 09:42:22', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 13, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":["Hui-iconfont-manage2"],"mark":[""],"menuId":[""],"menuName":["测试工具"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@48103e27}', NULL),
	(70, NULL, NULL, '2018-12-28 09:42:47', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["JSON格式化"],"menuUrl":["resource/util/formatJson.html"],"nodeLevel":["2"],"parentNodeId":["19"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@73561975}', NULL),
	(71, NULL, NULL, '2018-12-28 09:43:07', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["XML格式化"],"menuUrl":["resource/util/formatXml.html"],"nodeLevel":["2"],"parentNodeId":["19"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@2d7f2882}', NULL),
	(72, NULL, NULL, '2018-12-28 09:44:00', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":["Hui-iconfont-shujutongji"],"mark":[""],"menuId":[""],"menuName":["统计报表"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":[""],"seq":["50"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@65000947}', NULL),
	(73, NULL, NULL, '2018-12-28 09:44:26', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["服务调用地图"],"menuUrl":["resource/reporting/callMap.html"],"nodeLevel":["2"],"parentNodeId":["22"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@5d2bdd3e}', NULL),
	(74, NULL, NULL, '2018-12-28 09:44:46', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 7, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["周期报表"],"menuUrl":["nopower.html?v=4"],"nodeLevel":["0"],"parentNodeId":["22"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@154d7fd5}', NULL),
	(75, NULL, NULL, '2018-12-28 09:45:08', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["24"],"menuName":["周期报表"],"menuUrl":["nopower.html?v=4"],"nodeLevel":["2"],"parentNodeId":["22"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@109d41b2}', NULL),
	(76, NULL, NULL, '2018-12-28 09:46:08', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 11, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["配置选项"],"menuUrl":["nopower.html?v=5"],"nodeLevel":["2"],"parentNodeId":[""],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7ed0b299}', NULL),
	(77, NULL, NULL, '2018-12-28 09:46:21', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["25"],"menuName":["配置选项"],"menuUrl":["nopower.html?v=5"],"nodeLevel":["2"],"parentNodeId":["22"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@a9dad93}', NULL),
	(78, NULL, NULL, '2018-12-28 09:53:27', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:51:26"],"createUser.userId":[""],"iconName":["Hui-iconfont-chajian"],"mark":[""],"menuId":[""],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":[""],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@18d6eaf0}', NULL),
	(79, NULL, NULL, '2018-12-28 09:54:13', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 13, '{"createTime":["2018-12-27 20:04:56"],"createUser.userId":["1"],"iconName":["Hui-iconfont-hetong"],"mark":[""],"menuId":["1"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7754164b}', NULL),
	(80, NULL, NULL, '2018-12-28 09:54:31', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 10, '{"createTime":["2018-12-28 09:30:38"],"createUser.userId":["1"],"iconName":["Hui-iconfont-html5"],"mark":[""],"menuId":["9"],"menuName":["高级测试"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@3af68d2c}', NULL),
	(81, NULL, NULL, '2018-12-28 09:54:43', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":["1"],"iconName":["Hui-iconfont-manage"],"mark":[""],"menuId":["14"],"menuName":["测试配置"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@314ccefb}', NULL),
	(82, NULL, NULL, '2018-12-28 09:54:53', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":["1"],"iconName":["Hui-iconfont-manage2"],"mark":[""],"menuId":["19"],"menuName":["测试工具"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1f217441}', NULL),
	(83, NULL, NULL, '2018-12-28 09:54:59', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 9, '{"createTime":["2018-12-28 09:39:00"],"createUser.userId":["1"],"iconName":["Hui-iconfont-shujutongji"],"mark":[""],"menuId":["22"],"menuName":["统计报表"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["50"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@93aa745}', NULL),
	(84, NULL, NULL, '2018-12-28 09:55:03', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 09:51:26"],"createUser.userId":["1"],"iconName":["Hui-iconfont-chajian"],"mark":[""],"menuId":["26"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":["26"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@61df0ea9}', NULL),
	(85, NULL, NULL, '2018-12-28 09:56:11', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 09:54:01"],"createUser.userId":[""],"iconName":["Hui-iconfont-html5"],"mark":[""],"menuId":[""],"menuName":["Web自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":[""],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1bd5becb}', NULL),
	(86, NULL, NULL, '2018-12-28 10:01:01', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 2, '{"createTime":["2018-12-28 09:51:26"],"createUser.userId":["1"],"iconName":["Hui-iconfont-chajian"],"mark":[""],"menuId":["26"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":["26"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@5e5bc9ce}', NULL),
	(87, NULL, NULL, '2018-12-28 10:01:28', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 11, '{"createTime":["2018-12-28 09:51:26"],"createUser.userId":["1"],"iconName":["Hui-iconfont-chajian"],"mark":[""],"menuId":["26"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":[""],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@3ab02261}', NULL),
	(88, NULL, NULL, '2018-12-28 10:02:42', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-moban-2"],"mark":[""],"menuId":[""],"menuName":["web自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["27"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@3f04e3aa}', NULL),
	(89, NULL, NULL, '2018-12-28 10:06:55', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试用例"],"menuUrl":["resource/web/webCase.html"],"nodeLevel":["2"],"parentNodeId":["28"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@77f0c494}', NULL),
	(90, NULL, NULL, '2018-12-28 10:14:13', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 153, '{"createTime":["2018-12-27 20:04:56"],"createUser.userId":["1"],"iconName":["Hui-iconfont-hetong"],"mark":["接口自动化模块"],"menuId":["1"],"menuName":["接口自动化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["26"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1217611f}', NULL),
	(91, NULL, NULL, '2018-12-28 10:15:44', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["元素对象"],"menuUrl":["resource/web/webElementCategory.html"],"nodeLevel":["2"],"parentNodeId":["28"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@2ede54eb}', NULL),
	(92, NULL, NULL, '2018-12-28 10:16:07', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试用例集"],"menuUrl":["resource/web/webSuite.html"],"nodeLevel":["2"],"parentNodeId":["28"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@16a58fb1}', NULL),
	(93, NULL, NULL, '2018-12-28 10:16:29', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试报告"],"menuUrl":["nopower.html?v=9"],"nodeLevel":["2"],"parentNodeId":["28"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@9ca3410}', NULL),
	(94, NULL, NULL, '2018-12-28 10:17:20', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-gongsi"],"mark":["山西移动"],"menuId":[""],"menuName":["定制化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":["27"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@2ab5f7c}', NULL),
	(95, NULL, NULL, '2018-12-28 10:17:26', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":["1"],"iconName":["Hui-iconfont-gongsi"],"mark":["山西移动"],"menuId":["33"],"menuName":["定制化"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["27"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@212e0af}', NULL),
	(96, NULL, NULL, '2018-12-28 10:17:55', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 14, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["自动化模块"],"menuUrl":["resource/webscript/module.html"],"nodeLevel":["2"],"parentNodeId":["33"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@22ce4398}', NULL),
	(97, NULL, NULL, '2018-12-28 10:18:15', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 6, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["任务管理"],"menuUrl":["resource/webscript/task.html"],"nodeLevel":["2"],"parentNodeId":["33"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@6f5430a}', NULL),
	(98, NULL, NULL, '2018-12-28 10:18:46', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-manage2"],"mark":[""],"menuId":[""],"menuName":["自动化配置"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["27"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@c0d5eb}', NULL),
	(99, NULL, NULL, '2018-12-28 10:19:18', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 6, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["测试配置"],"menuUrl":["nopower.html?v=10"],"nodeLevel":["2"],"parentNodeId":["36"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@e2ba598}', NULL),
	(100, NULL, NULL, '2018-12-28 10:22:45', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["执行机"],"menuUrl":["nopower.html?v=11"],"nodeLevel":["2"],"parentNodeId":["36"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@17192078}', NULL),
	(101, NULL, NULL, '2018-12-28 10:23:22', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 10, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["定时任务"],"menuUrl":["nopower.html?v=12"],"nodeLevel":["2"],"parentNodeId":["36"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@4ca350bd}', NULL),
	(102, NULL, NULL, '2018-12-28 10:23:57', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 2, 7, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-dangan"],"mark":[""],"menuId":[""],"menuName":["帮助"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["27"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@723b3cf1}', NULL),
	(103, NULL, NULL, '2018-12-28 10:24:28', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["操作手册"],"menuUrl":["nopower.html?v=13"],"nodeLevel":["2"],"parentNodeId":["40"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@62bada1d}', NULL),
	(104, NULL, NULL, '2018-12-28 10:25:06', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 6, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["易大师UI自动化测试框架"],"menuUrl":["nopower.html?v=14"],"nodeLevel":["2"],"parentNodeId":["40"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1de9a6e5}', NULL),
	(105, NULL, NULL, '2018-12-28 10:25:32', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["资源下载"],"menuUrl":["nopower.html?v=15"],"nodeLevel":["2"],"parentNodeId":["40"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7666428b}', NULL),
	(106, NULL, NULL, '2018-12-28 10:26:26', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 7, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-phone-android"],"mark":[""],"menuId":[""],"menuName":["App自动化"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":[""],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@21e744db}', NULL),
	(107, NULL, NULL, '2018-12-28 10:26:56', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 13, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-system"],"mark":[""],"menuId":[""],"menuName":["平台管理"],"menuUrl":[""],"nodeLevel":["0"],"parentNodeId":[""],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@39c82050}', NULL),
	(108, NULL, NULL, '2018-12-28 10:27:33', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-user-group"],"mark":[""],"menuId":[""],"menuName":["用户角色"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["45"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7fa6911}', NULL),
	(109, NULL, NULL, '2018-12-28 10:27:59', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 10, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["用户管理"],"menuUrl":["resource/user/user.html"],"nodeLevel":["2"],"parentNodeId":["46"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@49d959f9}', NULL),
	(110, NULL, NULL, '2018-12-28 10:28:43', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["角色管理"],"menuUrl":["resource/user/role.html"],"nodeLevel":["2"],"parentNodeId":["46"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@a438d54}', NULL),
	(111, NULL, NULL, '2018-12-28 10:29:14', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 9, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":["Hui-iconfont-manage2"],"mark":[""],"menuId":[""],"menuName":["系统管理"],"menuUrl":[""],"nodeLevel":["1"],"parentNodeId":["45"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@3c2fe567}', NULL),
	(112, NULL, NULL, '2018-12-28 10:30:06', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 7, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["系统接口"],"menuUrl":["resource/system/opInterface.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["10"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@49c7f4ae}', NULL),
	(113, NULL, NULL, '2018-12-28 10:30:24', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 8, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["菜单管理"],"menuUrl":["resource/system/menu.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["20"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@356e7baf}', NULL),
	(114, NULL, NULL, '2018-12-28 10:30:44', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 11, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["系统日志"],"menuUrl":["resource/system/logRecord.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["30"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@4aabf8ea}', NULL),
	(115, NULL, NULL, '2018-12-28 10:31:07', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 6, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["全局配置"],"menuUrl":["resource/system/globalSetting.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["40"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@a483c71}', NULL),
	(116, NULL, NULL, '2018-12-28 10:31:29', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 5, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":[""],"iconName":[""],"mark":[""],"menuId":[""],"menuName":["Web监控"],"menuUrl":["druid/index.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["50"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@275494ae}', NULL),
	(117, NULL, NULL, '2018-12-28 10:39:20', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 18, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["54"],"menuName":["Web监控"],"menuUrl":["druid/index.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["50"],"status":["0"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@4c1a0977}', NULL),
	(118, NULL, NULL, '2018-12-28 10:39:26', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 20, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["54"],"menuName":["Web监控"],"menuUrl":["druid/index.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["50"],"status":["1"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@1d9304da}', NULL),
	(119, NULL, NULL, '2018-12-28 10:41:32', 'menu-edit', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 3, '{"createTime":["2018-12-28 10:01:46"],"createUser.userId":["1"],"iconName":[""],"mark":[""],"menuId":["54"],"menuName":["Web监控"],"menuUrl":["druid/index.html"],"nodeLevel":["2"],"parentNodeId":["49"],"seq":["50"],"status":["1"]}', '{returnCode=0, object=yi.master.business.system.bean.BusiMenuInfo@7d4d6f3b}', NULL),
	(120, 1, 1029, '2018-12-28 16:46:20', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 17, 25, '{"callName":["role-getInterfaceNodes"],"isParent":["false"],"mark":["获取当前所有操作接口，并标记哪些是当前角色拥有的"],"opId":["119"],"opName":["获取所有操作接口"],"parentOpId":["21"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=119, opName=获取所有操作接口, callName=role-getInterfaceNodes, isParent=false, opType=null, mark=获取当前所有操作接口，并标记哪些是当前角色拥有的, status=0, isOwn=null, parentOpId=21, parentOpName=null]}', NULL),
	(121, NULL, NULL, '2018-12-28 17:12:18', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 2, '{}', '{returnCode=7}', NULL),
	(122, NULL, NULL, '2018-12-28 17:12:18', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 71, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-28 16:45:32, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-28 17:12:18.168, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(123, NULL, NULL, '2018-12-28 17:23:06', 'role-updateRoleMenu', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 0, 79, '{"addOpIds":["2,3,4,5,6,7,8,10,11,12,13,15,16,17,18,20,21,23,24,25,29,30,31,32,34,35,37,38,39,41,42,43,47,48,50,51,52,53,54"],"roleId":["5"]}', '{returnCode=0}', NULL),
	(124, 1, 118, '2018-12-28 17:24:49', 'role-del', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 12, 182, '{"id":["5"]}', '{returnCode=0}', NULL),
	(125, NULL, NULL, '2018-12-28 17:25:55', 'role-updateRoleMenu', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 54, '{"addOpIds":["2,3,4,5,6,7,8,10,11,12,13,15,16,17,18,20,21,23,24,25,29,30,31,32,34,35,37,38,39,41,42,43,47,48,50,51,52,53,54"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(126, 1, 123, '2018-12-28 17:26:03', 'role-updateRolePower', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 17, '{"addOpIds":["23"],"roleId":["3"]}', '{returnCode=0}', NULL),
	(127, NULL, NULL, '2018-12-28 17:26:42', 'role-updateRoleMenu', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 47, '{"addOpIds":["2,3,4,5,6,7,8,20,21,29,30,31,32,41,42,43"],"roleId":["3"]}', '{returnCode=0}', NULL),
	(128, 1, 123, '2018-12-28 17:27:39', 'role-updateRolePower', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 25, '{"delOpIds":["23"],"roleId":["3"]}', '{returnCode=0}', NULL),
	(129, 1, 1029, '2018-12-28 17:33:17', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 9, 29, '{"callName":["role-getMenuNodes"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["获取所有菜单信息"],"parentOpId":["21"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=获取所有菜单信息, callName=role-getMenuNodes, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=21, parentOpName=null]}', NULL),
	(130, 1, 1029, '2018-12-28 17:33:28', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 9, 23, '{"callName":["role-getMenuNodes"],"isParent":["false"],"mark":["获取当前所有菜单，并标记哪些是当前角色拥有的"],"opId":["1132"],"opName":["获取所有菜单信息"],"parentOpId":["21"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=1132, opName=获取所有菜单信息, callName=role-getMenuNodes, isParent=false, opType=null, mark=获取当前所有菜单，并标记哪些是当前角色拥有的, status=0, isOwn=null, parentOpId=21, parentOpName=null]}', NULL),
	(131, 1, 1029, '2018-12-28 17:33:47', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 8, 14, '{"callName":["role-updateRoleMenu"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["更新菜单与角色之间的关系"],"parentOpId":["21"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=更新菜单与角色之间的关系, callName=role-updateRoleMenu, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=21, parentOpName=null]}', NULL),
	(132, NULL, NULL, '2018-12-28 18:37:06', 'user-judgeLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 2, '{}', '{returnCode=7}', NULL),
	(133, NULL, NULL, '2018-12-28 18:37:06', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 109, '{"loginIdentification":["f895a4208c3a710cc8febd8887aec352"],"password":[""],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-28 17:31:23, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-28 18:37:05.711, ifNew=atp, realName=超级管理员, loginIdentification=f895a4208c3a710cc8febd8887aec352]}', NULL),
	(134, 1, 1133, '2018-12-28 20:38:19', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 20, '{"delOpIds":["2,3,4,5,6,7,8,20,21"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(135, 1, 1133, '2018-12-28 20:38:40', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 13, '{"delOpIds":["2,3,4,5,6,7,8"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(136, 1, 1133, '2018-12-28 20:38:50', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 9, 13, '{"delOpIds":["2,3,4,5,6,7,8"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(137, 1, 1133, '2018-12-28 20:42:58', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 21, 71, '{"delOpIds":["2,4,20,17,16,15"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(138, 1, 1133, '2018-12-28 20:43:31', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 32, '{"addOpIds":["2,4,15,16,17,20"],"roleId":["1"]}', '{returnCode=0}', NULL),
	(139, 1, 120, '2018-12-28 20:46:48', 'role-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 20, '{"mark":["游客角色，只能查看、执行。"],"roleGroup":["游客"],"roleId":[""],"roleName":["visitor"]}', '{returnCode=0}', NULL),
	(140, 1, 1133, '2018-12-28 20:47:52', 'role-updateRoleMenu', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 44, '{"addOpIds":["2,3,4,5,6,7,8,10,11,12,13,15,16,17,18,20,21,23,24,25,29,30,31,32,34,35,37,38,39,41,42,43,50,51,54,52"],"roleId":["6"]}', '{returnCode=0}', NULL),
	(141, 1, 128, '2018-12-28 20:48:32', 'user-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 14, '{"createTime":[""],"lastLoginTime":[""],"realName":["无聊的测试人员"],"role.roleId":["1"],"status":[""],"userId":[""],"username":["test001"]}', '{returnCode=0}', NULL),
	(142, 1, 128, '2018-12-28 20:48:38', 'user-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 16, '{"createTime":["2018-12-28 20:48:32"],"lastLoginTime":["2018-12-28 20:48:32"],"realName":["无聊的测试人员"],"role.roleId":["6"],"status":["0"],"userId":["2"],"username":["test001"]}', '{returnCode=0}', NULL),
	(143, 1, 1029, '2018-12-28 20:49:27', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 8, '{"callName":["menu"],"isParent":["true"],"mark":[""],"opId":[""],"opName":["用户菜单"],"parentOpId":["13"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=用户菜单, callName=menu, isParent=true, opType=null, mark=, status=0, isOwn=null, parentOpId=13, parentOpName=null]}', NULL),
	(144, 1, 1029, '2018-12-28 20:50:20', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 5, '{"callName":["menu-edit"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["编辑或新增菜单信息"],"parentOpId":["1134"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=编辑或新增菜单信息, callName=menu-edit, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=1134, parentOpName=null]}', NULL),
	(145, 1, 1029, '2018-12-28 20:50:42', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 8, 5, '{"callName":["menu-get"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["获取指定菜单信息"],"parentOpId":["1134"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=获取指定菜单信息, callName=menu-get, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=1134, parentOpName=null]}', NULL),
	(146, 1, 1029, '2018-12-28 20:51:01', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 7, '{"callName":["menu-listAll"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["获取所有菜单信息"],"parentOpId":["1134"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=获取所有菜单信息, callName=menu-listAll, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=1134, parentOpName=null]}', NULL),
	(147, 1, 1029, '2018-12-28 20:51:29', 'op-edit', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 14, '{"callName":["menu-del"],"isParent":["false"],"mark":[""],"opId":[""],"opName":["删除指定菜单信息"],"parentOpId":["1134"],"status":["0"]}', '{returnCode=0, object=OperationInterface [opId=null, opName=删除指定菜单信息, callName=menu-del, isParent=false, opType=null, mark=, status=0, isOwn=null, parentOpId=1134, parentOpName=null]}', NULL),
	(148, 1, 123, '2018-12-28 20:56:52', 'role-updateRolePower', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 58, '{"addOpIds":["23,26,136,137,28,29,31,32,1044,33,133,39,41,43,44,1063,45,47,49,50,1015,1016,51,53,54,56,57,58,60,61,63,64,65,66,68,69,70,72,134,81,83,85,999,1000,1003,1004,1006,1014,1017,1033,1036,1037,1041,1042,91,92,98,97,101,1028,1030,1031,102,104,106,107,108,111,114,1022,1025,1057,1060,1061,115,117,116,119,121,1046,1047,1051,1052,1055,1096,1097,1098,1101,1105,1106,1107,1113,1114,1115,1120,1122,1121,1128,1065,1067,1071,1072,1074,1077,1080,1081,1092,1091,1085,1090"],"roleId":["6"]}', '{returnCode=0}', NULL),
	(149, 1, 123, '2018-12-28 20:57:58', 'role-updateRolePower', '0', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 11, 32, '{"addOpIds":["1137,1136"],"roleId":["6"]}', '{returnCode=0}', NULL),
	(150, NULL, NULL, '2018-12-28 20:58:25', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 18, '{"password":["111111"],"username":["test001"]}', '{msg=, lastLoginTime=2018-12-28 20:48:32, returnCode=0, data=User [userId=2, username=test001, createTime=2018-12-28 20:48:32.0, status=0, lastLoginTime=2018-12-28 20:58:24.882, ifNew=atp, realName=无聊的测试人员, loginIdentification=4453a1a1004f7d9a28a9c21709433abe]}', NULL),
	(151, 2, 24, '2018-12-28 20:58:38', 'interface-checkName', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 0, '{"interfaceId":[""],"interfaceName":["132"]}', NULL, NULL),
	(152, 2, 24, '2018-12-28 20:58:41', 'interface-checkName', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 0, '{"interfaceId":[""],"interfaceName":["1322321"]}', NULL, NULL),
	(153, 2, 1108, '2018-12-28 20:59:28', 'webcase-del', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 6, 0, '{"id":["6"]}', NULL, NULL),
	(154, 2, 1108, '2018-12-28 20:59:32', 'webcase-del', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 0, '{"id":["6"]}', NULL, NULL),
	(155, 2, 1111, '2018-12-28 20:59:37', 'webcase-updateConfig', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 0, '{"caseId":["6"],"configJson":[{"caseVariables":{"2313":"1231"}}]}', NULL, NULL),
	(156, 2, 71, '2018-12-28 21:01:07', 'set-edit', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 5, 0, '{"createTime":["2018-12-28 21:01:02"],"mark":[""],"parentId":["0"],"parented":["0"],"setId":[""],"setName":["32131231"],"status":["0"],"user.userId":[""]}', NULL, NULL),
	(157, 2, 1027, '2018-12-28 21:02:41', 'op-del', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 18, 0, '{"id":["1138"]}', NULL, NULL),
	(158, 2, 1029, '2018-12-28 21:02:45', 'op-edit', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 9, 0, '{"callName":["role-getMenuNodes"],"isParent":["false"],"mark":["获取当前所有菜单，并标记哪些是当前角色拥有的"],"opId":["1132"],"opName":["获取所有菜单信息"],"parentOpId":["21"],"status":["0"]}', NULL, NULL),
	(159, 2, 1135, '2018-12-28 21:03:14', 'menu-edit', '1', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 7, 0, '{"createTime":["2018-12-28 21:02:50"],"createUser.userId":[""],"iconName":["3213"],"mark":[""],"menuId":[""],"menuName":["32131"],"menuUrl":["321"],"nodeLevel":["0"],"parentNodeId":["46"],"seq":["312"],"status":["1"]}', NULL, NULL),
	(160, NULL, NULL, '2018-12-28 21:04:22', 'user-toLogin', '3', '0', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', 1, 22, '{"password":["q708162543"],"username":["admin"]}', '{msg=, lastLoginTime=2018-12-28 20:57:28, returnCode=0, data=User [userId=1, username=admin, createTime=2016-09-18 14:36:06.0, status=0, lastLoginTime=2018-12-28 21:04:21.852, ifNew=atp, realName=超级管理员, loginIdentification=991597cf5658bdf761d0770c66cacddb]}', NULL);
/*!40000 ALTER TABLE `at_log_record` ENABLE KEYS */;

-- 导出  表 atp.at_message 结构
CREATE TABLE IF NOT EXISTS `at_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报文名称',
  `message_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报文格式，xml、json、url、opt、fixed',
  `interface_id` int(11) DEFAULT NULL COMMENT '所属接口',
  `parameter_id` int(11) DEFAULT NULL COMMENT '该字段废弃',
  `complex_parameter_id` int(11) DEFAULT NULL COMMENT '复杂参数组成对象',
  `parameter_json` longtext COLLATE utf8mb4_unicode_ci COMMENT '完整入参报文',
  `call_parameter` text COLLATE utf8mb4_unicode_ci COMMENT '调用参数',
  `request_url` text COLLATE utf8mb4_unicode_ci COMMENT '请求地址的路径，会覆盖在接口中配置的路径',
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态，0 - 正常，1 - 禁用',
  `systems` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属测试环境:测试环境ID集合',
  `last_modify_user` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最近修改的用户名',
  `process_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报文处理类型',
  `process_parameter` text COLLATE utf8mb4_unicode_ci COMMENT '报文处理参数',
  PRIMARY KEY (`message_id`),
  KEY `at_message_fk_interface_id` (`interface_id`),
  KEY `at_message_fk_parameter_id` (`parameter_id`),
  KEY `at_message_fk_user_id` (`user_id`),
  KEY `at_message_fk_complex_parameter_id` (`complex_parameter_id`),
  CONSTRAINT `at_message_fk_complex_parameter_id` FOREIGN KEY (`complex_parameter_id`) REFERENCES `at_complex_parameter` (`id`),
  CONSTRAINT `at_message_fk_interface_id` FOREIGN KEY (`interface_id`) REFERENCES `at_interface_info` (`interface_Id`),
  CONSTRAINT `at_message_fk_parameter_id` FOREIGN KEY (`parameter_id`) REFERENCES `at_parameter` (`parameter_id`),
  CONSTRAINT `at_message_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口下的报文格式信息';

-- 正在导出表  atp.at_message 的数据：~0 rows (大约)
DELETE FROM `at_message`;
/*!40000 ALTER TABLE `at_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_message` ENABLE KEYS */;

-- 导出  表 atp.at_message_scene 结构
CREATE TABLE IF NOT EXISTS `at_message_scene` (
  `message_scene_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `scene_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '场景名称',
  `response_example` text COLLATE utf8mb4_unicode_ci COMMENT '返回示例报文',
  `validate_rule_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `systems` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属测试环境',
  `request_url` text COLLATE utf8mb4_unicode_ci COMMENT '请求路径，覆盖接口和报文中定义的路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`message_scene_id`),
  KEY `at_message_scene_pk_message_id` (`message_id`),
  CONSTRAINT `at_message_scene_pk_message_id` FOREIGN KEY (`message_id`) REFERENCES `at_message` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口自动化测试场景';

-- 正在导出表  atp.at_message_scene 的数据：~0 rows (大约)
DELETE FROM `at_message_scene`;
/*!40000 ALTER TABLE `at_message_scene` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_message_scene` ENABLE KEYS */;

-- 导出  表 atp.at_operation_interface 结构
CREATE TABLE IF NOT EXISTS `at_operation_interface` (
  `op_id` int(11) NOT NULL AUTO_INCREMENT,
  `op_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 名称',
  `call_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用名',
  `is_parent` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否为父节点',
  `op_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作接口类型，默认全部为通用接口',
  `mark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 备注',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前状态，0 - 正常， 1 - 禁用',
  `parent_op_id` int(11) DEFAULT NULL COMMENT '父节点',
  PRIMARY KEY (`op_id`),
  KEY `at_operation_interface_fk_parent_op_id` (`parent_op_id`),
  CONSTRAINT `at_operation_interface_fk_parent_op_id` FOREIGN KEY (`parent_op_id`) REFERENCES `at_operation_interface` (`op_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作接口信息';

-- 正在导出表  atp.at_operation_interface 的数据：~264 rows (大约)
DELETE FROM `at_operation_interface`;
/*!40000 ALTER TABLE `at_operation_interface` DISABLE KEYS */;
INSERT INTO `at_operation_interface` (`op_id`, `op_name`, `call_name`, `is_parent`, `op_type`, `mark`, `status`, `parent_op_id`) VALUES
	(1, '自动化测试平台', '', 'true', NULL, '全局父节点', '0', 1),
	(2, '接口自动化', NULL, 'true', NULL, '接口自动化', '0', 1),
	(3, '接口管理', 'interface', 'true', NULL, '接口管理节点', '0', 2),
	(4, '场景测试管理', 'test', 'true', NULL, '接口测试管理节点', '0', 2),
	(5, '接口参数管理', 'param', 'true', NULL, '接口参数管理节点', '0', 2),
	(6, '报文管理', 'message', 'true', NULL, '报文管理节点', '0', 2),
	(7, '场景管理', 'scene', 'true', NULL, '场景管理节点', '0', 2),
	(8, '测试数据管理', 'data', 'true', NULL, '测试数据管理节点', '0', 2),
	(9, '测试报告管理', 'report', 'true', NULL, '测试报告管理节点', '0', 2),
	(10, '测试结果详情管理', 'result', 'true', NULL, '测试结果详情管理节点', '0', 2),
	(11, '测试集管理', 'set', 'true', NULL, '测试集管理节点', '0', 2),
	(12, '验证规则管理', 'validate', 'true', NULL, '验证规则管理节点', '0', 2),
	(13, '系统设置', NULL, 'true', NULL, '系统设置', '0', 1),
	(14, '定时任务管理', 'task', 'true', NULL, '定时任务管理节点', '0', 13),
	(15, '全局配置管理', 'global', 'true', NULL, '全局配置管理节点', '0', 13),
	(16, '操作接口管理', 'op', 'true', NULL, '操作接口管理节点', '0', 13),
	(17, '查询数据库管理', 'db', 'true', NULL, '查询数据库管理节点', '0', 13),
	(18, '变量模板管理', 'variable', 'true', NULL, '变量模板管理节点', '0', 13),
	(19, '用户角色管理', '', 'true', NULL, '用户管理', '0', 1),
	(20, '我的信息管理', 'mail', 'true', NULL, '我的信息管理节点', '0', 19),
	(21, '角色管理', 'role', 'true', NULL, '角色管理节点', '0', 19),
	(22, '用户管理', 'user', 'true', NULL, '用户管理节点', '0', 19),
	(23, '获取接口列表', 'interface-list', 'false', NULL, '分页获取接口列表', '0', 3),
	(24, '检查接口名是否重复', 'interface-checkName', 'false', NULL, '检查新增或者修改的接口名是否重复', '0', 3),
	(25, '接口信息编辑', 'interface-edit', 'false', NULL, '新增或者编辑指定接口信息', '0', 3),
	(26, '获取指定接口信息', 'interface-get', 'false', NULL, '获取指定接口详细信息', '0', 3),
	(27, '删除接口', 'interface-del', 'false', NULL, '删除指定接口', '0', 3),
	(28, '批量测试', 'test-scenesTest', 'false', NULL, '包含测试集测试、全量测试以及定时自动化中的测试', '0', 4),
	(29, '获取当前用户全局测试配置', 'test-getConfig', 'false', NULL, '用户可查看该测试配置', '0', 4),
	(30, '更新测试配置', 'test-updateConfig', 'false', NULL, '包含全局测试配置和测试集的运行时配置', '0', 4),
	(31, '检查测试数据', 'test-checkHasData', 'false', NULL, '测试之前检查指定的测试集中所有的测试场景是否有足够的测试数据', '0', 4),
	(32, '单场景测试', 'test-sceneTest', 'false', NULL, '单个场景的测试', '0', 4),
	(33, '获取接口的参数', 'param-getParams', 'false', NULL, '获取指定接口的所有入参节点信息', '0', 5),
	(34, '保存参数', 'param-save', 'false', NULL, '保存单个接口入参信息', '0', 5),
	(35, '删除参数', 'param-del', 'false', NULL, '删除指定参数', '0', 5),
	(36, '编辑参数', 'param-edit', 'false', NULL, '编辑指定参数信息', '0', 5),
	(37, '导入报文串入参', 'param-batchImportParams', 'false', NULL, '根据报文串批量导入入参', '0', 5),
	(38, '批量删除', 'param-delInterfaceParams', 'false', NULL, '删除指定接口下的所有入参', '0', 5),
	(39, '获取报文列表', 'message-list', 'false', NULL, '分页获取报文列表', '0', 6),
	(40, '编辑报文信息', 'message-edit', 'false', NULL, '新增或者编辑报文信息', '0', 6),
	(41, '获取指定报文信息', 'message-get', 'false', NULL, '获取指定报文信息', '0', 6),
	(42, '删除报文', 'message-del', 'false', NULL, '删除指定报文', '0', 6),
	(43, '格式化报文串', 'message-format', 'false', NULL, '按照报文格式来美化报文串', '0', 6),
	(44, '报文串验证', 'message-validateJson', 'false', NULL, '验证指定报文串是否满足接口规范', '0', 6),
	(45, '场景列表', 'scene-list', 'false', NULL, '分页获取指定报文下的测试场景列表', '0', 7),
	(46, '场景信息编辑', 'scene-edit', 'false', NULL, '新增或者编辑指定测试场景', '0', 7),
	(47, '获取指定测试场景信息', 'scene-get', 'false', NULL, '获取指定测试场景信息', '0', 7),
	(48, '删除测试场景', 'scene-del', 'false', NULL, '删除指定测试场景', '0', 7),
	(49, '获取单次测试资源', 'scene-getTestObject', 'false', NULL, '获取指定场景的测试地址和测试数据', '0', 7),
	(50, '获取缺少测试数据的场景', 'scene-listNoDataScenes', 'false', NULL, '获取指定测试集中缺少测试数据的测试场景列表', '0', 7),
	(51, '获取当前报文可编辑入参', 'data-getSettingData', 'false', NULL, '获取当前场景所属报文的所有可编辑入参节点 包含其他信息', '0', 8),
	(52, '批量导入数据', 'data-importDatas', 'false', NULL, '批量导入测试数据', '0', 8),
	(53, '获取测试数据列表', 'data-list', 'false', NULL, '分页获取指定场景下的测试数据列表', '0', 8),
	(54, '获取指定测试数据信息', 'data-get', 'false', NULL, '获取指定测试数据信息', '0', 8),
	(55, '删除指定测试数据', 'data-del', 'false', NULL, '删除指定测试数据', '0', 8),
	(56, '检查测试数据标识重复性', 'data-checkName', 'false', NULL, '新增或者编辑时检查测试数据标识是否重复', '0', 8),
	(57, '获取需要设定的参数数据', 'data-getSettingData', 'false', NULL, '获取设置参数数据时需要用到的相关数据', '0', 8),
	(58, '生成报文串', 'data-createDataMsg', 'false', NULL, '根据传入的json数据字符串和场景id生成新得带有数据的报文', '0', 8),
	(59, '编辑测试数据信息', 'data-edit', 'false', NULL, '新增或者编辑测试数据信息', '0', 8),
	(60, '获取测试报告列表', 'report-list', 'false', NULL, '分页获取测试报告列表', '0', 9),
	(61, '获取指定测试报告信息', 'report-get', 'false', NULL, '获取指定测试报告信息', '0', 9),
	(62, '删除测试报告', 'report-del', 'false', NULL, '删除指定测试报告', '0', 9),
	(63, '查看离线测试报告', 'report-generateStaticReportHtml', 'false', NULL, '查看离线测试报告', '0', 9),
	(64, '查看在线测试报告', 'report-getReportDetail', 'false', NULL, '查看动态生成的在线测试报告', '0', 9),
	(65, '获取测试结果详情列表', 'result-list', 'false', NULL, '分页获取测试结果列表', '0', 10),
	(66, '获取指定测试结果详细', 'result-get', 'false', NULL, '获取指定测试结果详情', '0', 10),
	(67, '操作测试集场景', 'set-opScene', 'false', NULL, '添加到测试集或者从测试集删除', '0', 11),
	(68, '获取测试集列表', 'set-getMySet', 'false', NULL, '获取可以测试的测试集列表', '0', 11),
	(69, '展示与指定测试集有关的测试场景', 'set-listScenes', 'false', NULL, '展示存在测试集或者不存在于测试集的测试场景', '0', 11),
	(70, '获取测试集列表', 'set-list', 'false', NULL, '分页获取测试集列表', '0', 11),
	(71, '编辑测试集信息', 'set-edit', 'false', NULL, '新增或者编辑指定测试集信息', '0', 11),
	(72, '获取指定测试集信息', 'set-get', 'false', NULL, '获取指定测试集信息', '0', 11),
	(73, '删除测试集', 'set-del', 'false', NULL, '删除指定测试集', '0', 11),
	(74, '检查测试集名称是否重复', 'set-checkName', 'false', NULL, '新增或者编辑时检查测试集名称是否重复', '0', 11),
	(75, '设定测试集运行时配置', 'set-settingConfig', 'false', NULL, '设定指定测试集的运行时配置(默认还是自定义)', '0', 11),
	(81, '获取全文验证规则', 'validate-getValidate', 'false', NULL, '获取指定测试场景的验证规则(只限全文验证)', '0', 12),
	(82, '更新全文验证规则', 'validate-validateFullEdit', 'false', NULL, '更新全文验证规则', '0', 12),
	(83, '获取验证规则列表', 'validate-getValidates', 'false', NULL, '获取指定场景下的验证规则列表', '0', 12),
	(84, '编辑验证规则信息', 'validate-edit', 'false', NULL, '新增或者编辑验证规则信息', '0', 12),
	(85, '获取指定验证规则信息', 'validate-get', 'false', NULL, '获取指定验证规则信息', '0', 12),
	(86, '删除验证规则信息', 'validate-del', 'false', NULL, '删除指定验证规则信息', '0', 12),
	(87, '更新状态', 'validate-updateValidateStatus', 'false', NULL, '更新验证规则可用状态', '0', 12),
	(88, '验证测试任务是否重名', 'task-checkName', 'false', NULL, '验证测试任务是否重名', '0', 14),
	(89, '编辑定时任务', 'task-edit', 'false', NULL, '编辑定时任务', '0', 14),
	(90, '删除指定定时任务', 'task-del', 'false', NULL, '删除指定定时任务', '0', 14),
	(91, '定时任务列表', 'task-list', 'false', NULL, '定时任务列表', '0', 14),
	(92, '获取指定定时任务信息', 'task-get', 'false', NULL, '获取指定定时任务信息', '0', 14),
	(93, '停止运行中的定时任务', 'task-stopRunningTask', 'false', NULL, '停止运行中的定时任务', '0', 14),
	(94, '运行可运行的定时任务', 'task-startRunableTask', 'false', NULL, '运行可运行的定时任务', '0', 14),
	(95, '开启quartz定时器', 'task-startQuartz', 'false', NULL, '开启quartz定时器', '0', 14),
	(96, '停止quartz定时器', 'task-stopQuartz', 'false', NULL, '停止quartz定时器', '0', 14),
	(97, '获取quartz定时器当前的状态', 'task-getQuartzStatus', 'false', NULL, '获取quartz定时器当前的状态', '0', 14),
	(98, '更新定时规则', 'task-updateCronExpression', 'false', NULL, '更新定时规则', '0', 14),
	(99, '更新全局配置信息', 'global-edit', 'false', NULL, '更新全局配置信息', '0', 15),
	(100, '获取全局配置信息', 'global-listAll', 'false', NULL, '获取全部的全局配置信息', '0', 15),
	(101, '操作接口列表', 'op-listOp', 'false', NULL, '获取操作接口列表', '0', 16),
	(102, '测试指定查询数据库是否可连接', 'db-testDB', 'false', NULL, '测试指定查询数据库是否可连接', '0', 17),
	(103, '删除指定查询数据库信息', 'db-del', 'false', NULL, '删除指定查询数据库信息', '0', 17),
	(104, '查询数据库列表', 'db-list', 'false', NULL, '查询数据库列表', '0', 17),
	(105, '编辑指定查询数据库信息', 'db-edit', 'false', NULL, '编辑指定查询数据库信息', '0', 17),
	(106, '获取指定查询数据库信息', 'db-get', 'false', NULL, '获取指定查询数据库信息', '0', 17),
	(107, '获取所有当前可用的查询数据库信息', 'db-listAll', 'false', NULL, '获取所有当前可用的查询数据库信息', '0', 17),
	(108, '变量模板列表', 'variable-listAll', 'false', NULL, '获取所有变量模板', '0', 18),
	(109, '编辑信息', 'variable-edit', 'false', NULL, '新增或者编辑变量模板信息', '0', 18),
	(110, '删除信息', 'variable-del', 'false', NULL, '删除指定变量模板信息', '0', 18),
	(111, '获取指定变量模板信息', 'variable-get', 'false', NULL, '获取指定变量模板信息', '0', 18),
	(112, '检查Key值是否重复', 'variable-checkName', 'false', NULL, '检查全局变量的Key值是否重复', '0', 18),
	(113, '更新配置数据', 'variable-updateValue', 'false', NULL, '更新配置数据', '0', 18),
	(114, '动态生成变量值', 'variable-createVariable', 'false', NULL, '根据variableType和value生成返回变量', '0', 18),
	(115, '信息列表', 'mail-list', 'false', NULL, '信息列表', '0', 20),
	(116, '删除信息', 'mail-del', 'false', NULL, '删除信息', '0', 20),
	(117, '改变已读状态', 'mail-changeStatus', 'false', NULL, '改变已读状态', '0', 20),
	(118, '删除指定角色信息', 'role-del', 'false', NULL, '删除指定角色信息', '0', 21),
	(119, '获取所有操作接口', 'role-getInterfaceNodes', 'false', NULL, '获取当前所有操作接口，并标记哪些是当前角色拥有的', '0', 21),
	(120, '编辑指定角色信息', 'role-edit', 'false', NULL, '编辑指定角色信息', '0', 21),
	(121, '角色信息列表', 'role-list', 'false', NULL, '角色信息列表', '0', 21),
	(122, '指定角色信息', 'role-get', 'false', NULL, '指定角色信息', '0', 21),
	(123, '更新角色权限信息', 'role-updateRolePower', 'false', NULL, '更新操作接口与角色之间的关系（角色的权限信息）', '0', 21),
	(124, '展示所有角色', 'role-listAll', 'false', NULL, '展示所有角色', '0', 21),
	(125, '用户列表', 'user-list', 'false', NULL, '用户列表', '0', 22),
	(126, '锁定用户或者解锁用户', 'user-lock', 'false', NULL, '锁定用户或者解锁用户', '0', 22),
	(127, '获取用户信息', 'user-get', 'false', NULL, '获取用户信息', '0', 22),
	(128, '编辑用户信息', 'user-edit', 'false', NULL, '新增或者编辑用户信息', '0', 22),
	(129, '重置用户密码', 'user-resetPwd', 'false', NULL, '重置指定用户的密码为111111', '0', 22),
	(130, '从excel导入数据', 'interface-importFromExcel', 'false', NULL, '从上传的Excel中导入接口信息数据', '0', 3),
	(131, '从excel导入数据', 'message-importFromExcel', 'false', NULL, '从上传的Excel中导入报文信息数据', '0', 6),
	(132, '从excel导入数据', 'scene-importFromExcel', 'false', NULL, '从上传的Excel中导入测试场景信息数据', '0', 7),
	(133, '获取指定参数信息', 'param-get', 'false', NULL, '获取指定参数信息', '0', 5),
	(134, '获取测试集目录树', 'set-getCategoryNodes', 'false', NULL, '获取测试集目录树', '0', 11),
	(135, '移动测试集', 'set-moveFolder', 'false', NULL, '将指定测试集移动到指定的目录文件夹下', '0', 11),
	(136, '导出接口文档', 'interface-exportInterfaceDocument', 'false', NULL, '批量导出接口文档', '0', 3),
	(137, '获取节点Tree数据', 'interface-getParametersJsonTree', 'false', NULL, '获取节点Tree数据', '0', 3),
	(138, '修改指定数据状态', 'data-changeStatus', 'false', NULL, '修改指定数据状态', '0', 8),
	(139, '更新场景返回示例', 'scene-updateResponseExample', 'false', NULL, '更新场景返回示例', '0', 7),
	(998, '组合场景管理', 'complexScene', 'true', NULL, '组合场景管理节点', '0', 2),
	(999, '组合场景列表', 'complexScene-list', 'false', NULL, '获取组合场景列表', '0', 998),
	(1000, '获取指定组合场景信息', 'complexScene-get', 'false', NULL, '获取指定组合场景信息', '0', 998),
	(1001, '编辑或新增组合场景', 'complexScene-edit', 'false', NULL, '编辑或新增组合场景', '0', 998),
	(1002, '删除组合场景', 'complexScene-del', 'false', NULL, '删除组合场景', '0', 998),
	(1003, '获取指定测试集的组合场景', 'complexScene-listSetScenes', 'false', NULL, '获取指定测试集的组合场景', '0', 998),
	(1004, '添加组合场景到指定测试集', 'complexScene-addToSet', 'false', NULL, '添加组合场景到指定测试集', '0', 998),
	(1005, '从测试集中删除组合场景', 'complexScene-delFromSet', 'false', NULL, '从测试集中删除组合场景', '0', 998),
	(1006, '获取组合场景中的所有测试场景', 'complexScene-listScenes', 'false', NULL, '获取组合场景中的所有测试场景', '0', 998),
	(1007, '更新配置信息', 'complexScene-updateConfigInfo', 'false', NULL, '更新组合场景的所有配置信息', '0', 998),
	(1008, '添加测试场景到组合场景', 'complexScene-addScene', 'false', NULL, '添加测试场景到组合场景', '0', 998),
	(1009, '从组合场景中删除测试场景', 'complexScene-delScene', 'false', NULL, '从组合场景中删除测试场景', '0', 998),
	(1010, '测试场景执行顺序排序', 'complexScene-sortScenes', 'false', NULL, '测试场景执行顺序排序', '0', 998),
	(1011, '更新指定测试场景的配置信息', 'complexScene-updateSceneConfig', 'false', NULL, '更新指定测试场景的配置信息', '0', 998),
	(1014, '获取组合场景中指定的保存变量名称', 'complexScene-getSaveVariables', 'false', NULL, '获取组合场景中指定的保存变量名称', '0', 998),
	(1015, '获取请求入参节点树信息', 'scene-getRequestMsgJsonTree', 'false', NULL, '获取请求入参节点树信息', '0', 7),
	(1016, '获取返回报文节点树信息', 'scene-getResponseMsgJsonTree', 'false', NULL, '获取返回报文节点树信息', '0', 7),
	(1017, '获取组合场景中指定的保存变量名称', 'complexScene-getSaveVariables', 'false', NULL, '获取组合场景中指定的保存变量名称', '0', 998),
	(1019, '业务系统', 'system', 'true', NULL, '测试环境、业务系统', '0', 13),
	(1020, '编辑或者新增业务系统信息', 'system-edit', 'false', NULL, '', '0', 1019),
	(1022, '获取业务系统信息', 'system-get', 'false', NULL, '', '0', 1019),
	(1023, '查询业务系统列表', 'system-list', 'false', NULL, '', '0', 1019),
	(1024, '删除业务系统信息', 'system-del', 'false', NULL, '', '0', 1019),
	(1025, '查询所有业务系统列表', 'system-listAll', 'false', NULL, '', '0', 1019),
	(1026, '更新接口下属报文场景的业务系统信息', 'interface-updateChildrenBusinessSystems', 'false', NULL, '更新接口下属报文场景的业务系统信息', '0', 3),
	(1027, '删除操作接口', 'op-del', 'false', NULL, '', '0', 16),
	(1028, '获取操作接口详细信息', 'op-get', 'false', NULL, '', '0', 16),
	(1029, '编辑操作接口', 'op-edit', 'false', NULL, '', '0', 16),
	(1030, '获取节点树数据', 'op-getNodeTree', 'false', NULL, '', '0', 16),
	(1031, '获取全部的操作接口', 'op-listAll', 'false', NULL, '', '0', 16),
	(1032, '接口探测', 'probe', 'true', NULL, '接口探测任务', '0', 2),
	(1033, '获取指定探测任务信息', 'probe-get', 'false', NULL, '获取指定探测任务信息', '0', 1032),
	(1034, '编辑或者新增探测任务', 'probe-edit', 'false', NULL, '编辑或者新增探测任务', '0', 1032),
	(1035, '删除探测任务信息', 'probe-del', 'false', NULL, '删除探测任务信息', '0', 1032),
	(1036, '获取所有探测任务信息', 'probe-listAll', 'false', NULL, '获取所有探测任务信息', '0', 1032),
	(1037, '分页获取探测任务列表', 'probe-list', 'false', NULL, '分页获取探测任务列表', '0', 1032),
	(1038, '更新探测任务配置信息', 'probe-updateConfig', 'false', NULL, '更新探测任务配置信息', '0', 1032),
	(1039, '开启探测任务', 'probe-startTask', 'false', NULL, '', '0', 1032),
	(1040, '停止探测任务', 'probe-stopTask', 'false', NULL, '停止探测任务', '0', 1032),
	(1041, '获取单个探测接口的报表数据', 'probe-getProbeResultReportData', 'false', NULL, '获取单个探测接口的报表数据', '0', 1032),
	(1042, '获取探测总览视图数据', 'probe-getProbeResultSynopsisViewData', 'false', NULL, '获取探测总览视图数据', '0', 1032),
	(1043, '批量添加探测任务', 'probe-batchAdd', 'false', NULL, '批量添加探测任务', '0', 1032),
	(1044, '组合场景单个测试', 'test-complexSceneTest', 'false', NULL, '组合场景单个测试', '0', 4),
	(1045, '文件上传下载管理', '', 'true', NULL, '', '0', 1),
	(1046, '文件上传', 'file-upload', 'false', NULL, '', '0', 1045),
	(1047, '文件下载', 'file-download', 'false', NULL, '', '0', 1045),
	(1048, 'Web自动化', '', 'true', NULL, '', '0', 1),
	(1049, '模块管理', 'webModule', 'true', NULL, '', '0', 1094),
	(1050, '测试任务管理', 'webTask', 'true', NULL, '', '0', 1094),
	(1051, '查询所有模块信息', 'webModule-list', 'false', NULL, '', '0', 1049),
	(1052, '获取指定模块信息', 'webModule-get', 'false', NULL, '', '0', 1049),
	(1053, '删除指定模块', 'webModule-del', 'false', NULL, '', '0', 1049),
	(1054, '更新指定模块信息', 'webModule-edit', 'false', NULL, '', '0', 1049),
	(1055, '获取所有测试任务信息', 'webTask-list', 'false', NULL, '', '0', 1050),
	(1056, '删除指定测试任务信息', 'webTask-del', 'false', NULL, '', '0', 1050),
	(1057, '查询业务系统包含或者不包含的所有接口', 'system-listInterface', 'false', NULL, '根据mode来查询当前业务系统包含的或者不包含的接口信息', '0', 1019),
	(1058, '业务系统删除或者增加接口信息', 'system-opInterface', 'false', NULL, '从指定的业务系统中删除或者增加接口信息', '0', 1019),
	(1059, '操作日志记录管理', 'log', 'true', NULL, '', '0', 13),
	(1060, '获取操作日志列表', 'log-list', 'false', NULL, '', '0', 1059),
	(1061, '获取指定操作日志信息', 'log-get', 'false', NULL, '', '0', 1059),
	(1062, '删除指定操作日志信息', 'log-del', 'false', NULL, '', '0', 1059),
	(1063, '根据节点信息创建报文', 'message-createMessage', 'false', NULL, '根据节点信息创建不同格式的报文', '0', 6),
	(1064, '接口mock', 'mock', 'true', NULL, '', '0', 1),
	(1065, '获取mock接口列表', 'mock-list', 'false', NULL, '', '0', 1064),
	(1066, '编辑mock接口基本信息', 'mock-edit', 'false', NULL, '', '0', 1064),
	(1067, '获取mock接口基本信息', 'mock-get', 'false', NULL, '', '0', 1064),
	(1068, '删除指定mock接口信息', 'mock-del', 'false', NULL, '', '0', 1064),
	(1069, '更新mock的状态', 'mock-updateStatus', 'false', NULL, '', '0', 1064),
	(1070, '更新mock规则', 'mock-updateSetting', 'false', NULL, '', '0', 1064),
	(1071, '解析示例报文为生成规则', 'mock-parseMessageToConfig', 'false', NULL, '', '0', 1064),
	(1072, '解析示例报文为NodeTree节点数据', 'mock-parseMessageToNodes', 'false', NULL, '', '0', 1064),
	(1073, '性能测试配置管理', 'ptc', 'true', NULL, '', '0', 1079),
	(1074, '获取性能测试配置列表', 'ptc-list', 'false', NULL, '', '0', 1073),
	(1075, '删除性能测试配置', 'ptc-del', 'false', NULL, '', '0', 1073),
	(1076, '编辑性能测试配置信息', 'ptc-edit', 'false', NULL, '', '0', 1073),
	(1077, '获取指定性能测试配置信息', 'ptc-get', 'false', NULL, '', '0', 1073),
	(1078, '性能测试结果管理', 'ptr', 'true', NULL, '', '0', 1079),
	(1079, '性能测试', 'pt', 'true', NULL, '', '0', 1),
	(1080, '获取性能测试结果列表', 'ptr-list', 'false', NULL, '', '0', 1078),
	(1081, '获取指定性能测试结果信息', 'ptr-get', 'false', NULL, '', '0', 1078),
	(1082, '删除性能测试结果', 'ptr-del', 'false', NULL, '', '0', 1078),
	(1083, '更新性能测试配置', 'ptc-updateSetting', 'false', NULL, '', '0', 1073),
	(1084, '性能测试执行', 'ptc', 'true', NULL, '', '0', 1079),
	(1085, '获取当前用户的性能测试任务列表', 'ptc-listTest', 'false', NULL, '', '0', 1084),
	(1086, '停止指定性能测试任务', 'ptc-stopTest', 'false', NULL, '', '0', 1084),
	(1087, '删除指定性能测试任务', 'ptc-delTest', 'false', NULL, '被删除的性能测试任务不会保存本次测试结果', '0', 1084),
	(1088, '初始化性能测试任务', 'ptc-initTest', 'false', NULL, '包括初始化配置、加载配置文件、预加载请求报文等', '0', 1084),
	(1089, '开始执行性能测试任务', 'ptc-actionTest', 'false', NULL, '初始化正常的测试任务才能被执行', '0', 1084),
	(1090, '查看性能测试的数据视图', 'ptc-viewTest', 'false', NULL, '', '0', 1084),
	(1091, '从测试结果中获取视图数据', 'ptr-anaylzeView', 'false', NULL, '', '0', 1078),
	(1092, '汇总测试结果到excel下载', 'ptr-summarizedView', 'false', NULL, '', '0', 1078),
	(1093, '邮件推送离线报告', 'report-sendMail', 'false', NULL, '', '0', 9),
	(1094, '本地化-山西', 'web', 'true', NULL, '', '0', 1048),
	(1095, '元素对象管理', 'web/element', 'true', NULL, '', '0', 1048),
	(1096, '获取全部的元素对象信息', 'element-listAll', 'false', NULL, '', '0', 1095),
	(1097, '分页获取元素对象信息', 'element-list', 'false', NULL, '', '0', 1095),
	(1098, '获取指定的元素对象信息', 'element-get', 'false', NULL, '', '0', 1095),
	(1099, '删除指定的元素对象信息', 'element-del', 'false', NULL, '', '0', 1095),
	(1100, '创建或编辑元素对象信息', 'element-edit', 'false', NULL, '', '0', 1095),
	(1101, '获取节点树数据', 'element-getNodes', 'false', NULL, '', '0', 1095),
	(1102, '将元素移动到指定的页面下', 'element-move', 'false', NULL, '', '0', 1095),
	(1103, '复制元素到指定的页面下', 'element-copy', 'false', NULL, '', '0', 1095),
	(1104, '测试用例管理', 'webcase', 'true', NULL, '', '0', 1048),
	(1105, '获取全部的测试用例信息', 'webcase-listAll', 'false', NULL, '', '0', 1104),
	(1106, '分页获取测试用例信息', 'webcase-list', 'false', NULL, '', '0', 1104),
	(1107, '获取指定的测试用例信息', 'webcase-get', 'false', NULL, '', '0', 1104),
	(1108, '删除指定的测试用例信息', 'webcase-del', 'false', NULL, '', '0', 1104),
	(1109, '新增或编辑测试用例', 'webcase-edit', 'false', NULL, '', '0', 1104),
	(1110, '修改指定测试用例的运行浏览器', 'webcase-changeBroswerType', 'false', NULL, '', '0', 1104),
	(1111, '更新指定测试用例的配置信息', 'webcase-updateConfig', 'false', NULL, '', '0', 1104),
	(1112, '测试步骤管理', 'webstep', 'true', NULL, '', '0', 1048),
	(1113, '获取指定测试用例下全部测试步骤', 'webstep-listAll', 'false', NULL, '', '0', 1112),
	(1114, '分页获取指定测试用例下的测试步骤', 'webstep-list', 'false', NULL, '', '0', 1112),
	(1115, '获取指定测试步骤信息', 'webstep-get', 'false', NULL, '', '0', 1112),
	(1116, '删除指定测试步骤', 'webstep-del', 'false', NULL, '', '0', 1112),
	(1117, '新增或编辑测试步骤', 'webstep-edit', 'false', NULL, '', '0', 1112),
	(1118, '更新测试步骤配置信息', 'webstep-updateConfig', 'false', NULL, '', '0', 1112),
	(1119, '测试用例集管理', 'websuite', 'true', NULL, '', '0', 1048),
	(1120, '获取全部测试用例集列表', 'websuite-listAll', 'false', NULL, '', '0', 1119),
	(1121, '分页获取测试用例集列表', 'websuite-list', 'false', NULL, '', '0', 1119),
	(1122, '获取指定测试用例集信息', 'websuite-get', 'false', NULL, '', '0', 1119),
	(1123, '新增或者编辑测试用例集', 'websuite-edit', 'false', NULL, '', '0', 1119),
	(1124, '删除指定测试用例集', 'websuite-del', 'false', NULL, '', '0', 1119),
	(1125, '变更测试用例集的默认运行浏览器', 'websuite-changeBroswerType', 'false', NULL, '', '0', 1119),
	(1126, '更新指定用例集的自定义配置', 'websuite-updateConfig', 'false', NULL, '', '0', 1119),
	(1127, '运行时配置', 'webconfig', 'true', NULL, '', '0', 1048),
	(1128, '获取指定配置信息', 'webconfig-get', 'false', NULL, '', '0', 1127),
	(1129, '更新指定配置信息', 'webconfig-edit', 'false', NULL, '', '0', 1127),
	(1130, '增加或者删除用例到用例集中', 'websuite-opCase', 'false', NULL, '', '0', 1119),
	(1131, '更新用例集用例的配置信息', 'websuite-updateCaseSetting', 'false', NULL, '', '0', 1119),
	(1132, '获取所有菜单信息', 'role-getMenuNodes', 'false', NULL, '获取当前所有菜单，并标记哪些是当前角色拥有的', '0', 21),
	(1133, '更新菜单与角色之间的关系', 'role-updateRoleMenu', 'false', NULL, '', '0', 21),
	(1134, '用户菜单', 'menu', 'true', NULL, '', '0', 13),
	(1135, '编辑或新增菜单信息', 'menu-edit', 'false', NULL, '', '0', 1134),
	(1136, '获取指定菜单信息', 'menu-get', 'false', NULL, '', '0', 1134),
	(1137, '获取所有菜单信息', 'menu-listAll', 'false', NULL, '', '0', 1134),
	(1138, '删除指定菜单信息', 'menu-del', 'false', NULL, '', '0', 1134);
/*!40000 ALTER TABLE `at_operation_interface` ENABLE KEYS */;

-- 导出  表 atp.at_parameter 结构
CREATE TABLE IF NOT EXISTS `at_parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_identify` text COLLATE utf8mb4_unicode_ci COMMENT '参数标识',
  `parameter_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数名',
  `default_value` text COLLATE utf8mb4_unicode_ci COMMENT '默认值',
  `path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数路径，从根节点开始，例如ROOT.PATH.NAME，不包含自身节点名称',
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型，Map List Array Number String',
  `attributes` text COLLATE utf8mb4_unicode_ci COMMENT '节点属性，json格式保存',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `interface_id` int(11) DEFAULT NULL COMMENT ' 所属接口',
  PRIMARY KEY (`parameter_id`),
  KEY `at_parameter_fk_interface_id` (`interface_id`),
  CONSTRAINT `at_parameter_fk_interface_id` FOREIGN KEY (`interface_id`) REFERENCES `at_interface_info` (`interface_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3427 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口参数信息表';

-- 正在导出表  atp.at_parameter 的数据：~39 rows (大约)
DELETE FROM `at_parameter`;
/*!40000 ALTER TABLE `at_parameter` DISABLE KEYS */;
INSERT INTO `at_parameter` (`parameter_id`, `parameter_identify`, `parameter_name`, `default_value`, `path`, `type`, `attributes`, `mark`, `interface_id`) VALUES
	(1, '', '', '', '', 'Object', NULL, NULL, NULL),
	(2, '', '', '', '', 'Array_array', NULL, NULL, NULL),
	(3, '', '', '', '', 'Array_map', NULL, NULL, NULL),
	(2393, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2394, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2395, '28   10045099000001200001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2396, '28   10094099000001300001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2397, '2f   20801099000001400001013675181286~1~201611;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2398, '28   10033099000001500001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2399, '28   10037099000001600001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2400, '28   10076099000001700001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2401, '28   20014099000001800001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2402, '28   20022099000001900001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2403, '28   20027099000002000001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2404, '28   20046099000002100001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2405, '28   20125099000002200001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2406, '28   20126099000002300001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2407, '28   20342099000002400001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2408, '28   20401099000002500001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2409, '28   20604099000002600001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2410, '28   20888099000002700001013675181286~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2411, '{\r\n"ROOT":{\r\n"ROUTE_NO":"13505501356",\r\n"CHANNEL_TYPE":"31a",\r\n"PHONE_NO":"13505501356",\r\n"LOGIN_NO":"Y18600TCH"\r\n}\r\n}', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2768, '10008;13675181286~100866~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2769, '10008;13675181286~100866~1;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2770, '5002;13675181286~14;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(2771, '5004;13675181286~14;', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3110, '<?xml version="1.0" encoding="UTF-8"?>\r\n<InterBOSS>\r\n  <SvcCont><![CDATA[<?xml version=\'1.0\' encoding=\'UTF-8\'?>\r\n  <RealFeeQryReq>\r\n  <IDType>01</IDType>\r\n  <IDItemRange>15851740243</IDItemRange>\r\n  <BizType>69</BizType>\r\n  <OprNumb>UMMPBIP3A20120161027103750293250</OprNumb>\r\n  <IdentCode>392c4ff582984c9b9474016e6a8e3dbd</IdentCode>\r\n  </RealFeeQryReq>]]>\r\n  </SvcCont>\r\n</InterBOSS>', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3115, '<?xml version="1.0" encoding="GBK"?>\n\n<InterBOSS> \n  <SvcCont><![CDATA[<?xml version=\'1.0\' encoding=\'UTF-8\'?>\n  <RealFeeQryReq>\n  <IDType>01</IDType>\n  <IDItemRange>15851740243</IDItemRange>\n  <BizType>69</BizType>\n  <OprNumb>UMMPBIP3A20120161027103750293250</OprNumb>\n  <IdentCode>392c4ff582984c9b9474016e6a8e3dbd</IdentCode>\n  </RealFeeQryReq>]]> </SvcCont> \n</InterBOSS>\n', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3362, 'sdadasdasda', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3363, 'sdadasdasda', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3397, '{\n"code":200,\n"errorMsg":""\n"id":987,\n"name":"xuwangcheng",\n"age":28,\n"profession":"性能测试工程师",\n"salary":2587\n}', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3398, '{\n"code":200,\n"errorMsg":""\n"id":987,\n"name":"xuwangcheng",\n"age":28,\n"profession":"性能测试工程师",\n"salary":2587\n}', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3399, '{\n"code":200,\n"errorMsg":""\n"id":987,\n"name":"xuwangcheng",\n"age":28,\n"profession":"性能测试工程师",\n"salary":2587\n}', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3421, '31231', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3422, '', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3423, '', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3424, '', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3425, '', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL),
	(3426, '', 'name', 'defaultValue', 'path', 'String', NULL, NULL, NULL);
/*!40000 ALTER TABLE `at_parameter` ENABLE KEYS */;

-- 导出  表 atp.at_performance_test_config 结构
CREATE TABLE IF NOT EXISTS `at_performance_test_config` (
  `pt_id` int(11) NOT NULL AUTO_INCREMENT,
  `pt_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称：默认为 场景名_测试环境名_线程数',
  `message_scene_id` int(11) DEFAULT NULL COMMENT '关联测试场景，相关默认数据、测试配置等均使用此场景关联内容',
  `system_id` int(11) DEFAULT NULL COMMENT '关联测试环境',
  `keep_alive` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否保持长连接测试，0-短连接，1-保持长连接',
  `thread_count` int(5) DEFAULT '1' COMMENT '测试线程数，范围1 - 99（防止线程太大出现不可控情况,后期改进测试核心代码再解除限制）',
  `parameterized_file_path` varchar(1200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数化文件路径：文件格式，',
  `parameter_reuse` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数是否可复用，0-不可复用，1-可复用',
  `parameter_pick_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数取值规则，0 - 按顺序取值，1 - 随机取值',
  `format_character` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数化文件格式化分隔符,默认为英文下的逗号',
  `max_count` int(11) DEFAULT NULL COMMENT '最大请求次数，多线程测试将会平分这个值',
  `max_time` int(11) DEFAULT NULL COMMENT ' 最大持续时间单位秒，从第一个线程开始启动计算时间，达到最大时间之后打上停止标记并开始停止各线程',
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`pt_id`),
  KEY `ptc_fk_message_scene_id` (`message_scene_id`),
  KEY `ptc_fk_system_id` (`system_id`),
  KEY `ptc_fk_user_id` (`user_id`),
  CONSTRAINT `ptc_fk_message_scene_id` FOREIGN KEY (`message_scene_id`) REFERENCES `at_message_scene` (`message_scene_id`),
  CONSTRAINT `ptc_fk_system_id` FOREIGN KEY (`system_id`) REFERENCES `at_business_system` (`system_id`),
  CONSTRAINT `ptc_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口性能测试配置';

-- 正在导出表  atp.at_performance_test_config 的数据：~0 rows (大约)
DELETE FROM `at_performance_test_config`;
/*!40000 ALTER TABLE `at_performance_test_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_performance_test_config` ENABLE KEYS */;

-- 导出  表 atp.at_performance_test_result 结构
CREATE TABLE IF NOT EXISTS `at_performance_test_result` (
  `pt_result_id` int(11) NOT NULL AUTO_INCREMENT,
  `pt_id` int(11) DEFAULT NULL COMMENT '关联性能测试配置',
  `interface_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口名称：包含报文名和场景名称',
  `system_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试环境名称',
  `thread_count` int(5) DEFAULT NULL COMMENT '实际启用的最大线程数',
  `parameterized_file_path` varchar(1200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数化文件路径（快照文件，与配置中的文件可能会不一样）',
  `start_time` datetime DEFAULT NULL COMMENT ' 测试开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '测试结束时间',
  `finish_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束标志:Y-已结束  N-未结束',
  `request_count` int(11) DEFAULT NULL COMMENT '实际请求总次数',
  `test_time` int(11) DEFAULT NULL COMMENT '实际测试时间,从第一个线程启动开始计算到最后一个线程关闭',
  `details_result_file_path` varchar(1200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结果详情文件，序列化,包含为TestResult对象',
  `analyze_result_json` longtext COLLATE utf8mb4_unicode_ci COMMENT '细分析结果内容,json串保存,可转换为PerformanceTestAnalyzeResult对象',
  `user_id` int(11) DEFAULT NULL COMMENT '测试用户',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`pt_result_id`),
  KEY `ptr_fk_user_id` (`user_id`),
  KEY `ptr_fk_pt_id` (`pt_id`),
  CONSTRAINT `ptr_fk_pt_id` FOREIGN KEY (`pt_id`) REFERENCES `at_performance_test_config` (`pt_id`),
  CONSTRAINT `ptr_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='性能测试结果详情';

-- 正在导出表  atp.at_performance_test_result 的数据：~0 rows (大约)
DELETE FROM `at_performance_test_result`;
/*!40000 ALTER TABLE `at_performance_test_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_performance_test_result` ENABLE KEYS */;

-- 导出  表 atp.at_role 结构
CREATE TABLE IF NOT EXISTS `at_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_group` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色组名称',
  `role_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色名',
  `mark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息';

-- 正在导出表  atp.at_role 的数据：~3 rows (大约)
DELETE FROM `at_role`;
/*!40000 ALTER TABLE `at_role` DISABLE KEYS */;
INSERT INTO `at_role` (`role_id`, `role_group`, `role_name`, `mark`) VALUES
	(1, '管理员', 'admin', 'admin'),
	(3, '普通用户', 'default', '默认组,不能删除'),
	(6, '游客', 'visitor', '游客角色，只能查看、执行。');
/*!40000 ALTER TABLE `at_role` ENABLE KEYS */;

-- 导出  表 atp.at_role_menu 结构
CREATE TABLE IF NOT EXISTS `at_role_menu` (
  `role_Id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_Id`,`menu_id`),
  KEY `FK_at_role_menu_at_busi_menu_info` (`menu_id`),
  CONSTRAINT `FK_at_role_menu_at_role` FOREIGN KEY (`role_Id`) REFERENCES `at_role` (`role_id`),
  CONSTRAINT `FK_at_role_menu_at_busi_menu_info` FOREIGN KEY (`menu_id`) REFERENCES `at_busi_menu_info` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色菜单关联表';

-- 正在导出表  atp.at_role_menu 的数据：~0 rows (大约)
DELETE FROM `at_role_menu`;
/*!40000 ALTER TABLE `at_role_menu` DISABLE KEYS */;
INSERT INTO `at_role_menu` (`role_Id`, `menu_id`) VALUES
	(1, 2),
	(3, 2),
	(6, 2),
	(1, 3),
	(3, 3),
	(6, 3),
	(1, 4),
	(3, 4),
	(6, 4),
	(1, 5),
	(3, 5),
	(6, 5),
	(1, 6),
	(3, 6),
	(6, 6),
	(1, 7),
	(3, 7),
	(6, 7),
	(1, 8),
	(3, 8),
	(6, 8),
	(1, 10),
	(6, 10),
	(1, 11),
	(6, 11),
	(1, 12),
	(6, 12),
	(1, 13),
	(6, 13),
	(1, 15),
	(6, 15),
	(1, 16),
	(6, 16),
	(1, 17),
	(6, 17),
	(1, 18),
	(6, 18),
	(1, 20),
	(3, 20),
	(6, 20),
	(1, 21),
	(3, 21),
	(6, 21),
	(1, 23),
	(6, 23),
	(1, 24),
	(6, 24),
	(1, 25),
	(6, 25),
	(1, 29),
	(3, 29),
	(6, 29),
	(1, 30),
	(3, 30),
	(6, 30),
	(1, 31),
	(3, 31),
	(6, 31),
	(1, 32),
	(3, 32),
	(6, 32),
	(1, 34),
	(6, 34),
	(1, 35),
	(6, 35),
	(1, 37),
	(6, 37),
	(1, 38),
	(6, 38),
	(1, 39),
	(6, 39),
	(1, 41),
	(3, 41),
	(6, 41),
	(1, 42),
	(3, 42),
	(6, 42),
	(1, 43),
	(3, 43),
	(6, 43),
	(1, 47),
	(1, 48),
	(1, 50),
	(6, 50),
	(1, 51),
	(6, 51),
	(1, 52),
	(6, 52),
	(1, 53),
	(1, 54),
	(6, 54);
/*!40000 ALTER TABLE `at_role_menu` ENABLE KEYS */;

-- 导出  表 atp.at_role_power 结构
CREATE TABLE IF NOT EXISTS `at_role_power` (
  `role_id` int(11) NOT NULL DEFAULT '0',
  `op_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`op_id`),
  KEY `at_role_power_fk_op_id` (`op_id`),
  CONSTRAINT `at_role_power_fk_op_id` FOREIGN KEY (`op_id`) REFERENCES `at_operation_interface` (`op_id`) ON DELETE CASCADE,
  CONSTRAINT `at_role_power_fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `at_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色与权限关联表';

-- 正在导出表  atp.at_role_power 的数据：~380 rows (大约)
DELETE FROM `at_role_power`;
/*!40000 ALTER TABLE `at_role_power` DISABLE KEYS */;
INSERT INTO `at_role_power` (`role_id`, `op_id`) VALUES
	(1, 23),
	(6, 23),
	(1, 24),
	(1, 25),
	(1, 26),
	(6, 26),
	(1, 27),
	(1, 28),
	(6, 28),
	(1, 29),
	(6, 29),
	(1, 30),
	(1, 31),
	(6, 31),
	(1, 32),
	(6, 32),
	(1, 33),
	(6, 33),
	(1, 34),
	(1, 35),
	(1, 36),
	(1, 37),
	(1, 38),
	(1, 39),
	(6, 39),
	(1, 40),
	(1, 41),
	(6, 41),
	(1, 42),
	(1, 43),
	(6, 43),
	(1, 44),
	(6, 44),
	(1, 45),
	(6, 45),
	(1, 46),
	(1, 47),
	(6, 47),
	(1, 48),
	(1, 49),
	(6, 49),
	(1, 50),
	(6, 50),
	(1, 51),
	(6, 51),
	(1, 52),
	(1, 53),
	(6, 53),
	(1, 54),
	(6, 54),
	(1, 55),
	(1, 56),
	(6, 56),
	(1, 57),
	(6, 57),
	(1, 58),
	(6, 58),
	(1, 59),
	(1, 60),
	(6, 60),
	(1, 61),
	(6, 61),
	(1, 62),
	(1, 63),
	(6, 63),
	(1, 64),
	(6, 64),
	(1, 65),
	(6, 65),
	(1, 66),
	(6, 66),
	(1, 67),
	(1, 68),
	(6, 68),
	(1, 69),
	(6, 69),
	(1, 70),
	(6, 70),
	(1, 71),
	(1, 72),
	(6, 72),
	(1, 73),
	(1, 74),
	(1, 75),
	(1, 81),
	(6, 81),
	(1, 82),
	(1, 83),
	(6, 83),
	(1, 84),
	(1, 85),
	(6, 85),
	(1, 86),
	(1, 87),
	(1, 88),
	(1, 89),
	(1, 90),
	(1, 91),
	(6, 91),
	(1, 92),
	(6, 92),
	(1, 93),
	(1, 94),
	(1, 95),
	(1, 96),
	(1, 97),
	(6, 97),
	(1, 98),
	(6, 98),
	(1, 99),
	(1, 100),
	(1, 101),
	(6, 101),
	(1, 102),
	(6, 102),
	(1, 103),
	(1, 104),
	(6, 104),
	(1, 105),
	(1, 106),
	(6, 106),
	(1, 107),
	(6, 107),
	(1, 108),
	(6, 108),
	(1, 109),
	(1, 110),
	(1, 111),
	(6, 111),
	(1, 112),
	(1, 113),
	(1, 114),
	(6, 114),
	(1, 115),
	(6, 115),
	(1, 116),
	(6, 116),
	(1, 117),
	(6, 117),
	(1, 118),
	(1, 119),
	(6, 119),
	(1, 120),
	(1, 121),
	(6, 121),
	(1, 122),
	(1, 123),
	(1, 124),
	(1, 125),
	(1, 126),
	(1, 127),
	(1, 128),
	(1, 129),
	(1, 130),
	(1, 131),
	(1, 132),
	(1, 133),
	(6, 133),
	(1, 134),
	(6, 134),
	(1, 135),
	(1, 136),
	(6, 136),
	(1, 137),
	(6, 137),
	(1, 138),
	(1, 139),
	(1, 999),
	(6, 999),
	(1, 1000),
	(6, 1000),
	(1, 1001),
	(1, 1002),
	(1, 1003),
	(6, 1003),
	(1, 1004),
	(6, 1004),
	(1, 1005),
	(1, 1006),
	(6, 1006),
	(1, 1007),
	(1, 1008),
	(1, 1009),
	(1, 1010),
	(1, 1011),
	(1, 1014),
	(6, 1014),
	(1, 1015),
	(6, 1015),
	(1, 1016),
	(6, 1016),
	(1, 1017),
	(6, 1017),
	(1, 1020),
	(1, 1022),
	(6, 1022),
	(1, 1023),
	(1, 1024),
	(1, 1025),
	(6, 1025),
	(1, 1026),
	(1, 1027),
	(1, 1028),
	(6, 1028),
	(1, 1029),
	(1, 1030),
	(6, 1030),
	(1, 1031),
	(6, 1031),
	(1, 1033),
	(6, 1033),
	(1, 1034),
	(1, 1035),
	(1, 1036),
	(6, 1036),
	(1, 1037),
	(6, 1037),
	(1, 1038),
	(1, 1039),
	(1, 1040),
	(1, 1041),
	(6, 1041),
	(1, 1042),
	(6, 1042),
	(1, 1043),
	(1, 1044),
	(6, 1044),
	(1, 1046),
	(6, 1046),
	(1, 1047),
	(6, 1047),
	(1, 1051),
	(6, 1051),
	(1, 1052),
	(6, 1052),
	(1, 1053),
	(1, 1054),
	(1, 1055),
	(6, 1055),
	(1, 1056),
	(1, 1057),
	(6, 1057),
	(1, 1058),
	(1, 1060),
	(6, 1060),
	(1, 1061),
	(6, 1061),
	(1, 1062),
	(1, 1063),
	(6, 1063),
	(1, 1065),
	(6, 1065),
	(1, 1066),
	(1, 1067),
	(6, 1067),
	(1, 1068),
	(1, 1069),
	(1, 1070),
	(1, 1071),
	(6, 1071),
	(1, 1072),
	(6, 1072),
	(1, 1074),
	(6, 1074),
	(1, 1075),
	(1, 1076),
	(1, 1077),
	(6, 1077),
	(1, 1080),
	(6, 1080),
	(1, 1081),
	(6, 1081),
	(1, 1082),
	(1, 1083),
	(1, 1085),
	(6, 1085),
	(1, 1086),
	(1, 1087),
	(1, 1088),
	(1, 1089),
	(1, 1090),
	(6, 1090),
	(1, 1091),
	(6, 1091),
	(1, 1092),
	(6, 1092),
	(6, 1096),
	(6, 1097),
	(6, 1098),
	(6, 1101),
	(6, 1105),
	(6, 1106),
	(6, 1107),
	(6, 1113),
	(6, 1114),
	(6, 1115),
	(6, 1120),
	(6, 1121),
	(6, 1122),
	(6, 1128),
	(6, 1136),
	(6, 1137);
/*!40000 ALTER TABLE `at_role_power` ENABLE KEYS */;

-- 导出  表 atp.at_scene_validate_rule 结构
CREATE TABLE IF NOT EXISTS `at_scene_validate_rule` (
  `validate_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_scene_id` int(11) DEFAULT NULL COMMENT '所属测试场景',
  `parameter_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '根据validate_method_flag的值有不同的含义：validate_method_flag=0时，其为取值的json串，例如：{"LB":"ss","RB":"vv","ORDER":1},分别表示左边界、右边界、取值顺序，validate_method_flag=1时,该值表示节点路径',
  `validate_value` text COLLATE utf8mb4_unicode_ci COMMENT '验证值',
  `get_value_method` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '获取validate_value的方式，0 - 常量，1 - 入参节点值，2 - SQL语句，3 - 全局变量，4 - 正则表达式',
  `validate_method_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '验证方式0-左右边界取关键字验证，1-节点参数验证',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态，0 - 正常， 1 - 禁用',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  PRIMARY KEY (`validate_id`),
  KEY `at_scene_validate_rule_fk_message_scene_id` (`message_scene_id`),
  CONSTRAINT `at_scene_validate_rule_fk_message_scene_id` FOREIGN KEY (`message_scene_id`) REFERENCES `at_message_scene` (`message_scene_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=' 出参验证规则';

-- 正在导出表  atp.at_scene_validate_rule 的数据：~0 rows (大约)
DELETE FROM `at_scene_validate_rule`;
/*!40000 ALTER TABLE `at_scene_validate_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_scene_validate_rule` ENABLE KEYS */;

-- 导出  表 atp.at_set_complex_scene 结构
CREATE TABLE IF NOT EXISTS `at_set_complex_scene` (
  `set_id` int(11) NOT NULL DEFAULT '0',
  `complex_scene_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`set_id`,`complex_scene_id`),
  KEY `at_set_complex_scene_fk_complex_scene_id` (`complex_scene_id`),
  CONSTRAINT `at_set_complex_scene_fk_complex_scene_id` FOREIGN KEY (`complex_scene_id`) REFERENCES `at_complex_scene` (`id`) ON DELETE CASCADE,
  CONSTRAINT `at_set_complex_scene_fk_set_id` FOREIGN KEY (`set_id`) REFERENCES `at_test_set` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试集与组合场景关联表';

-- 正在导出表  atp.at_set_complex_scene 的数据：~0 rows (大约)
DELETE FROM `at_set_complex_scene`;
/*!40000 ALTER TABLE `at_set_complex_scene` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_set_complex_scene` ENABLE KEYS */;

-- 导出  表 atp.at_set_scene 结构
CREATE TABLE IF NOT EXISTS `at_set_scene` (
  `set_id` int(11) NOT NULL DEFAULT '0',
  `message_scene_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`set_id`,`message_scene_id`),
  KEY `at_set_scene_fk_message_scene_id` (`message_scene_id`),
  CONSTRAINT `at_set_scene_fk_message_scene_id` FOREIGN KEY (`message_scene_id`) REFERENCES `at_message_scene` (`message_scene_id`) ON DELETE CASCADE,
  CONSTRAINT `at_set_scene_fk_set_id` FOREIGN KEY (`set_id`) REFERENCES `at_test_set` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试集与测试场景组合表';

-- 正在导出表  atp.at_set_scene 的数据：~0 rows (大约)
DELETE FROM `at_set_scene`;
/*!40000 ALTER TABLE `at_set_scene` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_set_scene` ENABLE KEYS */;

-- 导出  表 atp.at_task 结构
CREATE TABLE IF NOT EXISTS `at_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `task_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `task_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务类型，0 - 接口自动化     1 - web自动化',
  `related_id` int(11) DEFAULT NULL COMMENT '关联的测试集Id会根据taskType查找',
  `task_cron_expression` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cron表达式',
  `run_count` int(11) DEFAULT '0' COMMENT '该任务的运行次数,重启将会重新计数',
  `last_finish_time` datetime DEFAULT NULL COMMENT '最后一次完成时间',
  `create_time` datetime DEFAULT NULL COMMENT '任务创建时间',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 当前状态， 0 - 可运行，1 - 不可运行',
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `mail_notify` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否邮件通知，0 - 否，1 - 是',
  PRIMARY KEY (`task_id`),
  KEY `at_task_user_id_fk_user` (`user_id`),
  CONSTRAINT `at_task_user_id_fk_user` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='自动化定时测试任务';

-- 正在导出表  atp.at_task 的数据：~0 rows (大约)
DELETE FROM `at_task`;
/*!40000 ALTER TABLE `at_task` DISABLE KEYS */;
INSERT INTO `at_task` (`task_id`, `task_name`, `task_type`, `related_id`, `task_cron_expression`, `run_count`, `last_finish_time`, `create_time`, `status`, `user_id`, `mail_notify`) VALUES
	(1, 'err', '0', 11, '24 * * * * ?', 2, '2018-08-15 21:16:28', '2018-08-15 09:43:46', '1', 1, '1');
/*!40000 ALTER TABLE `at_task` ENABLE KEYS */;

-- 导出  表 atp.at_test_config 结构
CREATE TABLE IF NOT EXISTS `at_test_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户id,若为0则为全局配置',
  `request_Url_Flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求地址选择，已废弃',
  `connect_Time_Out` int(11) DEFAULT NULL COMMENT '连接超时时间ms',
  `read_Time_Out` int(11) DEFAULT NULL COMMENT '读取返回超时时间ms',
  `http_Method_Flag` char(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方式，已废弃，可以使用Message中的callParameter参数来设置',
  `custom_request_url` text COLLATE utf8mb4_unicode_ci COMMENT '测试集用配置：请求地址全局配置',
  `check_Data_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否在测试之前检查测试数据，在系统进行定时任务时该配置是无效的。0-需要检查，1-不需要检查',
  `run_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试模式，0-并行  1-串行',
  `retry_count` int(3) DEFAULT '3' COMMENT '重试次数',
  `systems` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT ' ' COMMENT ' 全局配置无效,只针对测试集的运行时配置，配置当前生效的测试环境,在测试测试集时，如果测试场景包含多个测试环境，已此配置中为准,默认配置或者此值为空时会执行该场景的所有测试环境',
  `top_scenes` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT ' ' COMMENT '置顶的测试场景，置顶的场景采用串行方式按照顺序运行',
  `mail_receive_address` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT ' ' COMMENT '邮件通知时：收件人地址列表，逗号分隔',
  `mail_copy_address` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT ' ' COMMENT '邮件通知时：抄送人地址列表,逗号分隔',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口自动化测试配置';

-- 正在导出表  atp.at_test_config 的数据：~15 rows (大约)
DELETE FROM `at_test_config`;
/*!40000 ALTER TABLE `at_test_config` DISABLE KEYS */;
INSERT INTO `at_test_config` (`config_id`, `user_id`, `request_Url_Flag`, `connect_Time_Out`, `read_Time_Out`, `http_Method_Flag`, `custom_request_url`, `check_Data_flag`, `run_type`, `retry_count`, `systems`, `top_scenes`, `mail_receive_address`, `mail_copy_address`) VALUES
	(1, 0, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(2, 1, NULL, 3000, 20000, NULL, NULL, '0', '0', 3, NULL, ' ', ' ', ' '),
	(4, 4, '2', 3000, 20000, NULL, NULL, '0', '1', 3, ' ', ' ', ' ', ' '),
	(6, 5, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(8, 2, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(9, NULL, '2', 3000, 20000, NULL, '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(10, NULL, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(13, 6, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(14, 18, '0', 5000, 20000, NULL, NULL, '0', '0', 3, ' ', ' ', ' ', ' '),
	(15, 10, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(16, 13, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(17, 3, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(18, 21, '0', 3000, 20000, '0', '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(21, NULL, '2', 3000, 20000, NULL, '', '0', '0', 3, ' ', ' ', ' ', ' '),
	(23, NULL, NULL, 3000, 20000, NULL, NULL, '0', '0', 3, '1,2', ' ', ' ', ' ');
/*!40000 ALTER TABLE `at_test_config` ENABLE KEYS */;

-- 导出  表 atp.at_test_data 结构
CREATE TABLE IF NOT EXISTS `at_test_data` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_scene_id` int(11) DEFAULT NULL COMMENT '所属测试场景',
  `params_data` longtext COLLATE utf8mb4_unicode_ci COMMENT 'json串存储数据,节点路径名作为key,数据作为value',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可用状态0-可用  1-不可用/已使用， 2 - 可重复使用，不论接口类型',
  `systems` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属测试环境',
  `data_discr` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据标记，用户自定义,根据接口、报文、场景的不同有所不同，不允许重复',
  `default_data` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 是否为默认数据,默认数据适用于所有的测试环境,但是选择优先级低于属于其他数据，0 - 是，1 - 否',
  PRIMARY KEY (`data_id`),
  KEY `at_test_data_pk_message_scene_id` (`message_scene_id`),
  CONSTRAINT `at_test_data_pk_message_scene_id` FOREIGN KEY (`message_scene_id`) REFERENCES `at_message_scene` (`message_scene_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='所属测试场景的测试数据';

-- 正在导出表  atp.at_test_data 的数据：~0 rows (大约)
DELETE FROM `at_test_data`;
/*!40000 ALTER TABLE `at_test_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_test_data` ENABLE KEYS */;

-- 导出  表 atp.at_test_report 结构
CREATE TABLE IF NOT EXISTS `at_test_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `test_mode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试模式,即测试对应的测试集ID',
  `finish_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试完成标记，Y - 已完成，N - 未完成',
  `create_time` datetime DEFAULT NULL COMMENT '测试开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '全部场景测试完成时的时间',
  `user_id` int(11) DEFAULT NULL COMMENT '测试人',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `details_json` longtext COLLATE utf8mb4_unicode_ci COMMENT 'json格式的测试详情数据，每次测试完成之后自动生成并保存，适用于在线或者离线测试报告的生成',
  `guid` varchar(800) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全局唯一测试标识',
  PRIMARY KEY (`report_id`),
  KEY `at_test_report_fk_user_id` (`user_id`),
  CONSTRAINT `at_test_report_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=' 测试报告';

-- 正在导出表  atp.at_test_report 的数据：~0 rows (大约)
DELETE FROM `at_test_report`;
/*!40000 ALTER TABLE `at_test_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_test_report` ENABLE KEYS */;

-- 导出  表 atp.at_test_result 结构
CREATE TABLE IF NOT EXISTS `at_test_result` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_scene_id` int(11) DEFAULT NULL COMMENT '对应测试场景',
  `report_id` int(11) DEFAULT NULL COMMENT '所属测试报告',
  `message_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '格式：接口名,报文名,场景名，记录的是测试当时的状态',
  `request_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实际使用的请求URL',
  `request_message` longtext COLLATE utf8mb4_unicode_ci COMMENT '实际用到的请求入参报文',
  `response_message` longtext COLLATE utf8mb4_unicode_ci COMMENT '实际返回的报文',
  `headers` longtext COLLATE utf8mb4_unicode_ci COMMENT '包含response headers、request headers，使用json串保存',
  `use_time` int(11) DEFAULT NULL COMMENT '测试耗时ms',
  `run_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试结果状态，必须要保证验证也成功，0 - SUCCESS 成功，1 - FAIL 失败，如返回验证不成功、没有返回等，2 - STOP 异常停止或者未完成，请求地址不通、缺少测试数据等',
  `business_system_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试环境名称',
  `status_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '返回状态码，自定义，比如http协议中，表示htpp状态码如200,302等',
  `op_time` datetime DEFAULT NULL COMMENT '发送请求的时间',
  `complex_result_id` int(11) DEFAULT NULL COMMENT '包含的组合场景多个测试结果',
  `protocol_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求协议类型',
  `probe_id` int(11) DEFAULT NULL COMMENT '关联的接口探测任务',
  `quality_level` int(1) DEFAULT NULL COMMENT '测试的质量等级，接口探测任务生成的测试结果才会去评定',
  `mark` longtext COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `message_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报文格式类型',
  PRIMARY KEY (`result_id`),
  KEY `at_test_result_fk_message_scene_id` (`message_scene_id`),
  KEY `at_test_result_fk_report_id` (`report_id`),
  KEY `at_test_result_fk_complex_result_id` (`complex_result_id`),
  KEY `at_test_result_fk_probe_id` (`probe_id`),
  CONSTRAINT `at_test_result_fk_complex_result_id` FOREIGN KEY (`complex_result_id`) REFERENCES `at_test_result` (`result_id`),
  CONSTRAINT `at_test_result_fk_message_scene_id` FOREIGN KEY (`message_scene_id`) REFERENCES `at_message_scene` (`message_scene_id`),
  CONSTRAINT `at_test_result_fk_probe_id` FOREIGN KEY (`probe_id`) REFERENCES `at_interface_probe` (`probe_id`),
  CONSTRAINT `at_test_result_fk_report_id` FOREIGN KEY (`report_id`) REFERENCES `at_test_report` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8 COMMENT='测试详情结果';

-- 正在导出表  atp.at_test_result 的数据：~0 rows (大约)
DELETE FROM `at_test_result`;
/*!40000 ALTER TABLE `at_test_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_test_result` ENABLE KEYS */;

-- 导出  表 atp.at_test_set 结构
CREATE TABLE IF NOT EXISTS `at_test_set` (
  `set_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) DEFAULT NULL COMMENT '该测试集的测试配置',
  `set_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试集名称',
  `user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可用状态，0-可用   1-不可用，在执行定时任务测试时,将会忽略状态为1的测试集',
  `parented` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否为父节点，父节点就是测试集菜单而不是测试集，1 - 表示测试集  0 - 表示文件夹目录',
  `parent_id` int(11) DEFAULT NULL COMMENT '父节点',
  `mark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`set_id`),
  KEY `at_test_set_fk_user_id` (`user_id`),
  KEY `at_test_set_fk_config_id` (`config_id`),
  KEY `at_test_set_fk_set_id` (`parent_id`),
  CONSTRAINT `at_test_set_fk_config_id` FOREIGN KEY (`config_id`) REFERENCES `at_test_config` (`config_id`),
  CONSTRAINT `at_test_set_fk_set_id` FOREIGN KEY (`parent_id`) REFERENCES `at_test_set` (`set_id`),
  CONSTRAINT `at_test_set_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试集';

-- 正在导出表  atp.at_test_set 的数据：~0 rows (大约)
DELETE FROM `at_test_set`;
/*!40000 ALTER TABLE `at_test_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_test_set` ENABLE KEYS */;

-- 导出  表 atp.at_user 结构
CREATE TABLE IF NOT EXISTS `at_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录用户名',
  `real_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '真实姓名',
  `password` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `login_identification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录标识，帮助用户快速登录',
  `role_id` int(11) DEFAULT NULL COMMENT '角色',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态，0 - 正常， 1 - 锁定',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `if_new` text COLLATE utf8mb4_unicode_ci COMMENT '通过外部接口同步过来的用户的userid',
  PRIMARY KEY (`user_id`),
  KEY `at_user_fk_role_id` (`role_id`),
  CONSTRAINT `at_user_fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `at_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- 正在导出表  atp.at_user 的数据：~1 rows (大约)
DELETE FROM `at_user`;
/*!40000 ALTER TABLE `at_user` DISABLE KEYS */;
INSERT INTO `at_user` (`user_id`, `username`, `real_name`, `password`, `login_identification`, `role_id`, `create_time`, `status`, `last_login_time`, `if_new`) VALUES
	(1, 'admin', '超级管理员', '6de56f9aad7db084b730f719d0874175', '991597cf5658bdf761d0770c66cacddb', 1, '2016-09-18 14:36:06', '0', '2018-12-28 21:04:22', 'atp'),
	(2, 'test001', '无聊的测试人员', '96e79218965eb72c92a549dd5a330112', '4453a1a1004f7d9a28a9c21709433abe', 6, '2018-12-28 20:48:32', '0', '2018-12-28 21:02:35', 'atp');
/*!40000 ALTER TABLE `at_user` ENABLE KEYS */;

-- 导出  表 atp.at_user_mail 结构
CREATE TABLE IF NOT EXISTS `at_user_mail` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_user_id` int(11) DEFAULT NULL COMMENT '接收用户',
  `send_user_id` int(11) DEFAULT NULL COMMENT '发送用户',
  `if_validate` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查看是否需要验证密码',
  `mail_info` longtext COLLATE utf8mb4_unicode_ci COMMENT '消息内容',
  `send_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送状态',
  `read_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '阅读状态，0 - 已读， 1 - 未读',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮件标题',
  PRIMARY KEY (`mail_id`),
  KEY `at_user_mail_fk_user_id_receive` (`receive_user_id`),
  KEY `at_user_mail_fk_user_id_send` (`send_user_id`),
  CONSTRAINT `at_user_mail_fk_user_id_receive` FOREIGN KEY (`receive_user_id`) REFERENCES `at_user` (`user_id`),
  CONSTRAINT `at_user_mail_fk_user_id_send` FOREIGN KEY (`send_user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户邮件信息';

-- 正在导出表  atp.at_user_mail 的数据：~0 rows (大约)
DELETE FROM `at_user_mail`;
/*!40000 ALTER TABLE `at_user_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_user_mail` ENABLE KEYS */;

-- 导出  表 atp.at_web_script_module 结构
CREATE TABLE IF NOT EXISTS `at_web_script_module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块名称',
  `folder_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件夹名称',
  `create_user` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建用户',
  `create_time` datetime DEFAULT NULL COMMENT ' 创建时间',
  `author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '脚本作者',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `module_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 模块业务code',
  `framework_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '框架类型：目前支持的ruby-watir-cucumber',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ruby-cucumber自动化脚本模块定义';

-- 正在导出表  atp.at_web_script_module 的数据：~0 rows (大约)
DELETE FROM `at_web_script_module`;
/*!40000 ALTER TABLE `at_web_script_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_script_module` ENABLE KEYS */;

-- 导出  表 atp.at_web_script_task 结构
CREATE TABLE IF NOT EXISTS `at_web_script_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL COMMENT '关联模块',
  `task_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型,0 - 内部调用 1 - 外部接口调用',
  `start_time` datetime DEFAULT NULL COMMENT '开始执行时间',
  `finish_time` datetime DEFAULT NULL COMMENT '结束时间',
  `finish_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束标识 Y - 已结束  N - 未结束',
  `report_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '该次报告路径',
  `mark` text COLLATE utf8mb4_unicode_ci COMMENT '命令行执行的返回内容',
  `detail_json` text COLLATE utf8mb4_unicode_ci COMMENT '详细结果json',
  `guid` varchar(800) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '唯一全局标识',
  PRIMARY KEY (`task_id`),
  KEY `at_web_script_task_fk_module_id` (`module_id`),
  CONSTRAINT `at_web_script_task_fk_module_id` FOREIGN KEY (`module_id`) REFERENCES `at_web_script_module` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ruby_cucumber框架，web自动化测试任务';

-- 正在导出表  atp.at_web_script_task 的数据：~0 rows (大约)
DELETE FROM `at_web_script_task`;
/*!40000 ALTER TABLE `at_web_script_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_script_task` ENABLE KEYS */;

-- 导出  表 atp.at_web_suite_case_comp 结构
CREATE TABLE IF NOT EXISTS `at_web_suite_case_comp` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `suite_id` int(11) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `exec_seq` int(3) DEFAULT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skip_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  KEY `at_web_suite_case_comp_fk_suite_id` (`suite_id`),
  KEY `at_web_suite_case_comp_fk_case_id` (`case_id`),
  CONSTRAINT `at_web_suite_case_comp_fk_case_id` FOREIGN KEY (`case_id`) REFERENCES `at_web_test_case` (`case_id`),
  CONSTRAINT `at_web_suite_case_comp_fk_suite_id` FOREIGN KEY (`suite_id`) REFERENCES `at_web_test_suite` (`suite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试套件与测试用例关联';

-- 正在导出表  atp.at_web_suite_case_comp 的数据：~0 rows (大约)
DELETE FROM `at_web_suite_case_comp`;
/*!40000 ALTER TABLE `at_web_suite_case_comp` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_suite_case_comp` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_case 结构
CREATE TABLE IF NOT EXISTS `at_web_test_case` (
  `case_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `case_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `config_json` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `last_run_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run_time` datetime DEFAULT NULL,
  PRIMARY KEY (`case_id`),
  KEY `at_web_test_case_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_case_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试用例';

-- 正在导出表  atp.at_web_test_case 的数据：~0 rows (大约)
DELETE FROM `at_web_test_case`;
/*!40000 ALTER TABLE `at_web_test_case` DISABLE KEYS */;
INSERT INTO `at_web_test_case` (`case_id`, `case_name`, `browser_type`, `case_type`, `create_time`, `config_json`, `user_id`, `mark`, `last_run_status`, `status`, `last_run_time`) VALUES
	(6, '登录', 'ie', 'snippet', '2018-09-01 16:21:51', '{"caseVariables":{}}', 1, '', '', '0', NULL);
/*!40000 ALTER TABLE `at_web_test_case` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_case_report 结构
CREATE TABLE IF NOT EXISTS `at_web_test_case_report` (
  `case_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `suite_report_id` int(11) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `case_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `run_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `step_count` int(5) DEFAULT NULL,
  `execute_step_count` int(5) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `result_details` longtext COLLATE utf8mb4_unicode_ci,
  `run_log` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`case_report_id`),
  KEY `at_web_test_case_report_fk_suite_report_id` (`suite_report_id`),
  KEY `at_web_test_case_report_fk_case_id` (`case_id`),
  KEY `at_web_test_case_report_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_case_report_fk_case_id` FOREIGN KEY (`case_id`) REFERENCES `at_web_test_case` (`case_id`),
  CONSTRAINT `at_web_test_case_report_fk_suite_report_id` FOREIGN KEY (`suite_report_id`) REFERENCES `at_web_test_suite_report` (`suite_report_id`),
  CONSTRAINT `at_web_test_case_report_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试用例报告详情数据';

-- 正在导出表  atp.at_web_test_case_report 的数据：~0 rows (大约)
DELETE FROM `at_web_test_case_report`;
/*!40000 ALTER TABLE `at_web_test_case_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_test_case_report` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_config 结构
CREATE TABLE IF NOT EXISTS `at_web_test_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `chrome_driver_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firefox_driver_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opera_driver_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ie_driver_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `window_maximize` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_load_timeout` int(5) DEFAULT NULL,
  `implicitly_wait_timeout` int(5) DEFAULT NULL,
  `chrome_excute_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firefox_excute_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opera_excute_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ie_excute_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  KEY `at_web_test_config_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_config_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试配置';

-- 正在导出表  atp.at_web_test_config 的数据：~0 rows (大约)
DELETE FROM `at_web_test_config`;
/*!40000 ALTER TABLE `at_web_test_config` DISABLE KEYS */;
INSERT INTO `at_web_test_config` (`config_id`, `user_id`, `chrome_driver_path`, `firefox_driver_path`, `opera_driver_path`, `ie_driver_path`, `window_maximize`, `page_load_timeout`, `implicitly_wait_timeout`, `chrome_excute_path`, `firefox_excute_path`, `opera_excute_path`, `ie_excute_path`) VALUES
	(16, NULL, '', '', '', '', '1', 30, 30, '', '', '', '');
/*!40000 ALTER TABLE `at_web_test_config` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_element 结构
CREATE TABLE IF NOT EXISTS `at_web_test_element` (
  `element_id` int(11) NOT NULL AUTO_INCREMENT,
  `element_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `element_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `by_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `by_value` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seq` int(1) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `modify_log` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`element_id`),
  KEY `at_web_test_element_fk_parent_id` (`parent_id`),
  KEY `at_web_test_element_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_element_fk_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `at_web_test_element` (`element_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `at_web_test_element_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试元素信息表';

-- 正在导出表  atp.at_web_test_element 的数据：~14 rows (大约)
DELETE FROM `at_web_test_element`;
/*!40000 ALTER TABLE `at_web_test_element` DISABLE KEYS */;
INSERT INTO `at_web_test_element` (`element_id`, `element_name`, `element_type`, `by_type`, `by_value`, `seq`, `parent_id`, `create_time`, `user_id`, `mark`, `modify_log`) VALUES
	(1, 'WEB自动化', 'website', NULL, NULL, 0, NULL, '2018-08-25 20:18:15', 1, NULL, '[]'),
	(2, '通用元素', 'page', NULL, NULL, 0, 1, '2018-08-25 20:19:06', 1, NULL, '[]'),
	(3, '当前窗口地址栏', 'tag', 'currentUrl', NULL, 0, 2, '2018-08-26 17:19:33', 1, '当前窗口上方地址栏的值', '[]'),
	(4, '当前窗口标题', 'tag', 'title', NULL, 0, 2, '2018-08-26 17:20:29', 1, '当前窗口的标题', '[]'),
	(5, '当前页确认框/对话框', 'tag', 'alert', NULL, 0, 2, '2018-08-26 17:21:25', 1, '浏览器原始的确认框或者对话框，该元素不能通过元素定位到', '[]'),
	(20, '新节点', 'module', NULL, NULL, 0, 2, '2018-08-26 16:32:42', 1, NULL, '[]'),
	(21, '新节点', 'page', NULL, NULL, 0, 20, '2018-08-26 16:32:49', 1, NULL, '[]'),
	(28, '百度网站', 'website', NULL, NULL, 0, 1, '2018-08-26 17:24:34', 1, NULL, '[]'),
	(29, '百度搜索', 'module', NULL, NULL, 0, 28, '2018-08-26 17:24:45', 1, NULL, '[]'),
	(30, '百度搜索首页', 'page', NULL, NULL, 0, 29, '2018-08-26 17:25:02', 1, NULL, '[]'),
	(31, '百度搜索地址', 'url', '', 'http://www.baidu.com', 0, 30, '2018-08-26 17:25:24', 1, '', '[]'),
	(32, '百度搜索框', 'tag', 'Id', 'kw', 0, 30, '2018-08-26 17:25:45', 1, '', '[]'),
	(33, '百度搜索按钮', 'tag', 'Id', 'su', 0, 30, '2018-08-26 17:25:58', 1, '', '[]'),
	(59, '不知道的页面', 'frame', '', '', 0, 30, '2018-08-27 15:43:47', 1, '', '["用户超级管理员在2018-09-17 14:41:56修改了以下内容:\\n元素名称: [新节点] ==> [不知道的页面]\\n"]');
/*!40000 ALTER TABLE `at_web_test_element` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_step 结构
CREATE TABLE IF NOT EXISTS `at_web_test_step` (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `step_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `exec_seq` int(2) DEFAULT NULL,
  `op_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `snippet_case_id` int(11) DEFAULT NULL,
  `required_data_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required_data_value` varchar(2550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validate_data_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validate_data_value` varchar(2550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skip_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_json` text COLLATE utf8mb4_unicode_ci,
  `create_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `error_interrupt_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `modify_log` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`step_id`),
  KEY `at_web_test_step_fk_case_id` (`case_id`),
  KEY `at_web_test_step_fk_snippet_case_id` (`snippet_case_id`),
  KEY `at_web_test_step_fk_element_id` (`element_id`),
  KEY `at_web_test_step_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_step_fk_case_id` FOREIGN KEY (`case_id`) REFERENCES `at_web_test_case` (`case_id`),
  CONSTRAINT `at_web_test_step_fk_element_id` FOREIGN KEY (`element_id`) REFERENCES `at_web_test_element` (`element_id`),
  CONSTRAINT `at_web_test_step_fk_snippet_case_id` FOREIGN KEY (`snippet_case_id`) REFERENCES `at_web_test_case` (`case_id`),
  CONSTRAINT `at_web_test_step_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试步骤信息';

-- 正在导出表  atp.at_web_test_step 的数据：~0 rows (大约)
DELETE FROM `at_web_test_step`;
/*!40000 ALTER TABLE `at_web_test_step` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_test_step` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_suite 结构
CREATE TABLE IF NOT EXISTS `at_web_test_suite` (
  `suite_id` int(11) NOT NULL AUTO_INCREMENT,
  `suite_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `run_count` int(11) DEFAULT NULL,
  `last_run_time` datetime DEFAULT NULL,
  `config_json` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`suite_id`),
  KEY `at_web_test_suite_fk_config_id` (`config_id`),
  KEY `at_web_test_suite_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_suite_fk_config_id` FOREIGN KEY (`config_id`) REFERENCES `at_web_test_config` (`config_id`),
  CONSTRAINT `at_web_test_suite_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试套件';

-- 正在导出表  atp.at_web_test_suite 的数据：~0 rows (大约)
DELETE FROM `at_web_test_suite`;
/*!40000 ALTER TABLE `at_web_test_suite` DISABLE KEYS */;
INSERT INTO `at_web_test_suite` (`suite_id`, `suite_name`, `browser_type`, `config_id`, `user_id`, `create_time`, `mark`, `run_count`, `last_run_time`, `config_json`) VALUES
	(13, '123123', 'chrome', 16, 1, '2018-09-17 14:44:59', '312313', 0, NULL, '{"suiteVariables":{}}');
/*!40000 ALTER TABLE `at_web_test_suite` ENABLE KEYS */;

-- 导出  表 atp.at_web_test_suite_report 结构
CREATE TABLE IF NOT EXISTS `at_web_test_suite_report` (
  `suite_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `suite_id` int(11) DEFAULT NULL,
  `suite_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `finish_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_count` int(11) DEFAULT NULL,
  `success_count` int(11) DEFAULT NULL,
  `fail_count` int(11) DEFAULT NULL,
  `mark` text COLLATE utf8mb4_unicode_ci,
  `report_path` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_details` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `run_log` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`suite_report_id`),
  KEY `at_web_test_suite_report_fk_suite_id` (`suite_id`),
  KEY `at_web_test_suite_report_fk_user_id` (`user_id`),
  CONSTRAINT `at_web_test_suite_report_fk_suite_id` FOREIGN KEY (`suite_id`) REFERENCES `at_web_test_suite` (`suite_id`),
  CONSTRAINT `at_web_test_suite_report_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `at_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='web自动化测试套件报告';

-- 正在导出表  atp.at_web_test_suite_report 的数据：~0 rows (大约)
DELETE FROM `at_web_test_suite_report`;
/*!40000 ALTER TABLE `at_web_test_suite_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `at_web_test_suite_report` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
