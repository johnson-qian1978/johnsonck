-- ========================================
-- CJCMS 菜单数据修复脚本
-- 请在 PL/SQL Developer 中执行（按 F8）
-- ========================================

SET DEFINE OFF;
ALTER SESSION SET NLS_LANGUAGE = 'SIMPLIFIED CHINESE';

-- 清除旧数据
DELETE FROM CJ_SYS_MENU;
COMMIT;

PROMPT 开始插入菜单数据...

-- ========================================
-- 一级菜单（目录）- 13 个
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu001', NULL, '站群管理', 'site-management', 1, '/site', 'el-icon-connection', 1, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu002', NULL, '信息管理', 'content-management', 1, '/content', 'el-icon-document', 2, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu003', NULL, '素材管理', 'material-management', 1, '/material', 'el-icon-picture', 3, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu004', NULL, '显示管理', 'display-management', 1, '/display', 'el-icon-monitor', 4, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu005', NULL, '设置管理', 'settings-management', 1, '/settings', 'el-icon-setting', 5, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu006', NULL, '生成管理', 'generation-management', 1, '/generation', 'el-icon-cpu', 6, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu007', NULL, '插件管理', 'plugin-management', 1, '/plugin', 'el-icon-grid', 7, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008', NULL, '管理员管理', 'admin-management', 1, '/admin', 'el-icon-user-solid', 8, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu009', NULL, '用户管理', 'user-management', 1, '/user', 'el-icon-avator', 9, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu010', NULL, '统计图表', 'statistics', 1, '/statistics', 'el-icon-data-line', 10, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu011', NULL, '运行日志', 'logs', 1, '/logs', 'el-icon-notebook-2', 11, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu012', NULL, '系统设置', 'system-settings', 1, '/system', 'el-icon-s-tools', 12, 1, 1);

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu013', NULL, '实用工具', 'utilities', 1, '/tools', 'el-icon-wrench', 13, 1, 1);

COMMIT;

PROMPT 一级菜单插入完成 (13 个)

-- ========================================
-- 二级菜单 - 管理员管理 (3 个) 【重点修复】
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-01', 'menu008', '管理员列表', 'admin:list', 2, '/admin/list', 'el-icon-user', 1, 1, 1, 'admin:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-02', 'menu008', '角色管理', 'admin:role', 2, '/admin/role', 'el-icon-coin', 2, 1, 1, 'admin:role');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-03', 'menu008', '权限管理', 'admin:permission', 2, '/admin/permission', 'el-icon-lock', 3, 1, 1, 'admin:permission');

COMMIT;

PROMPT ========================================
PROMPT ✅ 菜单数据修复完成！
PROMPT ========================================
PROMPT 请刷新浏览器查看菜单
