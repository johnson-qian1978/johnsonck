SET PAGESIZE 100
COL menu_title FORMAT A20
COL unique_key FORMAT A25
COL component FORMAT A25
COL path FORMAT A40

SELECT menu_id, menu_title, unique_key, component, path FROM auth_menu WHERE menu_title LIKE '%互助办%';
