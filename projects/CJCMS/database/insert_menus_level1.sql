-- CJCMS 菜单数据插入脚本（简化版）
-- 在 PL/SQL Developer 中直接执行（按 F8）

-- 清除旧数据
DELETE FROM CJ_SYS_MENU;
COMMIT;

-- 一级菜单（13 个）
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu001', NULL, N'站群管理', 'site-management', 1, '/site', 'el-icon-connection', 1, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu002', NULL, N'信息管理', 'content-management', 1, '/content', 'el-icon-document', 2, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu003', NULL, N'素材管理', 'material-management', 1, '/material', 'el-icon-picture', 3, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu004', NULL, N'显示管理', 'display-management', 1, '/display', 'el-icon-monitor', 4, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu005', NULL, N'设置管理', 'settings-management', 1, '/settings', 'el-icon-setting', 5, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu006', NULL, N'生成管理', 'generation-management', 1, '/generation', 'el-icon-cpu', 6, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu007', NULL, N'插件管理', 'plugin-management', 1, '/plugin', 'el-icon-grid', 7, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008', NULL, N'管理员管理', 'admin-management', 1, '/admin', 'el-icon-user-solid', 8, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu009', NULL, N'用户管理', 'user-management', 1, '/user', 'el-icon-avator', 9, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu010', NULL, N'统计图表', 'statistics', 1, '/statistics', 'el-icon-data-line', 10, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu011', NULL, N'运行日志', 'logs', 1, '/logs', 'el-icon-notebook-2', 11, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu012', NULL, N'系统设置', 'system-settings', 1, '/system', 'el-icon-s-tools', 12, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu013', NULL, N'实用工具', 'utilities', 1, '/tools', 'el-icon-wrench', 13, 1, 1);

COMMIT;

-- 提交后请继续执行下一个文件：insert_menus_level2.sql
