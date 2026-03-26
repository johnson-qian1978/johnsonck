-- 添加菜单管理菜单到管理员管理下
INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008-04', 'menu008', '菜单管理', 'admin:menu', 2, '/admin/menu', '🗂️', 4, 1, 1);

COMMIT;

PROMPT ✅ 菜单管理菜单已添加
