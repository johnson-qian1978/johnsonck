-- ========================================
-- 添加菜单管理到管理员管理下
-- 在 PL/SQL Developer 中按 F8 执行
-- ========================================

INSERT INTO CJ_SYS_MENU (MENU_ID, PARENT_ID, MENU_NAME, MENU_CODE, MENU_TYPE, ROUTE_PATH, ICON, ORDER_NUM, IS_VISIBLE, STATUS) 
VALUES ('menu008-04', 'menu008', N'菜单管理', 'admin:menu', 2, '/admin/menu', N'🗂️', 4, 1, 1);

COMMIT;

-- 验证插入结果
SELECT MENU_ID, MENU_NAME, ROUTE_PATH FROM CJ_SYS_MENU WHERE MENU_CODE = 'admin:menu';

PROMPT ========================================
PROMPT ✅ 菜单管理菜单已添加到数据库
PROMPT ========================================
PROMPT 请刷新浏览器查看左侧菜单
