# CJCMS - 长江数据内容管理系统

## 📖 项目简介

CJCMS（ChangJiang Content Management System）是一个基于 Oracle 数据库的企业级内容管理系统，提供完整的站点管理、内容发布、用户权限管理等功能。

**技术栈**:
- **数据库**: Oracle 11g (ZHS16GBK 字符集)
- **表结构**: 14 个核心表（ss_前缀）
- **开发语言**: Java (兼容 JDK 21+)
- **框架**: Spring Boot 3.2.4

---

## 🎯 核心功能

### 1. 站点管理
- ✅ 多站点支持（`ss_Site`）
- ✅ 栏目管理（`ss_Channel`）
- ✅ 栏目分组（`ss_ChannelGroup`）
- ✅ 模板管理（`ss_Template`）

### 2. 内容管理
- ✅ 内容发布（`ss_Content`）
- ✅ 内容审核（`ss_ContentCheck`）
- ✅ 草稿/发布状态管理

### 3. 用户与权限
- ✅ 管理员管理（`ss_Administrator`）
- ✅ 角色管理（`ss_Role`）
- ✅ 管理员角色关联（`ss_AdminRole`）
- ✅ 普通用户管理（`ss_User`）

### 4. 系统管理
- ✅ 系统配置（`ss_Config`）
- ✅ API 密钥管理（`ss_AccessToken`）
- ✅ 操作日志（`ss_Log`）
- ✅ 错误日志（`ss_ErrorLog`）

---

## 📊 数据库结构

### 表列表（共 14 个）

| 序号 | 表名 | 中文名称 | 说明 |
|------|------|---------|------|
| 1 | ss_AccessToken | API 密钥表 | 存储访问 REST API 的密钥 |
| 2 | ss_Administrator | 管理员表 | 存储管理员信息 |
| 3 | ss_AdminRole | 管理员角色表 | 存储管理员与角色的关系 |
| 4 | ss_Channel | 栏目表 | 存储站点下的栏目信息 |
| 5 | ss_ChannelGroup | 栏目组表 | 存储栏目组信息 |
| 6 | ss_Config | 系统配置表 | 存储系统配置信息 |
| 7 | ss_Content | 内容表 | 存储站点内容数据 |
| 8 | ss_ContentCheck | 内容审核表 | 存储内容审核信息 |
| 9 | ss_ErrorLog | 错误日志表 | 存储所有报错信息 |
| 10 | ss_Log | 管理员操作日志表 | 存储管理员所执行的动作日志 |
| 11 | ss_Role | 角色表 | 存储管理员角色信息 |
| 12 | ss_Site | 站点表 | 存储站点信息 |
| 13 | ss_Template | 模板表 | 存储站点的模板信息 |
| 14 | ss_User | 用户表 | 存储用户信息 |

详细的表结构设计请查看：[database-design.md](./database-design.md)

---

## 🚀 快速开始

### 环境要求
- Oracle 11g 或更高版本
- JDK 21+
- Maven 3.6+

### 数据库初始化

1. **连接数据库**
```bash
sqlplus your_username/your_password@ORCL
```

2. **执行建表脚本**
```sql
@E:\CJCMS\database\sscms_core_tables.sql
```

3. **验证表是否创建成功**
```sql
SELECT COUNT(*) FROM USER_TABLES WHERE TABLE_NAME LIKE 'SS_%';
-- 应该返回 14
```

### 应用启动

1. **配置数据库连接**
   
   编辑 `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:oracle:thin:@localhost:1521/ORCL
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

2. **编译并运行**
   ```bash
   cd E:\CJCMS
   mvn clean spring-boot:run
   ```

3. **访问系统**
   - 登录页面：http://localhost:8080/login.html
   - 控制台：http://localhost:8080/dashboard.html

---

## 📁 项目结构

```
E:\CJCMS\
├── docs/                      # 文档目录
│   ├── database-design.md    # 数据库设计文档
│   └── README.md             # 本文件
├── src/                       # 源代码
│   ├── main/java/com/cjcms/  # Java 源码
│   │   ├── controller/       # 控制器层
│   │   ├── model/           # 实体类
│   │   ├── repository/      # 数据访问层
│   │   └── service/         # 业务逻辑层
│   └── main/resources/       # 资源文件
│       ├── application.properties  # 配置文件
│       └── static/           # 静态资源
└── database/                  # 数据库脚本
    └── sscms_core_tables.sql # 核心建表脚本
```

---

## 🔐 默认账户

系统初始化后，可以使用以下账户登录：

| 用户名 | 密码 | 角色 | 说明 |
|--------|------|------|------|
| admin | admin123 | 超级管理员 | 拥有所有权限 |
| test | test123 | 测试用户 | 普通用户权限 |

⚠️ **重要提示**: 首次登录后请立即修改默认密码！

---

## 📝 开发指南

### 添加新表

1. 在 `database/` 目录创建新的建表脚本
2. 使用 `ss_` 前缀命名表名
3. 为表和所有字段添加中文注释
4. 更新本文档和 `database-design.md`

### 编码规范

- **表名**: `ss_` + 驼峰命名（如 `ss_AccessToken`）
- **字段名**: 大写 + 下划线（如 `USER_NAME`）
- **主键**: 统一使用 `ID`（NUMBER(19)）
- **外键**: `{关联表}_ID`（NUMBER(19)）
- **中文注释**: 所有表和字段必须有中文注释

---

## 🛠️ 常见问题

### Q1: 表创建失败，提示"标识符过长"
**解决**: Oracle 11g 限制标识符最长 30 字符，请使用简化后的表名（ss_前缀）。

### Q2: 中文显示乱码
**解决**: 
1. 确保数据库字符集为 ZHS16GBK
2. 设置环境变量：`set NLS_LANG=SIMPLIFIED CHINESE_CHINA.UTF8`
3. SQL 文件使用 UTF-8 编码保存

### Q3: 序列已存在错误
**解决**: 执行建表脚本前，先删除已有序列：
```sql
BEGIN
  FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
  END LOOP;
END;
/
```

---

## 📞 技术支持

- **公司名称**: 长江数据
- **官网**: http://www.changjiangdata.com/web/
- **文档**: https://sscms.com/docs/v7/model/

---

## 📄 许可证

Copyright © 2026 长江数据

---

**最后更新**: 2026-03-23  
**版本**: v1.0
