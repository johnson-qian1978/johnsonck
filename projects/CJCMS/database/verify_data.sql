SET PAGESIZE 100
SET LINESIZE 200
COL username FORMAT A15
COL real_name FORMAT A20
COL department FORMAT A20

PROMPT ========================================
PROMPT 验证管理员数据
PROMPT ========================================
SELECT username, real_name, department, email FROM cj_adm_administrator WHERE username='admin';

PROMPT
PROMPT ========================================
PROMPT 验证角色数据
PROMPT ========================================
SELECT role_name, role_code, description FROM cj_adm_role;

PROMPT
PROMPT ========================================
PROMPT 验证站点数据
PROMPT ========================================
SELECT site_name, site_code, description FROM cj_sys_site;

PROMPT
PROMPT ========================================
PROMPT 验证栏目数据
PROMPT ========================================
SELECT channel_name, channel_code FROM cj_cms_channel;

PROMPT
PROMPT ========================================
PROMPT 验证内容数据
PROMPT ========================================
SELECT title, author, source FROM cj_cms_content;

PROMPT
PROMPT ========================================
PROMPT 验证用户数据
PROMPT ========================================
SELECT username, nickname, email FROM cj_user_user;

PROMPT
PROMPT ========================================
PROMPT 验证用户组数据
PROMPT ========================================
SELECT group_name, group_code, description FROM cj_user_group;

PROMPT
PROMPT ========================================
PROMPT 统计信息
PROMPT ========================================
SELECT '管理员：' || COUNT(*) as 统计 FROM cj_adm_administrator
UNION ALL SELECT '角色：' || COUNT(*) FROM cj_adm_role
UNION ALL SELECT '站点：' || COUNT(*) FROM cj_sys_site
UNION ALL SELECT '栏目：' || COUNT(*) FROM cj_cms_channel
UNION ALL SELECT '内容：' || COUNT(*) FROM cj_cms_content
UNION ALL SELECT '用户：' || COUNT(*) FROM cj_user_user
UNION ALL SELECT '用户组：' || COUNT(*) FROM cj_user_group;
