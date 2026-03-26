-- Add menu management menu item
-- Execute in PL/SQL Developer (F8)

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008-04', 'menu008', 'Menu Management', 'admin:menu', 2, '/admin/menu', 'el-icon-s-operation', 4, 1, 1);

COMMIT;

-- Verify insertion
SELECT MENU_ID, MENU_NAME, ROUTE_PATH FROM CJ_SYS_MENU WHERE MENU_CODE = 'admin:menu';
