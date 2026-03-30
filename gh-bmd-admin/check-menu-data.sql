SET PAGESIZE 100
COL menu_title FORMAT A30
COL component FORMAT A25
COL parent_id FORMAT A20

SELECT menu_id, menu_title, component, parent_id, show_flag, menu_no 
FROM auth_menu 
WHERE rownum <= 15 
ORDER BY menu_no, parent_id;
