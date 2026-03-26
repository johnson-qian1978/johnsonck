-- CJCMS 二级菜单数据插入脚本 (Part 3)
-- 在 PL/SQL Developer 中直接执行（按 F8）

-- 管理员管理子菜单 (3 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-01', 'menu008', N'管理员列表', 'admin:list', 2, '/admin/list', 'el-icon-user', 1, 1, 1, 'admin:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-02', 'menu008', N'角色管理', 'admin:role', 2, '/admin/role', 'el-icon-coin', 2, 1, 1, 'admin:role');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-03', 'menu008', N'权限管理', 'admin:permission', 2, '/admin/permission', 'el-icon-lock', 3, 1, 1, 'admin:permission');

-- 用户管理子菜单 (2 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-01', 'menu009', N'用户列表', 'user:list', 2, '/user/list', 'el-icon-avator', 1, 1, 1, 'user:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-02', 'menu009', N'用户组管理', 'user:group', 2, '/user/group', 'el-icon-s-custom', 2, 1, 1, 'user:group');

-- 统计图表子菜单 (3 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-01', 'menu010', N'登录统计', 'stats:login', 2, '/statistics/login', 'el-icon-date', 1, 1, 1, 'stats:login');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-02', 'menu010', N'内容统计', 'stats:content', 2, '/statistics/content', 'el-icon-data-board', 2, 1, 1, 'stats:content');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-03', 'menu010', N'用户统计', 'stats:user', 2, '/statistics/user', 'el-icon-data-analysis', 3, 1, 1, 'stats:user');

-- 运行日志子菜单 (3 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-01', 'menu011', N'操作日志', 'log:operation', 2, '/logs/operation', 'el-icon-tickets', 1, 1, 1, 'log:operation');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-02', 'menu011', N'错误日志', 'log:error', 2, '/logs/error', 'el-icon-warning-outline', 2, 1, 1, 'log:error');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-03', 'menu011', N'登录日志', 'log:login', 2, '/logs/login', 'el-icon-key', 3, 1, 1, 'log:login');

-- 系统设置子菜单 (2 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-01', 'menu012', N'用户中心设置', 'system:user-center', 2, '/system/user-center', 'el-icon-user', 1, 1, 1, 'system:user-center');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-02', 'menu012', N'系统配置', 'system:config', 2, '/system/config', 'el-icon-s-operation', 2, 1, 1, 'system:config');

-- 实用工具子菜单 (3 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-01', 'menu013', N'系统缓存', 'tool:cache', 2, '/tools/cache', 'el-icon-refresh-left', 1, 1, 1, 'tool:cache');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-02', 'menu013', N'系统参数', 'tool:params', 2, '/tools/params', 'el-icon-info', 2, 1, 1, 'tool:params');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-03', 'menu013', N'加密解密', 'tool:encrypt', 2, '/tools/encrypt', 'el-icon-lock', 3, 1, 1, 'tool:encrypt');

COMMIT;

PROMPT ========================================
PROMPT ✅ 所有菜单数据插入完成！
PROMPT ========================================
PROMPT 一级菜单：13 个
PROMPT 二级菜单：43 个
PROMPT 总计：56 个菜单项
PROMPT ========================================
