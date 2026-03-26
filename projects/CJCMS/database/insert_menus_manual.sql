-- ========================================
-- CJCMS 菜单数据插入脚本
-- 请在 PL/SQL Developer 中直接执行（按 F8）
-- ========================================

SET DEFINE OFF;

-- 清除旧数据
DELETE FROM CJ_SYS_MENU;
COMMIT;

PROMPT 开始插入菜单数据...

-- ========================================
-- 一级菜单（目录）- 13 个
-- ========================================

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

PROMPT 一级菜单插入完成 (13 个)

-- ========================================
-- 二级菜单 - 站群管理 (4 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-01', 'menu001', N'站点列表', 'site:list', 2, '/site/list', 'el-icon-s-home', 1, 1, 1, 'site:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-02', 'menu001', N'创建站点', 'site:create', 2, '/site/create', 'el-icon-plus', 2, 1, 1, 'site:create');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-03', 'menu001', N'站点模板', 'site:template', 2, '/site/template', 'el-icon-files', 3, 1, 1, 'site:template');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-04', 'menu001', N'在线模板', 'site:online-template', 2, '/site/online-template', 'el-icon-download', 4, 1, 1, 'site:online-template');

-- ========================================
-- 二级菜单 - 信息管理 (5 个)
-- ========================================

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

-- ========================================
-- 二级菜单 - 素材管理 (4 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-01', 'menu003', N'图片管理', 'material:image', 2, '/material/image', 'el-icon-picture-outline', 1, 1, 1, 'material:image');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-02', 'menu003', N'视频管理', 'material:video', 2, '/material/video', 'el-icon-video-camera', 2, 1, 1, 'material:video');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-03', 'menu003', N'音频管理', 'material:audio', 2, '/material/audio', 'el-icon-headset', 3, 1, 1, 'material:audio');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-04', 'menu003', N'文件管理', 'material:file', 2, '/material/file', 'el-icon-folder-opened', 4, 1, 1, 'material:file');

-- ========================================
-- 二级菜单 - 显示管理 (3 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-01', 'menu004', N'模板管理', 'template:list', 2, '/display/template', 'el-icon-document', 1, 1, 1, 'template:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-02', 'menu004', N'专题管理', 'special:list', 2, '/display/special', 'el-icon-collection', 2, 1, 1, 'special:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-03', 'menu004', N'资源文件', 'resource:list', 2, '/display/resource', 'el-icon-files', 3, 1, 1, 'resource:list');

-- ========================================
-- 二级菜单 - 设置管理 (6 个)
-- ========================================

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

-- ========================================
-- 二级菜单 - 生成管理 (2 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-01', 'menu006', N'一键生成', 'generation:one-click', 2, '/generation/one-click', 'el-icon-lightning', 1, 1, 1, 'generation:one-click');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-02', 'menu006', N'生成进度', 'generation:progress', 2, '/generation/progress', 'el-icon-time', 2, 1, 1, 'generation:progress');

-- ========================================
-- 二级菜单 - 插件管理 (2 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-01', 'menu007', N'插件市场', 'plugin:market', 2, '/plugin/market', 'el-icon-shopping-cart', 1, 1, 1, 'plugin:market');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-02', 'menu007', N'我的插件', 'plugin:my-plugins', 2, '/plugin/my-plugins', 'el-icon-folder', 2, 1, 1, 'plugin:my-plugins');

-- ========================================
-- 二级菜单 - 管理员管理 (3 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-01', 'menu008', N'管理员列表', 'admin:list', 2, '/admin/list', 'el-icon-user', 1, 1, 1, 'admin:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-02', 'menu008', N'角色管理', 'admin:role', 2, '/admin/role', 'el-icon-coin', 2, 1, 1, 'admin:role');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-03', 'menu008', N'权限管理', 'admin:permission', 2, '/admin/permission', 'el-icon-lock', 3, 1, 1, 'admin:permission');

-- ========================================
-- 二级菜单 - 用户管理 (2 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-01', 'menu009', N'用户列表', 'user:list', 2, '/user/list', 'el-icon-avator', 1, 1, 1, 'user:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-02', 'menu009', N'用户组管理', 'user:group', 2, '/user/group', 'el-icon-s-custom', 2, 1, 1, 'user:group');

-- ========================================
-- 二级菜单 - 统计图表 (3 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-01', 'menu010', N'登录统计', 'stats:login', 2, '/statistics/login', 'el-icon-date', 1, 1, 1, 'stats:login');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-02', 'menu010', N'内容统计', 'stats:content', 2, '/statistics/content', 'el-icon-data-board', 2, 1, 1, 'stats:content');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-03', 'menu010', N'用户统计', 'stats:user', 2, '/statistics/user', 'el-icon-data-analysis', 3, 1, 1, 'stats:user');

-- ========================================
-- 二级菜单 - 运行日志 (3 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-01', 'menu011', N'操作日志', 'log:operation', 2, '/logs/operation', 'el-icon-tickets', 1, 1, 1, 'log:operation');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-02', 'menu011', N'错误日志', 'log:error', 2, '/logs/error', 'el-icon-warning-outline', 2, 1, 1, 'log:error');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-03', 'menu011', N'登录日志', 'log:login', 2, '/logs/login', 'el-icon-key', 3, 1, 1, 'log:login');

-- ========================================
-- 二级菜单 - 系统设置 (2 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-01', 'menu012', N'用户中心设置', 'system:user-center', 2, '/system/user-center', 'el-icon-user', 1, 1, 1, 'system:user-center');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-02', 'menu012', N'系统配置', 'system:config', 2, '/system/config', 'el-icon-s-operation', 2, 1, 1, 'system:config');

-- ========================================
-- 二级菜单 - 实用工具 (3 个)
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-01', 'menu013', N'系统缓存', 'tool:cache', 2, '/tools/cache', 'el-icon-refresh-left', 1, 1, 1, 'tool:cache');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-02', 'menu013', N'系统参数', 'tool:params', 2, '/tools/params', 'el-icon-info', 2, 1, 1, 'tool:params');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-03', 'menu013', N'加密解密', 'tool:encrypt', 2, '/tools/encrypt', 'el-icon-lock', 3, 1, 1, 'tool:encrypt');

COMMIT;

PROMPT ========================================
PROMPT ✅ 菜单数据插入完成！
PROMPT ========================================
PROMPT 一级菜单：13 个
PROMPT 二级菜单：43 个
PROMPT 总计：56 个菜单项
PROMPT ========================================
