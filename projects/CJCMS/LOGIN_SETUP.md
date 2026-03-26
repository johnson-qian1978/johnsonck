# CJCMS 登录功能部署指南

## 📋 已完成的功能

✅ **前端页面**
- 登录页面 (`/login.html`) - 参考了提供的两个网站设计
- 仪表盘页面 (`/dashboard.html`) - 登录成功后的主界面
- 现代化 UI 设计，融入长江数据官网元素

✅ **后端功能**
- 用户实体类 (`Administrator`)
- 用户 Repository
- 认证服务 (`AuthService`)
- 认证控制器 (`AuthController`)
- 登录/登出 API 接口

✅ **数据库脚本**
- Oracle 初始化脚本 (`init_login.sql`)
- 包含管理员表和默认账户

## 🚀 部署步骤

### 第一步：执行数据库脚本

使用 PL/SQL Developer 或 SQL*Plus 连接 Oracle 数据库：

```bash
# 使用 PL/SQL Developer
# 1. 连接到 CJCMS@ORCL
# 2. 打开 File -> New -> Command Window
# 3. 执行以下脚本

@E:\CJCMS\database\init_login.sql
```

或者使用 SQL*Plus：
```bash
sqlplus cjcms/cjcms123@ORCL @E:\CJCMS\database\init_login.sql
```

### 第二步：验证数据库表

```sql
-- 查看管理员表
SELECT * FROM CJ_ADM_ADMINISTRATOR;

-- 应该看到两条记录：
-- admin / admin123
-- test / test123
```

### 第三步：更新应用配置

确保 `application.properties` 配置正确：

```properties
spring.datasource.url=jdbc:oracle:thin:@localhost:1521/ORCL
spring.datasource.username=cjcms
spring.datasource.password=cjcms123
```

### 第四步：运行项目

```bash
cd E:\CJCMS
mvn clean install
mvn spring-boot:run
```

### 第五步：测试登录功能

1. 打开浏览器访问：http://localhost:8080/login.html
2. 使用默认账户登录：
   - **用户名**: admin
   - **密码**: admin123
3. 登录成功后会跳转到仪表盘页面

## 📡 API 接口说明

### 登录接口
```
POST /api/auth/login
Content-Type: application/json

请求体：
{
    "username": "admin",
    "password": "admin123",
    "rememberMe": true
}

响应：
{
    "success": true,
    "message": "登录成功",
    "token": "uuid-token-string",
    "user": {
        "id": 1,
        "username": "admin",
        "realName": "系统管理员",
        "email": "admin@changjiangdata.com"
    }
}
```

### 登出接口
```
POST /api/auth/logout
Authorization: Bearer {token}
```

### 验证 Token 接口
```
GET /api/auth/validate
Authorization: Bearer {token}
```

## 🎨 页面截图说明

### 登录页面特性
- ✅ 渐变背景色（紫色主题）
- ✅ 浮动动画效果
- ✅ 公司 Logo 和名称（长江数据）
- ✅ 用户名/密码输入框带图标
- ✅ 记住我功能
- ✅ 忘记密码链接
- ✅ 公司官网链接
- ✅ 响应式设计

### 仪表盘页面特性
- ✅ 顶部导航栏
- ✅ 用户信息显示
- ✅ 统计数据卡片（文章数、发布数、浏览量等）
- ✅ 快速操作按钮
- ✅ 退出登录功能
- ✅ 自动加载统计数据

## 🔧 自定义配置

### 修改默认密码

编辑 `init_login.sql` 文件，修改密码：
```sql
INSERT INTO CJ_ADM_ADMINISTRATOR (ID, USERNAME, PASSWORD, ...) 
VALUES (CJ_ADM_ADMINISTRATOR_SEQ.NEXTVAL, 'admin', '你的新密码', ...);
```

### 修改 Logo 和公司名称

编辑 `login.html` 和 `dashboard.html`：
```html
<div class="logo">CJ</div>
<div class="company-name">长江数据</div>
```

### 修改主题颜色

在 CSS 中搜索并修改渐变色：
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

## 🔍 常见问题

### Q1: 登录提示"用户名不存在"
**解决**: 确认已执行 `init_login.sql` 脚本，检查数据库中是否有记录

### Q2: 页面无法访问
**解决**: 
1. 检查项目是否启动成功
2. 确认端口 8080 未被占用
3. 查看控制台日志

### Q3: 跨域错误
**解决**: 已在控制器添加 `@CrossOrigin(origins = "*")`，如还有问题检查浏览器控制台

### Q4: Token 无效
**解决**: Token 存储在内存中，重启服务器后会失效，需要重新登录

## 📝 下一步开发建议

1. **密码加密**: 使用 BCrypt 加密密码
2. **Token 持久化**: 使用 Redis 存储 Token
3. **角色权限**: 添加 RBAC 权限控制
4. **会话管理**: 实现 Session 管理
5. **安全加固**: 添加验证码、防止暴力破解

## 🎉 完成！

现在你已经有了一个完整的登录系统和仪表盘界面！

访问 http://localhost:8080/login.html 开始使用吧！
