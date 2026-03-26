# 🚀 CJCMS Spring Boot 应用 - 启动说明

## ⚠️ 前置要求

### 1. 安装 JDK 17+
下载地址：https://adoptium.net/

验证安装：
```bash
java -version
```

### 2. 安装 Maven
下载地址：https://maven.apache.org/download.cgi

安装后配置环境变量：
- MAVEN_HOME: `C:\Program Files\Apache\maven`
- PATH: 添加 `%MAVEN_HOME%\bin`

验证安装：
```bash
mvn -version
```

### 3. Oracle 数据库
确保 Oracle 数据库已启动，并且：
- 用户名：CJCMS
- 密码：1
- 数据库：ORCL

## 📦 首次启动步骤

### 方法 1: 使用 IDE（推荐）

#### IntelliJ IDEA
1. 打开 IDEA → File → Open → 选择 `E:\CJCMS` 目录
2. 等待 Maven 依赖下载完成
3. 右键 `CJCmsApplication.java` → Run 'CJCmsApplication'

#### Eclipse
1. 打开 Eclipse → File → Import → Existing Maven Projects
2. 选择 `E:\CJCMS` 目录
3. 右键项目 → Run As → Spring Boot App

### 方法 2: 使用命令行

```bash
cd E:\CJCMS
mvn clean install
mvn spring-boot:run
```

### 方法 3: 使用启动脚本（需要先安装 Maven）

双击 `E:\CJCMS\start.bat`

## 🌐 访问应用

启动成功后，在浏览器中访问：

### 登录页面
```
http://localhost:8080/login.html
```

**默认账号**:
- 用户名：`admin`
- 密码：`admin123`

### 首页
```
http://localhost:8080/index.html
```
（需要先登录）

## ✅ 成功标志

启动成功后，控制台会显示：
```
========================================
   长江 CMS 系统启动成功！
   访问地址：http://localhost:8080
========================================
```

## 🔍 功能测试

### 1. 测试登录
1. 打开 http://localhost:8080/login.html
2. 输入用户名：`admin`
3. 输入密码：`admin123`
4. 点击"登录"按钮
5. 应该跳转到首页

### 2. 测试菜单
1. 登录后查看左侧菜单栏
2. 应该能看到所有菜单项：
   - 站群管理
   - 信息管理
   - 素材管理
   - ...等 13 个一级菜单
3. 点击菜单可以展开子菜单

### 3. 测试退出
1. 点击右上角的"退出"按钮
2. 确认后应该返回登录页

## 🐛 常见问题

### 问题 1: 端口 8080 被占用
**错误信息**: `Port 8080 was already in use`

**解决方法**:
1. 修改 `application.yml` 中的端口号：
   ```yaml
   server:
     port: 8081  # 改为其他端口
   ```
2. 或者关闭占用 8080 端口的程序

### 问题 2: 数据库连接失败
**错误信息**: `ORA-12514, TNS:listener does not currently know of service`

**解决方法**:
1. 检查 Oracle 服务是否启动
2. 检查数据库名是否为 `ORCL`
3. 检查用户名密码是否正确

### 问题 3: 登录失败
**错误信息**: `用户名或密码错误`

**解决方法**:
1. 确认数据库中有测试数据
2. 执行以下 SQL 验证：
   ```sql
   SELECT username, real_name FROM cj_adm_administrator WHERE username='admin';
   ```
3. 如果没有数据，重新执行 `insert_data_nvarchar2.sql`

### 问题 4: 菜单加载失败
**错误信息**: 左侧菜单为空

**解决方法**:
1. 检查菜单数据是否插入成功：
   ```sql
   SELECT COUNT(*) FROM cj_sys_menu;
   ```
2. 应该返回 55 或 56 条记录
3. 如果没有，重新执行菜单插入脚本

## 📝 开发计划

### 已完成 ✅
- [x] 项目框架搭建
- [x] 数据库连接配置
- [x] 登录功能
- [x] 菜单展示
- [x] 首页布局

### 待开发 📋
- [ ] 内容管理模块
- [ ] 栏目管理模块
- [ ] 素材管理模块
- [ ] 用户管理模块
- [ ] 角色权限管理
- [ ] 数据统计图表

## 📞 获取帮助

如有问题，请查看：
1. 控制台日志
2. 需求文档：`E:\CJCMS\docs\01-需求规格说明书.md`
3. 设计文档：`E:\CJCMS\docs\04-系统详细设计说明书.md`

---

**创建时间**: 2026-03-24  
**最后更新**: 2026-03-24 11:45
