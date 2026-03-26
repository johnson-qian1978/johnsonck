-- CJCMS 二级菜单数据插入脚本
-- 在 PL/SQL Developer 中直接执行（按 F8）
-- 请先执行 insert_menus_level1.sql

-- 站群管理子菜单 (4 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-01', 'menu001', N'站点列表', 'site:list', 2, '/site/list', 'el-icon-s-home', 1, 1, 1, 'site:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-02', 'menu001', N'创建站点', 'site:create', 2, '/site/create', 'el-icon-plus', 2, 1, 1, 'site:create');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-03', 'menu001', N'站点模板', 'site:template', 2, '/site/template', 'el-icon-files', 3, 1, 1, 'site:template');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-04', 'menu001', N'在线模板', 'site:online-template', 2, '/site/online-template', 'el-icon-download', 4, 1, 1, 'site:online-template');

-- 信息管理子菜单 (5 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-01', 'menu002', N'栏目管理', 'channel:list', 2, '/content/channel', 'el-icon-menu', 1, 1, 1, 'channel:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-02', 'menu002', N'内容列表', 'content:list', 2, '/content/list', 'el-icon-document-copy', 2, 1, 1, 'content:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-03', 'menu002', N'发布内容', 'content:create', 2, '/content/create', 'el-icon-edit', 3, 1, 1, 'content:create');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-04', 'menu002', N'内容审核', 'content:audit', 2, '/content/audit', 'el-icon-check', 4, 1, 1, 'content:audit');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-05', 'menu002', N'回收站', 'content:trash', 2, '/content/trash', 'el-icon-delete', 5, 1, 1, 'content:trash');

-- 素材管理子菜单 (4 个)
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-01', 'menu003', N'图片管理', 'material:image', 2, '/material/image', 'el-icon-picture-outline', 1, 1, 1, 'material:image');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-02', 'menu003', N'视频管理', 'material:video', 2, '/material/video', 'el-icon-video-camera', 2, 1, 1, 'material:video');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-03', 'menu003', N'音频管理', 'material:audio', 2, '/material/audio', 'el-icon-headset', 3, 1, 1, 'material:audio');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-04', 'menu003', N'文件管理', 'material:file', 2, '/material/file', 'el-icon-folder-opened', 4, 1, 1, 'material:file');

COMMIT;

PROMPT 已插入：站群管理 (4) + 信息管理 (5) + 素材管理 (4) = 13 个二级菜单
