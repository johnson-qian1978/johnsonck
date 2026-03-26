# CJCMS Oracle 数据库配置检查清单

## ✅ 完成以下配置后，项目才能正常运行

### 1. Oracle 数据库准备

- [ ] Oracle 数据库已安装并运行
- [ ] 监听器已启动（默认端口 1521）
- [ ] 服务名已知（例如：ORCL, XEPDB1 等）

### 2. 创建数据库用户

使用 sysdba 登录执行：
```sql
-- 创建用户
CREATE USER cjcms IDENTIFIED BY cjcms123;

-- 授权
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO cjcms;
```

### 3. 执行初始化脚本

```bash
# 方式一：使用 SQL*Plus
sqlplus cjcms/cjcms123@localhost:1521/ORCL @E:\CJCMS\database\init_oracle.sql

# 方式二：使用 SQL Developer
# 打开 E:\CJCMS\database\init_oracle.sql 并执行
```

### 4. 修改应用配置

编辑文件：`E:\CJCMS\src\main\resources\application.properties`

```properties
# 修改为你的实际配置
spring.datasource.url=jdbc:oracle:thin:@localhost:1521/你的服务名
spring.datasource.username=cjcms
spring.datasource.password=你的密码
```

### 5. 验证连接

```bash
# 使用 tnsping 测试连接（如果安装了 Oracle 客户端）
tnsping ORCL

# 或使用 sqlplus 测试
sqlplus cjcms/cjcms123@localhost:1521/ORCL
```

### 6. 启动项目

```bash
cd E:\CJCMS
mvn clean install
mvn spring-boot:run
```

### 7. 测试 API

```bash
# 获取所有文章
curl http://localhost:8080/api/articles

# 或浏览器访问
http://localhost:8080/api/articles
```

## 🔍 常见问题排查

### 问题 1: 无法连接到 Oracle
**症状**: `ORA-12541: TNS:no listener`
**解决**: 
```bash
# 启动监听器
lsnrctl start
```

### 问题 2: 用户不存在
**症状**: `ORA-01017: invalid username/password`
**解决**: 确认用户名密码正确，或重新创建用户

### 问题 3: 表不存在
**症状**: `ORA-00942: table or view does not exist`
**解决**: 确保已执行 init_oracle.sql 脚本

### 问题 4: 序列不存在
**症状**: `ORA-02289: sequence does not exist`
**解决**: 确保已执行 init_oracle.sql 脚本创建序列

## 📞 需要帮助？

如果遇到其他问题，请提供完整的错误信息！
