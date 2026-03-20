# SSCMS v7 学习笔记与 CMS 设计方案

## 📚 第一部分：SSCMS 核心架构学习

### 1. 系统概述

**SSCMS (SiteServer CMS)** 是一个基于 .NET CORE 的跨平台内容管理系统，版本 7.x。

**核心特点：**
- 跨平台（.NET CORE）
- REST API 驱动
- 插件化架构
- 多站点支持
- 模板引擎（STL）

---

### 2. 数据库结构

SSCMS 的数据库表主要分为三大部分：

#### 2.1 系统数据表（siteserver_前缀）

| 表名 | 用途 | 重要性 |
|------|------|--------|
| `siteserver_Site` | 站点表 | ⭐⭐⭐ 核心 |
| `siteserver_Channel` | 栏目表 | ⭐⭐⭐ 核心 |
| `siteserver_ChannelGroup` | 栏目组表 | ⭐⭐ |
| `siteserver_Administrator` | 管理员表 | ⭐⭐⭐ 核心 |
| `siteserver_Role` | 角色表 | ⭐⭐ |
| `siteserver_PermissionsInRoles` | 权限角色表 | ⭐⭐ |
| `siteserver_User` | 用户表 | ⭐⭐⭐ 核心 |
| `siteserver_UserGroup` | 用户组表 | ⭐⭐ |
| `siteserver_Template` | 模板表 | ⭐⭐⭐ 核心 |
| `siteserver_Config` | 系统配置表 | ⭐⭐ |
| `siteserver_ContentTag` | 内容标签表 | ⭐⭐ |
| `siteserver_MaterialImage` | 素材图片表 | ⭐⭐ |
| `siteserver_MaterialFile` | 素材文件表 | ⭐⭐ |
| `siteserver_Log` | 管理员操作日志 | ⭐ |
| `siteserver_ErrorLog` | 错误日志 | ⭐ |

#### 2.2 内容表（model_前缀）

- **默认表名**: `model_Content`
- **特点**: 
  - 每个站点可以自定义内容表
  - 可以与其他站点共享内容表
  - 支持自定义字段（在后台配置）
  - 字段类型包括：文本、数字、日期、选择框、富文本等

#### 2.3 插件表

- 插件自定义表，通常以插件 ID 作为前缀
- 独立于核心系统表

---

### 3. 核心概念

#### 3.1 站点（Site）
- SSCMS 支持多站点
- 每个站点有独立的配置、栏目、内容、模板
- 站点之间可以共享内容表或独立内容表

#### 3.2 栏目（Channel）
- 树形结构组织内容
- 每个栏目属于一个站点
- 栏目可以有自己的内容模型
- 支持无限级父子栏目

#### 3.3 内容模型（Content Model）
- 定义内容的字段结构
- 类似数据库表结构的设计器
- 支持多种字段类型：
  - 文本（Text）
  - 富文本（Rich Text）
  - 数字（Number）
  - 日期（Date）
  - 选择框（Select）
  - 多选框（Checkbox）
  - 附件（Attachment）
  - 图片（Image）
  - 等等...

#### 3.4 模板（Template）
- 使用 STL（SiteServer Template Language）模板语言
- 模板存储在数据库中（siteserver_Template 表）
- 支持模板版本管理（siteserver_TemplateLog）

#### 3.5 管理员与权限
- 管理员表：`siteserver_Administrator`
- 角色表：`siteserver_Role`
- 管理员 - 角色关系：`siteserver_AdministratorsInRoles`
- 权限 - 角色关系：`siteserver_PermissionsInRoles`
- 站点级别权限控制

---

### 4. REST API

SSCMS 提供完整的 REST API，基于 HTTP/JSON。

#### 4.1 API 访问方式
```
GET http://<example.com>/api/v1/ping/
返回：pong
```

#### 4.2 核心 API 分类

| 分类 | 说明 | 关键 API |
|------|------|----------|
| **内容 API** | 增删改查内容 | `/api/v1/contents` |
| **栏目 API** | 管理栏目树 | `/api/v1/channels` |
| **站点 API** | 管理站点 | `/api/v1/sites` |
| **用户 API** | 用户管理 | `/api/v1/users` |
| **管理员 API** | 后台管理员 | `/api/v1/administrators` |
| **STL 模板 API** | 模板渲染 | `/api/v1/stl/*` |
| **表单 API** | 自定义表单 | `/api/v1/forms` |

#### 4.3 内容 API 示例
```http
# 获取内容列表
POST /api/v1/contents

# 获取单个内容
GET /api/v1/contents/{siteId}/{channelId}/{id}

# 新增内容
POST /api/v1/contents/{siteId}/{channelId}

# 修改内容
POST /api/v1/contents/{siteId}/{channelId}/{id}/actions/update

# 删除内容
POST /api/v1/contents/{siteId}/{channelId}/{id}/actions/delete
```

---

### 5. 插件开发

SSCMS 采用插件化架构，核心功能也是基于插件 API 构建的。

**插件能力：**
- 扩展后台界面
- 添加新的 API 端点
- 创建自定义数据表
- 钩子（Hooks）机制
- 事件订阅

---

## 💡 第二部分：我们的 CMS 设计方案

基于 SSCMS 的学习，我建议我们的 CMS 采用以下架构：

### 方案一：基于 SSCMS 二次开发（推荐）

**优点：**
1. ✅ 成熟稳定的核心架构
2. ✅ 完整的 REST API
3. ✅ 多站点支持
4. ✅ 完善的权限系统
5. ✅ 丰富的内容模型功能
6. ✅ 模板引擎现成

**开发重点：**
1. 定制前端界面（Vue 3 + Element Plus）
2. 开发特定业务插件
3. 定制内容模型
4. 集成现有系统（如武汉医疗互助）

**技术栈：**
- 后端：SSCMS (.NET CORE)
- 前端：Vue 3 + Element Plus
- 数据库：Oracle/SQL Server/MySQL
- API: RESTful JSON

---

### 方案二：参考 SSCMS 自主开发

**核心模块设计：**

#### 1. 数据库设计

```sql
-- 站点表
CREATE TABLE cms_Site (
    SiteID VARCHAR2(40) PRIMARY KEY,
    SiteName NVARCHAR2(100),
    Domain NVARCHAR2(200),
    Status NUMBER(1),
    CreateTime DATE
);

-- 栏目表（树形结构）
CREATE TABLE cms_Channel (
    ChannelID VARCHAR2(40) PRIMARY KEY,
    SiteID VARCHAR2(40),
    ParentID VARCHAR2(40),
    ChannelName NVARCHAR2(100),
    OrderNum NUMBER,
    Status NUMBER(1)
);

-- 内容模型表
CREATE TABLE cms_ContentModel (
    ModelID VARCHAR2(40) PRIMARY KEY,
    ModelName NVARCHAR2(100),
    TableName NVARCHAR2(50)
);

-- 内容模型字段表
CREATE TABLE cms_ModelField (
    FieldID VARCHAR2(40) PRIMARY KEY,
    ModelID VARCHAR2(40),
    FieldName NVARCHAR2(50),
    FieldType NVARCHAR2(20),
    IsRequired NUMBER(1),
    OrderNum NUMBER
);

-- 内容表（动态创建）
-- model_Content_{ModelID}

-- 管理员表
CREATE TABLE cms_Admin (
    AdminID VARCHAR2(40) PRIMARY KEY,
    Username NVARCHAR2(50),
    PasswordHash NVARCHAR2(100),
    RoleIDs NVARCHAR2(200)
);

-- 角色表
CREATE TABLE cms_Role (
    RoleID VARCHAR2(40) PRIMARY KEY,
    RoleName NVARCHAR2(50),
    Permissions CLOB
);
```

#### 2. 后端架构（Node.js + Express）

```
cms-backend/
├── routes/
│   ├── sites.js        # 站点管理
│   ├── channels.js     # 栏目管理
│   ├── contents.js     # 内容管理
│   ├── models.js       # 内容模型
│   ├── admins.js       # 管理员
│   └── api.js          # REST API
├── middleware/
│   ├── auth.js         # 认证中间件
│   └── permission.js   # 权限中间件
├── services/
│   ├── db.js           # 数据库服务
│   └── cache.js        # 缓存服务
└── server.js
```

#### 3. 前端架构（Vue 3 + Element Plus）

```
cms-admin/
├── views/
│   ├── dashboard/      # 仪表盘
│   ├── sites/          # 站点管理
│   ├── channels/       # 栏目管理
│   ├── contents/       # 内容管理
│   ├── models/         # 内容模型
│   └── system/         # 系统设置
├── components/
│   ├── ContentEditor/  # 内容编辑器
│   ├── ChannelTree/    # 栏目树组件
│   └── ModelDesigner/  # 模型设计器
└── api/
    ├── sites.js
    ├── channels.js
    └── contents.js
```

---

### 核心功能清单

#### 第一阶段（MVP）
- [ ] 站点管理（增删改查）
- [ ] 栏目管理（树形结构）
- [ ] 内容模型设计器
- [ ] 内容管理（CRUD）
- [ ] 管理员登录
- [ ] 基础权限控制

#### 第二阶段
- [ ] 角色权限管理
- [ ] 模板管理
- [ ] 素材库（图片、文件）
- [ ] 内容审核流程
- [ ] 操作日志

#### 第三阶段
- [ ] 多站点支持
- [ ] SEO 优化
- [ ] 静态页面生成
- [ ] 工作流引擎
- [ ] 插件系统

---

## 🤔 需要与您讨论的问题

### 1. 技术选型
- **选项 A**: 基于 SSCMS 二次开发（快速、稳定）
- **选项 B**: 参考 SSCMS 自主开发（灵活、可控）

**我的建议**: 如果时间紧、需求标准，选 A；如果需要高度定制、长期维护，选 B

### 2. 数据库选择
- Oracle（与现有系统一致）
- MySQL（轻量、开源）
- SQL Server（SSCMS 默认支持）

### 3. 部署方式
- 本地部署
- 云服务器
- 容器化（Docker）

### 4. 优先级
哪些功能是必须的？哪些可以后续迭代？

---

## 📝 下一步行动

1. **确认技术路线**（基于 SSCMS vs 自主开发）
2. **确定数据库和部署环境**
3. **梳理具体业务需求**
4. **制定开发计划和时间表**

---

**学习时间**: 2026-03-20  
**学习资料**: SSCMS v7 官方文档  
**状态**: 已完成初步学习，等待进一步指示
