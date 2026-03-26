-- Add Role Management menu item
-- Execute in PL/SQL Developer (F8)

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008-05', 'menu008', 'Role Management', 'admin:role', 2, '/admin/role', 'el-icon-s-custom', 5, 1, 1);

COMMIT;

-- Verify insertion
SELECT MENU_ID, MENU_NAME, ROUTE_PATH FROM CJ_SYS_MENU WHERE MENU_CODE = 'admin:role';
