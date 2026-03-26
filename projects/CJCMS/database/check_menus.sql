-- 简单验证菜单数据
SELECT menu_code, order_num FROM cj_sys_menu WHERE parent_id IS NULL ORDER BY order_num;
SELECT COUNT(*) AS total_menus FROM cj_sys_menu;
SELECT COUNT(*) AS level1_menus FROM cj_sys_menu WHERE parent_id IS NULL;
SELECT COUNT(*) AS level2_menus FROM cj_sys_menu WHERE parent_id IS NOT NULL;
