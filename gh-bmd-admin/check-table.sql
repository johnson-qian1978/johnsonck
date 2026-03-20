SET PAGESIZE 100
COL column_name FORMAT A30
COL data_type FORMAT A20
COL nullable FORMAT A8
SELECT column_name, data_type, nullable FROM user_tab_columns WHERE table_name = 'GH_BMD' ORDER BY column_id;
EXIT;
