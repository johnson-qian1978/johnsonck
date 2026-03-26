SET PAGESIZE 100
SET LINESIZE 200
COL menu_name FORMAT A30
COL menu_code FORMAT A30
COL route_path FORMAT A30

PROMPT ========================================
PROMPT 一级菜单（目录）
PROMPT ========================================
SELECT menu_name, menu_code, route_path, order_num 
FROM cj_sys_menu 
WHERE parent_id IS NULL 
ORDER BY order_num;

PROMPT
PROMPT ========================================
PROMPT 二级菜单统计
PROMPT ========================================
SELECT p.menu_name AS 父菜单，COUNT(c.menu_id) AS 子菜单数量
FROM cj_sys_menu p
LEFT JOIN cj_sys_menu c ON p.menu_id = c.parent_id
WHERE p.parent_id IS NULL
GROUP BY p.menu_name, p.order_num
ORDER BY p.order_num;

PROMPT
PROMPT ========================================
PROMPT 菜单总数
PROMPT ========================================
SELECT COUNT(*) AS 总菜单数 FROM cj_sys_menu;
