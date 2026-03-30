// ============================================
// 菜单管理 API 路由
// ============================================

const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');

// 获取数据库连接
async function getConnection() {
  return await oracledb.getConnection();
}

// ============================================
// 1. 获取菜单树（全部菜单，树形结构）
// GET /api/menus/tree
// ============================================
router.get('/tree', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    // 查询所有菜单
    const result = await connection.execute(
      `SELECT menu_id, unique_key, menu_title, component, icon, path, redirect, 
              parent_id, show_flag, hide_children, last_edit_time, editor, 
              search_key, menu_no 
       FROM auth_menu 
       ORDER BY menu_no, parent_id`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    // 构建树形结构
    const menus = result.rows;
    const menuTree = buildMenuTree(menus, '0'); // 根菜单 parent_id = '0'
    
    res.json({ success: true, data: menuTree });
  } catch (err) {
    console.error('获取菜单树错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 构建树形结构的辅助函数
function buildMenuTree(menus, parentId) {
  const tree = [];
  const children = menus.filter(m => m.PARENT_ID === parentId);
  
  for (const menu of children) {
    const node = {
      id: menu.MENU_ID,
      label: menu.MENU_TITLE,
      data: menu,
      children: buildMenuTree(menus, menu.MENU_ID)
    };
    tree.push(node);
  }
  
  return tree;
}

// ============================================
// 2. 获取所有菜单列表（扁平，用于编辑器）
// GET /api/menus/list
// ============================================
router.get('/list', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const result = await connection.execute(
      `SELECT menu_id, unique_key, menu_title, component, icon, path, redirect,
              parent_id, show_flag, hide_children, search_key, menu_no, last_edit_time, editor
       FROM auth_menu 
       ORDER BY menu_no`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    res.json({ success: true, data: result.rows });
  } catch (err) {
    console.error('获取菜单列表错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 3. 获取单个菜单详情
// GET /api/menus/:id
// ============================================
router.get('/:id', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const result = await connection.execute(
      `SELECT * FROM auth_menu WHERE menu_id = :id`,
      { id: req.params.id },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: '菜单不存在' });
    }
    
    res.json({ success: true, data: result.rows[0] });
  } catch (err) {
    console.error('获取菜单详情错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 4. 新增菜单
// POST /api/menus
// ============================================
router.post('/', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const {
      menu_id, unique_key, menu_title, component, icon,
      path, redirect, parent_id, show_flag, hide_children,
      search_key, menu_no
    } = req.body;
    
    await connection.execute(
      `INSERT INTO auth_menu (
        menu_id, unique_key, menu_title, component, icon,
        path, redirect, parent_id, show_flag, hide_children,
        search_key, menu_no, last_edit_time
      ) VALUES (
        :menu_id, :unique_key, :menu_title, :component, :icon,
        :path, :redirect, :parent_id, :show_flag, :hide_children,
        :search_key, :menu_no, SYSDATE
      )`,
      {
        menu_id,
        unique_key,
        menu_title,
        component,
        icon,
        path,
        redirect,
        parent_id: parent_id || '0',
        show_flag: show_flag || '0',
        hide_children,
        search_key,
        menu_no: menu_no || 0
      },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '添加成功' });
  } catch (err) {
    console.error('添加菜单错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 5. 更新菜单
// PUT /api/menus/:id
// ============================================
router.put('/:id', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const { id } = req.params;
    const {
      unique_key, menu_title, component, icon,
      path, redirect, parent_id, show_flag, hide_children,
      search_key, menu_no
    } = req.body;
    
    await connection.execute(
      `UPDATE auth_menu SET
        unique_key = :unique_key,
        menu_title = :menu_title,
        component = :component,
        icon = :icon,
        path = :path,
        redirect = :redirect,
        parent_id = :parent_id,
        show_flag = :show_flag,
        hide_children = :hide_children,
        search_key = :search_key,
        menu_no = :menu_no,
        last_edit_time = SYSDATE
      WHERE menu_id = :id`,
      {
        unique_key,
        menu_title,
        component,
        icon,
        path,
        redirect,
        parent_id,
        show_flag,
        hide_children,
        search_key,
        menu_no,
        id
      },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '更新成功' });
  } catch (err) {
    console.error('更新菜单错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 6. 删除菜单
// DELETE /api/menus/:id
// ============================================
router.delete('/:id', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const { id } = req.params;
    
    // 检查是否有子菜单
    const childCheck = await connection.execute(
      `SELECT COUNT(*) as cnt FROM auth_menu WHERE parent_id = :id`,
      { id },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (childCheck.rows[0].CNT > 0) {
      return res.status(400).json({ 
        success: false, 
        message: '该菜单下有子菜单，无法删除' 
      });
    }
    
    // 检查是否有关联按钮
    const buttonCheck = await connection.execute(
      `SELECT COUNT(*) as cnt FROM auth_menu_button WHERE menu_id = :id`,
      { id },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (buttonCheck.rows[0].CNT > 0) {
      return res.status(400).json({ 
        success: false, 
        message: '该菜单已关联按钮，请先删除关联按钮' 
      });
    }
    
    // 删除菜单
    await connection.execute(
      `DELETE FROM auth_menu WHERE menu_id = :id`,
      { id },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '删除成功' });
  } catch (err) {
    console.error('删除菜单错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 7. 获取菜单的按钮列表
// GET /api/menus/:id/buttons
// ============================================
router.get('/:id/buttons', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const result = await connection.execute(
      `SELECT * FROM auth_menu_button 
       WHERE menu_id = :menu_id 
       ORDER BY button_order`,
      { menu_id: req.params.id },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    res.json({ success: true, data: result.rows });
  } catch (err) {
    console.error('获取菜单按钮错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 8. 添加按钮到菜单
// POST /api/menus/:id/buttons
// ============================================
router.post('/:id/buttons', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const { menu_id } = req.params;
    const { 
      button_name, 
      button_sign, 
      button_url, 
      button_order 
    } = req.body;
    
    // 生成 UUID
    const menu_button_id = generateUUID();
    
    await connection.execute(
      `INSERT INTO auth_menu_button (
        menu_button_id, menu_id, button_name, button_sign,
        button_url, button_order, last_edit_time
      ) VALUES (
        :menu_button_id, :menu_id, :button_name, :button_sign,
        :button_url, :button_order, SYSDATE
      )`,
      {
        menu_button_id,
        menu_id,
        button_name,
        button_sign,
        button_url,
        button_order
      },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '添加成功' });
  } catch (err) {
    console.error('添加菜单按钮错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 9. 更新菜单按钮
// PUT /api/menus/buttons/:buttonId
// ============================================
router.put('/buttons/:buttonId', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const { buttonId } = req.params;
    const { 
      button_name, 
      button_sign, 
      button_url, 
      button_order 
    } = req.body;
    
    await connection.execute(
      `UPDATE auth_menu_button SET
        button_name = :button_name,
        button_sign = :button_sign,
        button_url = :button_url,
        button_order = :button_order,
        last_edit_time = SYSDATE
      WHERE menu_button_id = :buttonId`,
      {
        button_name,
        button_sign,
        button_url,
        button_order,
        buttonId
      },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '更新成功' });
  } catch (err) {
    console.error('更新菜单按钮错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// ============================================
// 10. 删除菜单按钮
// DELETE /api/menus/buttons/:buttonId
// ============================================
router.delete('/buttons/:buttonId', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    
    const { buttonId } = req.params;
    
    await connection.execute(
      `DELETE FROM auth_menu_button 
       WHERE menu_button_id = :buttonId`,
      { buttonId },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '删除成功' });
  } catch (err) {
    console.error('删除菜单按钮错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 生成 UUID 的辅助函数
function generateUUID() {
  return 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'.replace(/[x]/g, () => {
    const r = Math.random() * 16 | 0;
    return r.toString(16).toUpperCase();
  });
}

module.exports = router;
