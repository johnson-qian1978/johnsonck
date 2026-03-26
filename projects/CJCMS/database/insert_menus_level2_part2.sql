-- CJCMS 二级菜单数据插入脚本 (Part 2)
-- 在 PL/SQL Developer 中直接执行（按 F8）

-- 显示管理子菜单 (3 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-01', 'menu004', N'模板管理', 'template:list', 2, '/display/template', 'el-icon-document', 1, 1, 1, 'template:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-02', 'menu004', N'专题管理', 'special:list', 2, '/display/special', 'el-icon-collection', 2, 1, 1, 'special:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-03', 'menu004', N'资源文件', 'resource:list', 2, '/display/resource', 'el-icon-files', 3, 1, 1, 'resource:list');

-- 设置管理子菜单 (6 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-01', 'menu005', N'站点设置', 'setting:site', 2, '/settings/site', 'el-icon-s-home', 1, 1, 1, 'setting:site');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-02', 'menu005', N'内容设置', 'setting:content', 2, '/settings/content', 'el-icon-document', 2, 1, 1, 'setting:content');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-03', 'menu005', N'字段管理', 'setting:field', 2, '/settings/field', 'el-icon-connection', 3, 1, 1, 'setting:field');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-04', 'menu005', N'标签管理', 'setting:tag', 2, '/settings/tag', 'el-icon-price-tag', 4, 1, 1, 'setting:tag');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-05', 'menu005', N'生成设置', 'setting:generation', 2, '/settings/generation', 'el-icon-cpu', 5, 1, 1, 'setting:generation');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-06', 'menu005', N'上传设置', 'setting:upload', 2, '/settings/upload', 'el-icon-upload', 6, 1, 1, 'setting:upload');

-- 生成管理子菜单 (2 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-01', 'menu006', N'一键生成', 'generation:one-click', 2, '/generation/one-click', 'el-icon-lightning', 1, 1, 1, 'generation:one-click');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-02', 'menu006', N'生成进度', 'generation:progress', 2, '/generation/progress', 'el-icon-time', 2, 1, 1, 'generation:progress');

-- 插件管理子菜单 (2 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-01', 'menu007', N'插件市场', 'plugin:market', 2, '/plugin/market', 'el-icon-shopping-cart', 1, 1, 1, 'plugin:market');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-02', 'menu007', N'我的插件', 'plugin:my-plugins', 2, '/plugin/my-plugins', 'el-icon-folder', 2, 1, 1, 'plugin:my-plugins');

COMMIT;

PROMPT 已插入：显示管理 (3) + 设置管理 (6) + 生成管理 (2) + 插件管理 (2) = 13 个二级菜单
