-- CJCMS Database Verification Report
-- Run this in PL/SQL Developer to see Chinese characters correctly

SET PAGESIZE 100
SET LINESIZE 200
COL username FORMAT A15 HEADING '用户名'
COL real_name FORMAT A20 HEADING '真实姓名'
COL department FORMAT A20 HEADING '部门'

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  管理员信息
PROMPT ════════════════════════════════════════
SELECT username, real_name, department FROM cj_adm_administrator;

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  角色信息
PROMPT ════════════════════════════════════════
SELECT role_name, role_code FROM cj_adm_role;

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  站点信息
PROMPT ════════════════════════════════════════
SELECT site_name, description FROM cj_sys_site;

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  栏目信息
PROMPT ════════════════════════════════════════
SELECT channel_name FROM cj_cms_channel;

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  内容信息
PROMPT ════════════════════════════════════════
SELECT title, author FROM cj_cms_content;

PROMPT
PROMPT ════════════════════════════════════════
PROMPT  统计
PROMPT ════════════════════════════════════════
SELECT COUNT(*) as "管理员数量" FROM cj_adm_administrator;
SELECT COUNT(*) as "角色数量" FROM cj_adm_role;
SELECT COUNT(*) as "站点数量" FROM cj_sys_site;
SELECT COUNT(*) as "栏目数量" FROM cj_cms_channel;
SELECT COUNT(*) as "内容数量" FROM cj_cms_content;
