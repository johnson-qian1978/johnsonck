const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const oracledb = require('oracledb');

const app = express();
const PORT = 3000;

// 中间件
app.use(cors());
app.use(bodyParser.json());
app.use(express.static('public'));

// 路由
const menuRoutes = require('./routes/menus');
app.use('/api/menus', menuRoutes);

// 启用 Thick 模式（需要 Oracle 客户端）- 支持 Oracle 11g
try {
  oracledb.initOracleClient({ libDir: 'E:\\app\\27151\\product\\11.2.0\\dbhome_1\\bin' });
  console.log('✅ Oracle Thick 模式已初始化');
} catch (err) {
  console.error('⚠️  Thick 模式初始化失败，尝试使用 Thin 模式:', err.message);
}

// Oracle 数据库配置
const dbConfig = {
  user: 'whylhznw',
  password: '1',
  connectString: '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orcl)))'
};

// 初始化数据库连接池
async function initDB() {
  try {
    await oracledb.createPool({
      user: dbConfig.user,
      password: dbConfig.password,
      connectString: dbConfig.connectString,
      poolMin: 2,
      poolMax: 10,
      poolIncrement: 1
    });
    console.log('✅ 数据库连接池初始化成功');
  } catch (err) {
    console.error('❌ 数据库连接失败:', err.message);
    console.error('请检查 Oracle 服务是否启动，TNS 配置是否正确');
  }
}

// 获取所有 BMD 数据
app.get('/api/bmd', async (req, res) => {
  let connection;
  try {
    connection = await oracledb.getConnection();
    const result = await connection.execute(
      `SELECT id, name, type, bak FROM GH_BMD ORDER BY id`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    res.json({ success: true, data: result.rows });
  } catch (err) {
    console.error('查询错误:', err.message);
    res.status(500).json({ 
      success: false, 
      message: err.message,
      hint: '请检查 Oracle 数据库服务是否正常运行'
    });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 新增 BMD
app.post('/api/bmd', async (req, res) => {
  let connection;
  try {
    connection = await oracledb.getConnection();
    const { id, name, type, bak } = req.body;
    
    await connection.execute(
      `INSERT INTO GH_BMD (id, name, type, bak) VALUES (:id, :name, :type, :bak)`,
      { id, name, type, bak },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '添加成功' });
  } catch (err) {
    console.error('添加错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 更新 BMD
app.put('/api/bmd/:id', async (req, res) => {
  let connection;
  try {
    connection = await oracledb.getConnection();
    const { id } = req.params;
    const { name, type, bak } = req.body;
    
    await connection.execute(
      `UPDATE GH_BMD SET name = :name, type = :type, bak = :bak WHERE id = :id`,
      { name, type, bak, id },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '更新成功' });
  } catch (err) {
    console.error('更新错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 删除 BMD
app.delete('/api/bmd/:id', async (req, res) => {
  let connection;
  try {
    connection = await oracledb.getConnection();
    const { id } = req.params;
    
    await connection.execute(
      `DELETE FROM GH_BMD WHERE id = :id`,
      { id },
      { autoCommit: true }
    );
    
    res.json({ success: true, message: '删除成功' });
  } catch (err) {
    console.error('删除错误:', err.message);
    res.status(500).json({ success: false, message: err.message });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) {}
    }
  }
});

// 启动服务器
app.listen(PORT, async () => {
  await initDB();
  console.log(`🚀 服务器运行在 http://localhost:${PORT}`);
});
