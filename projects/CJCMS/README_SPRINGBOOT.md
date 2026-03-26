# CJCMS Spring Boot 应用

## 📁 项目结构

```
E:\CJCMS/
├── pom.xml                          # Maven 配置文件
├── start.bat                        # 启动脚本
├── src/main/
│   ├── java/com/cjcms/
│   │   ├── CJCmsApplication.java    # 主启动类
│   │   ├── config/
│   │   │   └── WebConfig.java       # Web 配置
│   │   ├── controller/
│   │   │   ├── AuthController.java  # 认证控制器
│   │   │   └── MenuController.java  # 菜单控制器
│   │   ├── entity/
│   │   │   ├── Administrator.java   # 管理员实体
│   │   │   └── Menu.java            # 菜单实体
│   │   ├── mapper/
│   │   │   ├── AdministratorMapper.java
│   │   │   └── MenuMapper.java
│   │   └── service/
│   │       ├── AdministratorService.java
│   │       ├── MenuService.java
│   │       └── impl/
│   ├── resources/
│   │   ├── application.yml          # 应用配置
│   │   └── static/
│   │       ├── login.html           # 登录页面
│   │       └── index.html           # 首页（带左侧菜单）
```

## 🚀 快速开始

### 1. 启动应用

**方法 1: 使用启动脚本**
```bash
cd E:\CJCMS
start.bat
```

**方法 2: 使用 Maven 命令**
```bash
cd E:\CJCMS
mvn spring-boot:run
```

### 2. 访问应用

- **登录页面**: http://localhost:8080/login.html
- **首页**: http://localhost:8080/index.html

### 3. 默认账号

```
用户名：admin
密码：admin123
```

## 📋 已实现的功能

### ✅ 后端功能

1. **认证模块**
   - 登录接口 (`POST /api/auth/login`)
   - 登出接口 (`POST /api/auth/logout`)
   - BCrypt 密码加密
   - 登录日志记录

2. **菜单模块**
   - 获取菜单树接口 (`GET /api/menu/tree`)
   - 支持多级菜单
   - 菜单权限控制（预留）

3. **数据库集成**
   - MyBatis Plus ORM
   - Oracle 数据库连接
   - 实体类映射

### ✅ 前端功能

1. **登录页面**
   - 美观的渐变背景
   - Element Plus UI 组件
   - 表单验证
   - 登录状态提示

2. **首页**
   - 左侧菜单栏（动态加载）
   - 顶部导航栏
   - 欢迎卡片
   - 数据统计展示
   - 快捷操作按钮
   - 退出登录功能

## 🔧 技术栈

### 后端
- **框架**: Spring Boot 3.2.0
- **ORM**: MyBatis Plus 3.5.5
- **数据库**: Oracle 11g/12c/19c
- **安全**: Spring Security (BCrypt)
- **JWT**: jjwt 0.12.3

### 前端
- **框架**: Vue 3
- **UI 库**: Element Plus
- **HTTP 客户端**: Axios
- **图标**: Element Plus Icons

## 📝 API 接口

### 认证接口

#### 1. 登录
```http
POST /api/auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "admin123"
}
```

响应：
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "token": "mock-jwt-token-admin001",
    "user": {
      "adminId": "admin001",
      "username": "admin",
      "realName": "超级管理员"
    }
  }
}
```

#### 2. 登出
```http
POST /api/auth/logout
```

### 菜单接口

#### 获取菜单树
```http
GET /api/menu/tree
```

响应：
```json
{
  "code": 200,
  "data": [
    {
      "menuId": "menu001",
      "menuName": "站群管理",
      "menuCode": "site-management",
      "icon": "el-icon-connection",
      "children": [
        {
          "menuId": "menu001-01",
          "menuName": "站点列表",
          "routePath": "/site/list"
        }
      ]
    }
  ]
}
```

## ⚙️ 配置说明

### application.yml

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:oracle:thin:@localhost:1521/ORCL
    username: CJCMS
    password: "1"
```

## 🐛 常见问题

### 1. 启动失败：端口被占用
**解决**: 修改 `application.yml` 中的端口号

### 2. 数据库连接失败
**解决**: 
- 检查 Oracle 服务是否启动
- 检查用户名密码是否正确
- 检查网络连接

### 3. 登录失败
**解决**: 
- 确认数据库中有测试数据
- 检查密码是否正确（默认：admin123）
- 查看控制台日志

## 📊 下一步开发计划

### 待实现功能
1. **内容管理模块**
   - 内容列表
   - 内容创建/编辑
   - 内容审核

2. **栏目管理模块**
   - 栏目树展示
   - 栏目增删改查

3. **素材管理模块**
   - 图片上传
   - 文件管理

4. **系统管理模块**
   - 管理员管理
   - 角色管理
   - 权限管理

## 📞 技术支持

如有问题，请查看：
- 需求规格说明书：`E:\CJCMS\docs\01-需求规格说明书.md`
- 详细设计说明书：`E:\CJCMS\docs\04-系统详细设计说明书.md`

---

**创建时间**: 2026-03-24  
**版本**: 1.0.0-SNAPSHOT  
**状态**: ✅ 基础框架完成
