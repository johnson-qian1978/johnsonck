const oracledb = require('oracledb');

async function testConnection() {
  let connection;
  
  const config = {
    user: 'whylhznw',
    password: '1',
    connectString: '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orcl)))'
  };
  
  try {
    console.log('正在连接 Oracle 数据库...');
    console.log('配置:', JSON.stringify(config, null, 2));
    
    connection = await oracledb.getConnection(config);
    console.log('✅ 连接成功！');
    
    const result = await connection.execute(
      'SELECT COUNT(*) as cnt FROM GH_BMD',
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    console.log('查询结果:', result.rows);
    
    await connection.close();
    console.log('连接已关闭');
    
  } catch (err) {
    console.error('❌ 连接失败:', err.message);
    console.error('错误代码:', err.code);
    if (err.cause) {
      console.error('Oracle 错误:', err.cause);
    }
  }
}

testConnection();
