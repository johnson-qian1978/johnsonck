SET PAGESIZE 200
COL table_name FORMAT A25
COL column_name FORMAT A30
COL data_type FORMAT A20
BREAK ON table_name SKIP 1

SELECT table_name, column_name, data_type, nullable 
FROM user_tab_columns 
WHERE table_name IN ('AUTH_MENU', 'AUTH_BUTTON', 'AUTH_MENU_BUTTON') 
ORDER BY table_name, column_id;
