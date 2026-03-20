SET PAGESIZE 50
COL menu_title FORMAT A30
COL unique_key FORMAT A20
COL component FORMAT A20

SELECT menu_id, menu_title, unique_key, component FROM auth_menu WHERE ROWNUM <= 10;
