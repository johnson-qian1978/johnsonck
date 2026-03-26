-- 插入菜单数据
-- 按照需求规格说明书的 15 个模块插入完整菜单

SET DEFINE OFF;

-- 清除旧菜单数据
DELETE FROM CJ_SYS_MENU;
COMMIT;

-- ========================================
-- 一级菜单（目录）
-- ========================================

-- 1. 站群管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu001', NULL, N'站群管理', 'site-management', 1, '/site', 'layout/EmptyView', 'el-icon-connection', 1, 1, 1);

-- 2. 信息管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu002', NULL, N'信息管理', 'content-management', 1, '/content', 'layout/EmptyView', 'el-icon-document', 2, 1, 1);

-- 3. 素材管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu003', NULL, N'素材管理', 'material-management', 1, '/material', 'layout/EmptyView', 'el-icon-picture', 3, 1, 1);

-- 4. 显示管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu004', NULL, N'显示管理', 'display-management', 1, '/display', 'layout/EmptyView', 'el-icon-monitor', 4, 1, 1);

-- 5. 设置管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu005', NULL, N'设置管理', 'settings-management', 1, '/settings', 'layout/EmptyView', 'el-icon-setting', 5, 1, 1);

-- 6. 生成管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu006', NULL, N'生成管理', 'generation-management', 1, '/generation', 'layout/EmptyView', 'el-icon-cpu', 6, 1, 1);

-- 7. 插件管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu007', NULL, N'插件管理', 'plugin-management', 1, '/plugin', 'layout/EmptyView', 'el-icon-grid', 7, 1, 1);

-- 8. 管理员管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008', NULL, N'管理员管理', 'admin-management', 1, '/admin', 'layout/EmptyView', 'el-icon-user-solid', 8, 1, 1);

-- 9. 用户管理
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu009', NULL, N'用户管理', 'user-management', 1, '/user', 'layout/EmptyView', 'el-icon-avator', 9, 1, 1);

-- 10. 统计图表
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu010', NULL, N'统计图表', 'statistics', 1, '/statistics', 'layout/EmptyView', 'el-icon-data-line', 10, 1, 1);

-- 11. 运行日志
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu011', NULL, N'运行日志', 'logs', 1, '/logs', 'layout/EmptyView', 'el-icon-notebook-2', 11, 1, 1);

-- 12. 系统设置
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu012', NULL, N'系统设置', 'system-settings', 1, '/system', 'layout/EmptyView', 'el-icon-s-tools', 12, 1, 1);

-- 13. 实用工具
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu013', NULL, N'实用工具', 'utilities', 1, '/tools', 'layout/EmptyView', 'el-icon-wrench', 13, 1, 1);

-- ========================================
-- 二级菜单（具体功能页面）
-- ========================================

-- 站群管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-01', 'menu001', N'站点列表', 'site:list', 2, '/site/list', 'site/SiteList', 'el-icon-s-home', 1, 1, 1, 'site:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-02', 'menu001', N'创建站点', 'site:create', 2, '/site/create', 'site/SiteCreate', 'el-icon-plus', 2, 1, 1, 'site:create');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-03', 'menu001', N'站点模板', 'site:template', 2, '/site/template', 'site/SiteTemplate', 'el-icon-files', 3, 1, 1, 'site:template');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu001-04', 'menu001', N'在线模板', 'site:online-template', 2, '/site/online-template', 'site/OnlineTemplate', 'el-icon-download', 4, 1, 1, 'site:online-template');

-- 信息管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-01', 'menu002', N'栏目管理', 'channel:list', 2, '/content/channel', 'content/ChannelList', 'el-icon-menu', 1, 1, 1, 'channel:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-02', 'menu002', N'内容列表', 'content:list', 2, '/content/list', 'content/ContentList', 'el-icon-document-copy', 2, 1, 1, 'content:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-03', 'menu002', N'发布内容', 'content:create', 2, '/content/create', 'content/ContentCreate', 'el-icon-edit', 3, 1, 1, 'content:create');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-04', 'menu002', N'内容审核', 'content:audit', 2, '/content/audit', 'content/ContentAudit', 'el-icon-check', 4, 1, 1, 'content:audit');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu002-05', 'menu002', N'回收站', 'content:trash', 2, '/content/trash', 'content/ContentTrash', 'el-icon-delete', 5, 1, 1, 'content:trash');

-- 素材管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-01', 'menu003', N'图片管理', 'material:image', 2, '/material/image', 'material/ImageList', 'el-icon-picture-outline', 1, 1, 1, 'material:image');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-02', 'menu003', N'视频管理', 'material:video', 2, '/material/video', 'material/VideoList', 'el-icon-video-camera', 2, 1, 1, 'material:video');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-03', 'menu003', N'音频管理', 'material:audio', 2, '/material/audio', 'material/AudioList', 'el-icon-headset', 3, 1, 1, 'material:audio');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu003-04', 'menu003', N'文件管理', 'material:file', 2, '/material/file', 'material/FileList', 'el-icon-folder-opened', 4, 1, 1, 'material:file');

-- 显示管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-01', 'menu004', N'模板管理', 'template:list', 2, '/display/template', 'display/TemplateList', 'el-icon-document', 1, 1, 1, 'template:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-02', 'menu004', N'专题管理', 'special:list', 2, '/display/special', 'display/SpecialList', 'el-icon-collection', 2, 1, 1, 'special:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu004-03', 'menu004', N'资源文件', 'resource:list', 2, '/display/resource', 'display/ResourceList', 'el-icon-files', 3, 1, 1, 'resource:list');

-- 设置管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-01', 'menu005', N'站点设置', 'setting:site', 2, '/settings/site', 'settings/SiteSettings', 'el-icon-s-home', 1, 1, 1, 'setting:site');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-02', 'menu005', N'内容设置', 'setting:content', 2, '/settings/content', 'settings/ContentSettings', 'el-icon-document', 2, 1, 1, 'setting:content');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-03', 'menu005', N'字段管理', 'setting:field', 2, '/settings/field', 'settings/FieldSettings', 'el-icon-connection', 3, 1, 1, 'setting:field');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-04', 'menu005', N'标签管理', 'setting:tag', 2, '/settings/tag', 'settings/TagSettings', 'el-icon-price-tag', 4, 1, 1, 'setting:tag');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-05', 'menu005', N'生成设置', 'setting:generation', 2, '/settings/generation', 'settings/GenerationSettings', 'el-icon-cpu', 5, 1, 1, 'setting:generation');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu005-06', 'menu005', N'上传设置', 'setting:upload', 2, '/settings/upload', 'settings/UploadSettings', 'el-icon-upload', 6, 1, 1, 'setting:upload');

-- 生成管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-01', 'menu006', N'一键生成', 'generation:one-click', 2, '/generation/one-click', 'generation/OneClick', 'el-icon-lightning', 1, 1, 1, 'generation:one-click');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu006-02', 'menu006', N'生成进度', 'generation:progress', 2, '/generation/progress', 'generation/Progress', 'el-icon-time', 2, 1, 1, 'generation:progress');

-- 插件管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-01', 'menu007', N'插件市场', 'plugin:market', 2, '/plugin/market', 'plugin/Market', 'el-icon-shopping-cart', 1, 1, 1, 'plugin:market');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu007-02', 'menu007', N'我的插件', 'plugin:my-plugins', 2, '/plugin/my-plugins', 'plugin/MyPlugins', 'el-icon-folder', 2, 1, 1, 'plugin:my-plugins');

-- 管理员管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-01', 'menu008', N'管理员列表', 'admin:list', 2, '/admin/list', 'admin/AdminList', 'el-icon-user', 1, 1, 1, 'admin:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-02', 'menu008', N'角色管理', 'admin:role', 2, '/admin/role', 'admin/RoleList', 'el-icon-coin', 2, 1, 1, 'admin:role');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu008-03', 'menu008', N'权限管理', 'admin:permission', 2, '/admin/permission', 'admin/PermissionList', 'el-icon-lock', 3, 1, 1, 'admin:permission');

-- 用户管理子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-01', 'menu009', N'用户列表', 'user:list', 2, '/user/list', 'user/UserList', 'el-icon-avator', 1, 1, 1, 'user:list');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu009-02', 'menu009', N'用户组管理', 'user:group', 2, '/user/group', 'user/GroupList', 'el-icon-s-custom', 2, 1, 1, 'user:group');

-- 统计图表子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-01', 'menu010', N'登录统计', 'stats:login', 2, '/statistics/login', 'statistics/LoginStats', 'el-icon-date', 1, 1, 1, 'stats:login');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-02', 'menu010', N'内容统计', 'stats:content', 2, '/statistics/content', 'statistics/ContentStats', 'el-icon-data-board', 2, 1, 1, 'stats:content');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu010-03', 'menu010', N'用户统计', 'stats:user', 2, '/statistics/user', 'statistics/UserStats', 'el-icon-data-analysis', 3, 1, 1, 'stats:user');

-- 运行日志子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-01', 'menu011', N'操作日志', 'log:operation', 2, '/logs/operation', 'logs/OperationLog', 'el-icon-tickets', 1, 1, 1, 'log:operation');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-02', 'menu011', N'错误日志', 'log:error', 2, '/logs/error', 'logs/ErrorLog', 'el-icon-warning-outline', 2, 1, 1, 'log:error');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu011-03', 'menu011', N'登录日志', 'log:login', 2, '/logs/login', 'logs/LoginLog', 'el-icon-key', 3, 1, 1, 'log:login');

-- 系统设置子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-01', 'menu012', N'用户中心设置', 'system:user-center', 2, '/system/user-center', 'system/UserCenter', 'el-icon-user', 1, 1, 1, 'system:user-center');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu012-02', 'menu012', N'系统配置', 'system:config', 2, '/system/config', 'system/SystemConfig', 'el-icon-s-operation', 2, 1, 1, 'system:config');

-- 实用工具子菜单
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-01', 'menu013', N'系统缓存', 'tool:cache', 2, '/tools/cache', 'tools/Cache', 'el-icon-refresh-left', 1, 1, 1, 'tool:cache');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-02', 'menu013', N'系统参数', 'tool:params', 2, '/tools/params', 'tools/Params', 'el-icon-info', 2, 1, 1, 'tool:params');

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, COMPONENT_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS, PERMISSION_CODE) 
VALUES ('menu013-03', 'menu013', N'加密解密', 'tool:encrypt', 2, '/tools/encrypt', 'tools/Encrypt', 'el-icon-lock', 3, 1, 1, 'tool:encrypt');

COMMIT;

PROMPT ========================================
PROMPT 菜单数据插入完成！
PROMPT ========================================
PROMPT 一级菜单：13 个
PROMPT 二级菜单：43 个
PROMPT 总计：56 个菜单项
PROMPT ========================================

-- 验证菜单数量
SELECT DECODE(MENU_TYPE, 1, '目录', 2, '菜单', 3, '按钮', 4, 'API') AS 类型，COUNT(*) AS 数量 
FROM CJ_SYS_MENU 
GROUP BY MENU_TYPE;
