# 🚀 CJCMS 立即启动指南

## ✅ 环境已就绪

- ✅ **JDK 26**: `D:\Program Files\Java\jdk-26`
- ✅ **Oracle 数据库**: 已连接 (CJCMS@ORCL, 密码：1)
- ✅ **项目位置**: `E:\CJCMS`
- ✅ **代码已更新**: 匹配现有数据库表结构

---

## 🎯 三种启动方式

### 方式一：使用启动脚本（最简单）⭐

1. **双击运行**:
   ```
   E:\CJCMS\start-jdk26.bat
   ```

2. **等待启动完成**

3. **浏览器访问**:
   ```
   http://localhost:8080/login.html
   ```

---

### 方式二：在 Trae CN 终端中运行（推荐）⭐⭐⭐

#### 步骤：

1. **打开 Trae CN**

2. **打开项目文件夹**:
   - 文件 → 打开文件夹
   - 选择 `E:\CJCMS`

3. **打开终端**:
   - 按 `` Ctrl + ` `` (反引号)
   - 或 查看 → 终端

4. **执行命令**:

```powershell
# 设置 JDK 26
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
$env:PATH="$env:JAVA_HOME\bin;$env:PATH"

# 验证 Java
java -version

# 编译并运行
mvn clean spring-boot:run
```

5. **访问应用**:
   - 登录页面：http://localhost:8080/login.html
   - API 测试：http://localhost:8080/api/auth/login

---

### 方式三：使用 IDE 直接运行

#### 在 Trae CN 中：

1. **打开项目**: `E:\CJCMS`

2. **找到主类**:
   - 导航到：`src/main/java/com/cjcms/CjcmsApplication.java`

3. **右键运行**:
   - 右键点击文件
   - 选择 "Run" 或按 `F5`

4. **等待启动**

---

## 🔐 登录测试

### 查询现有管理员账户

在 PL/SQL Developer 中执行：
```sql
SELECT USERNAME, REAL_NAME, STATUS FROM CJ_ADM_ADMINISTRATOR;
```

### 可能的默认账户

根据你的数据库，可能已有以下账户：
- 用户名：`admin` / 密码：需要查询数据库
- 或其他管理员账户

### 如果忘记密码

可以在 PL/SQL Developer 中重置：
```sql
-- 注意：实际密码是加密存储的
-- 这里只是示例，需要根据你的加密方式调整
UPDATE CJ_ADM_ADMINISTRATOR 
SET PASSWORD_HASH = 'test123' 
WHERE USERNAME = 'admin';
```

---

## 📊 验证清单

启动前确认：

- [ ] JDK 26 已安装 (`java -version` 显示 26)
- [ ] Oracle 数据库可连接
- [ ] 项目文件夹 `E:\CJMS` 已打开
- [ ] 终端可以执行命令

启动后验证：

- [ ] 控制台显示 "CJCMS 启动成功"
- [ ] 端口 8080 已监听
- [ ] 浏览器可以访问登录页面
- [ ] 可以看到登录界面

---

## 🔍 常见问题

### Q1: 提示找不到 java 命令
**解决**: 
```powershell
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
$env:PATH="$env:JAVA_HOME\bin;$env:PATH"
```

### Q2: Maven 未找到
**解决**: 
- 使用启动脚本 `start-jdk26.bat`
- 或安装 Maven: `choco install maven`

### Q3: 端口 8080 被占用
**解决**: 
编辑 `application.properties`:
```properties
server.port=8081
```

### Q4: 数据库连接失败
**解决**: 
确认配置正确：
```properties
spring.datasource.url=jdbc:oracle:thin:@localhost:1521/ORCL
spring.datasource.username=CJCMS
spring.datasource.password=1
```

---

## 🎉 成功标志

当你看到以下输出时，说明启动成功：

```
=================================
CJCMS 启动成功！
=================================
Tomcat started on port(s): 8080 (http)
```

然后就可以：
1. 打开浏览器
2. 访问 http://localhost:8080/login.html
3. 输入用户名和密码
4. 点击登录

---

## 📞 下一步

启动成功后：
1. 测试登录功能
2. 查看仪表盘
3. 管理文章
4. 开发新功能

**现在就开始吧！** 🚀

如果遇到问题，随时告诉我！
