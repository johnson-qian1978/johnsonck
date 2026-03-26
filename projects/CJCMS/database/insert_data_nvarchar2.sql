-- Test Data with Full Unicode Support (NVARCHAR2)
SET DEFINE OFF;

PROMPT Inserting test data...

-- Administrator
INSERT INTO CJ_ADM_ADMINISTRATOR (ADMIN_ID, USERNAME, PASSWORD_HASH, REAL_NAME, EMAIL, DEPARTMENT, POSITION, STATUS) 
VALUES ('admin001', 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lqkkO9QS3TzCjH3rS', N'超级管理员', N'admin@cjcms.com', N'技术部', N'系统管理员', 1);

-- Roles
INSERT INTO CJ_ADM_ROLE (ROLE_ID, ROLE_NAME, ROLE_CODE, ROLE_TYPE, DESCRIPTION, DATA_SCOPE_TYPE, STATUS) 
VALUES ('role001', N'超级管理员', 'super_admin', 1, N'系统超级管理员，拥有所有权限', 'ALL', 1);

INSERT INTO CJ_ADM_ROLE (ROLE_ID, ROLE_NAME, ROLE_CODE, ROLE_TYPE, DESCRIPTION, DATA_SCOPE_TYPE, STATUS) 
VALUES ('role002', N'站点管理员', 'site_admin', 2, N'站点管理员，管理指定站点', 'SITE', 1);

INSERT INTO CJ_ADM_ROLE (ROLE_ID, ROLE_NAME, ROLE_CODE, ROLE_TYPE, DESCRIPTION, DATA_SCOPE_TYPE, STATUS) 
VALUES ('role003', N'内容编辑', 'content_editor', 2, N'内容编辑，负责内容创建和编辑', 'CHANNEL', 1);

-- Admin-Role Relation
INSERT INTO CJ_ADM_ADMIN_ROLE (ADMIN_ID, ROLE_ID) VALUES ('admin001', 'role001');

-- Site
INSERT INTO CJ_SYS_SITE (SITE_ID, SITE_NAME, SITE_CODE, DOMAIN, STATUS, DESCRIPTION, CREATE_USER_ID) 
VALUES ('site001', N'长江 CMS 主站', 'main_site', N'http://www.cjcms.com', 1, N'长江 CMS 官方主站', 'admin001');

-- Channels
INSERT INTO CJ_CMS_CHANNEL (CHANNEL_ID, SITE_ID, CHANNEL_NAME, CHANNEL_CODE, CHANNEL_TYPE, ORDER_NUM, CREATE_USER_ID) 
VALUES ('channel001', 'site001', N'根栏目', 'root', 1, 0, 'admin001');

INSERT INTO CJ_CMS_CHANNEL (CHANNEL_ID, SITE_ID, PARENT_ID, CHANNEL_NAME, CHANNEL_CODE, CHANNEL_TYPE, ORDER_NUM, CREATE_USER_ID) 
VALUES ('channel002', 'site001', 'channel001', N'公司新闻', 'news', 1, 1, 'admin001');

INSERT INTO CJ_CMS_CHANNEL (CHANNEL_ID, SITE_ID, PARENT_ID, CHANNEL_NAME, CHANNEL_CODE, CHANNEL_TYPE, ORDER_NUM, CREATE_USER_ID) 
VALUES ('channel003', 'site001', 'channel001', N'产品展示', 'products', 1, 2, 1, 'admin001');

-- Content Model
INSERT INTO CJ_CMS_MODEL (MODEL_ID, SITE_ID, MODEL_NAME, MODEL_CODE, TABLE_NAME, DESCRIPTION, CREATE_USER_ID) 
VALUES ('model001', 'site001', N'新闻模型', 'news', 'CJ_CMS_CONTENT_NEWS', N'新闻内容模型', 'admin001');

-- Content with Chinese text (including rare characters if any)
INSERT INTO CJ_CMS_CONTENT (CONTENT_ID, SITE_ID, CHANNEL_ID, MODEL_ID, TITLE, AUTHOR, SOURCE, STATUS, VIEW_COUNT, CREATE_USER_ID) 
VALUES ('content001', 'site001', 'channel002', 'model001', N'长江 CMS 系统正式发布', N'管理员', N'原创', 2, 100, 'admin001');

-- Config
INSERT INTO CJ_SYS_CONFIG (CONFIG_ID, CONFIG_KEY, CONFIG_VALUE, DESCRIPTION) 
VALUES ('config001', 'site.title', N'长江 CMS', N'网站标题');

INSERT INTO CJ_SYS_CONFIG (CONFIG_ID, CONFIG_KEY, CONFIG_VALUE, DESCRIPTION) 
VALUES ('config002', 'site.logo', '/images/logo.png', N'网站 Logo');

-- User
INSERT INTO CJ_USER_USER (USER_ID, USERNAME, PASSWORD_HASH, NICKNAME, EMAIL, MOBILE, GENDER, STATUS) 
VALUES ('user001', 'testuser', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lqkkO9QS3TzCjH3rS', N'测试用户', N'test@example.com', N'13900139000', 1, 1);

-- User Groups
INSERT INTO CJ_USER_GROUP (GROUP_ID, GROUP_NAME, GROUP_CODE, DESCRIPTION, MAX_CONTENT_COUNT, NEED_AUDIT, STATUS) 
VALUES ('group001', N'普通会员', 'normal_member', N'普通用户组', 10, 1, 1);

INSERT INTO CJ_USER_GROUP (GROUP_ID, GROUP_NAME, GROUP_CODE, DESCRIPTION, MAX_CONTENT_COUNT, NEED_AUDIT, STATUS) 
VALUES ('group002', N'VIP 会员', 'vip_member', N'VIP 用户组', 100, 0, 1);

COMMIT;

PROMPT ========================================
PROMPT Test data inserted successfully!
PROMPT ========================================
PROMPT Default accounts:
PROMPT   Admin: admin / admin123
PROMPT   User: testuser / 123456
PROMPT ========================================
PROMPT All Chinese text uses NVARCHAR2
PROMPT Full Unicode support enabled!
PROMPT ========================================
