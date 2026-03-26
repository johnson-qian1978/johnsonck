# SSCMS 数据库设计说明文档

## 📊 数据库概述

**数据库类型**: Oracle 11g  
**字符集**: ZHS16GBK (支持中文)  
**表命名规范**: `ss_` 前缀（简化版 SSCMS）  
**总计表数**: 14 个核心表

---

## 📋 表结构详细设计

### 1. ss_AccessToken - API 密钥表

**用途**: 存储访问 REST API 的密钥

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| ACCESS_TOKEN | NVARCHAR2(255) | NOT NULL | 访问令牌 |
| EXPIRES_AT | TIMESTAMP | | 过期时间 |
| CLIENT_ID | NVARCHAR2(255) | | 客户端 ID |
| SCOPE | NVARCHAR2(500) | | 权限范围 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 2. ss_Administrator - 管理员表

**用途**: 存储管理员信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| USER_NAME | NVARCHAR2(50) | NOT NULL, UNIQUE | 用户名 |
| PASSWORD_HASH | NVARCHAR2(100) | NOT NULL | 密码哈希 |
| REAL_NAME | NVARCHAR2(50) | | 真实姓名 |
| EMAIL | NVARCHAR2(100) | | 邮箱 |
| PHONE | NVARCHAR2(20) | | 手机号 |
| ROLE_ID | NUMBER(19) | | 角色 ID |
| STATUS | NUMBER(1) | DEFAULT 1 | 状态：0-禁用，1-启用 |
| LAST_LOGIN_TIME | TIMESTAMP | | 最后登录时间 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 3. ss_AdminRole - 管理员角色关系表

**用途**: 存储管理员与角色的关系

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| ADMIN_ID | NUMBER(19) | NOT NULL | 管理员 ID |
| ROLE_ID | NUMBER(19) | NOT NULL | 角色 ID |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 4. ss_Channel - 栏目表

**用途**: 存储站点下的栏目信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| CHANNEL_ID | NUMBER(19) | PRIMARY KEY | 栏目 ID |
| SITE_ID | NUMBER(19) | NOT NULL | 站点 ID |
| PARENT_ID | NUMBER(19) | DEFAULT 0 | 父栏目 ID |
| CHANNEL_NAME | NVARCHAR2(100) | NOT NULL | 栏目名称 |
| CHANNEL_INDEX | NVARCHAR2(50) | | 栏目索引 |
| CONTENT_MODEL_ID | NUMBER(19) | | 内容模型 ID |
| SORT_ORDER | NUMBER(10) | DEFAULT 0 | 排序号 |
| STATUS | NUMBER(1) | DEFAULT 1 | 状态：0-禁用，1-启用 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 5. ss_ChannelGroup - 栏目组表

**用途**: 存储栏目组信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| GROUP_ID | NUMBER(19) | PRIMARY KEY | 栏目组 ID |
| SITE_ID | NUMBER(19) | NOT NULL | 站点 ID |
| GROUP_NAME | NVARCHAR2(100) | NOT NULL | 栏目组名称 |
| SORT_ORDER | NUMBER(10) | DEFAULT 0 | 排序号 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 6. ss_Config - 系统配置表

**用途**: 存储系统配置信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| CONFIG_KEY | NVARCHAR2(100) | NOT NULL, UNIQUE | 配置键 |
| CONFIG_VALUE | NCLOB | | 配置值 |
| DESCRIPTION | NVARCHAR2(500) | | 描述 |
| UPDATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

---

### 7. ss_Content - 内容表

**用途**: 存储站点内容数据

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| CONTENT_ID | NUMBER(19) | PRIMARY KEY | 内容 ID |
| SITE_ID | NUMBER(19) | NOT NULL | 站点 ID |
| CHANNEL_ID | NUMBER(19) | NOT NULL | 栏目 ID |
| TITLE | NVARCHAR2(200) | NOT NULL | 内容标题 |
| SUMMARY | NVARCHAR2(1000) | | 内容摘要 |
| CONTENT | NCLOB | | 内容正文 |
| AUTHOR | NVARCHAR2(50) | | 作者 |
| SOURCE | NVARCHAR2(100) | | 来源 |
| IMAGE_URL | NVARCHAR2(500) | | 图片 URL |
| VIEW_COUNT | NUMBER(10) | DEFAULT 0 | 浏览次数 |
| STATUS | NUMBER(1) | DEFAULT 0 | 状态：0-草稿，1-已发布 |
| PUBLISH_TIME | TIMESTAMP | | 发布时间 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| UPDATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

---

### 8. ss_ContentCheck - 内容审核表

**用途**: 存储内容审核信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| CONTENT_ID | NUMBER(19) | NOT NULL | 内容 ID |
| CHECK_STATUS | NUMBER(1) | DEFAULT 0 | 审核状态：0-待审核，1-通过，2-拒绝 |
| CHECK_USER_ID | NUMBER(19) | | 审核人 ID |
| CHECK_TIME | TIMESTAMP | | 审核时间 |
| CHECK_OPINION | NVARCHAR2(500) | | 审核意见 |

---

### 9. ss_ErrorLog - 错误日志表

**用途**: 存储所有报错信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| ERROR_TYPE | NVARCHAR2(100) | | 错误类型 |
| ERROR_MESSAGE | NCLOB | | 错误消息 |
| ERROR_STACK | NCLOB | | 错误堆栈 |
| ERROR_URL | NVARCHAR2(500) | | 错误 URL |
| ERROR_IP | NVARCHAR2(50) | | 错误 IP |
| ERROR_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 错误时间 |

---

### 10. ss_Log - 管理员操作日志表

**用途**: 存储管理员所执行的动作日志

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| ADMIN_ID | NUMBER(19) | | 管理员 ID |
| ACTION_TYPE | NVARCHAR2(100) | | 操作类型 |
| ACTION_DESCRIPTION | NVARCHAR2(500) | | 操作描述 |
| ACTION_IP | NVARCHAR2(50) | | 操作 IP |
| ACTION_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 操作时间 |

---

### 11. ss_Role - 角色表

**用途**: 存储管理员角色信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ROLE_ID | NUMBER(19) | PRIMARY KEY | 角色 ID |
| ROLE_NAME | NVARCHAR2(50) | NOT NULL | 角色名称 |
| ROLE_CODE | NVARCHAR2(50) | UNIQUE | 角色编码 |
| DESCRIPTION | NVARCHAR2(200) | | 角色描述 |
| STATUS | NUMBER(1) | DEFAULT 1 | 状态：0-禁用，1-启用 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 12. ss_Site - 站点表

**用途**: 存储站点信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| SITE_ID | NUMBER(19) | PRIMARY KEY | 站点 ID |
| SITE_NAME | NVARCHAR2(100) | NOT NULL | 站点名称 |
| SITE_DOMAIN | NVARCHAR2(200) | | 站点域名 |
| SITE_ROOT | NVARCHAR2(200) | | 站点根目录 |
| SITE_TEMPLATE | NVARCHAR2(100) | | 站点模板 |
| STATUS | NUMBER(1) | DEFAULT 1 | 状态：0-禁用，1-启用 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

### 13. ss_Template - 模板表

**用途**: 存储站点的模板信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| ID | NUMBER(19) | PRIMARY KEY | 主键 ID |
| SITE_ID | NUMBER(19) | NOT NULL | 站点 ID |
| TEMPLATE_NAME | NVARCHAR2(100) | | 模板名称 |
| TEMPLATE_FILE | NVARCHAR2(200) | | 模板文件 |
| TEMPLATE_CONTENT | NCLOB | | 模板内容 |
| DESCRIPTION | NVARCHAR2(500) | | 描述 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| UPDATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

---

### 14. ss_User - 用户表

**用途**: 存储用户信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|---------|------|------|
| USER_ID | NUMBER(19) | PRIMARY KEY | 用户 ID |
| USER_NAME | NVARCHAR2(50) | NOT NULL, UNIQUE | 用户名 |
| PASSWORD_HASH | NVARCHAR2(100) | NOT NULL | 密码哈希 |
| REAL_NAME | NVARCHAR2(50) | | 真实姓名 |
| EMAIL | NVARCHAR2(100) | | 邮箱 |
| PHONE | NVARCHAR2(20) | | 手机号 |
| GROUP_ID | NUMBER(19) | | 用户组 ID |
| STATUS | NUMBER(1) | DEFAULT 1 | 状态：0-禁用，1-启用 |
| CREATE_TIME | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

---

## 🔗 表关系图

```
ss_Site (站点表)
  ├─ ss_Channel (栏目表)
  │   └─ ss_Content (内容表)
  ├─ ss_User (用户表)
  ├─ ss_Template (模板表)
  └─ ss_Config (系统配置表)

ss_Role (角色表)
  ├─ ss_Administrator (管理员表)
  └─ ss_AdminRole (管理员角色关系表)

ss_Content (内容表)
  └─ ss_ContentCheck (内容审核表)

ss_Administrator (管理员表)
  └─ ss_Log (操作日志表)
  
ss_ErrorLog (错误日志表) [独立]
ss_AccessToken (API 密钥表) [独立]
ss_ChannelGroup (栏目组表) [独立]
```

---

## 📝 设计说明

### 命名规范
- **表名**: `ss_` 前缀 + 驼峰命名（如 `ss_AccessToken`）
- **主键**: 统一使用 `ID` 或 `{表名}_ID`（NUMBER(19)）
- **外键**: `{关联表}_ID`（NUMBER(19)）
- **状态字段**: `STATUS`（NUMBER(1)，0-禁用，1-启用）
- **时间字段**: `CREATE_TIME`、`UPDATE_TIME`（TIMESTAMP）

### 数据类型选择
- **主键/外键**: NUMBER(19) - 支持大整数
- **短文本**: NVARCHAR2(50-200) - 支持 Unicode
- **长文本**: NCLOB - 支持大段中文内容
- **时间戳**: TIMESTAMP - 精确到毫秒

### 中文支持
- 所有 NVARCHAR2 字段都支持中文
- 数据库字符集：ZHS16GBK
- 所有表和字段都有完整的中文注释

---

## ✅ 验证 SQL

```sql
-- 查看所有表
SELECT TABLE_NAME, COMMENTS 
FROM USER_TAB_COMMENTS 
WHERE TABLE_NAME LIKE 'SS_%' 
ORDER BY TABLE_NAME;

-- 查看某个表的字段注释
SELECT COLUMN_NAME, COMMENTS 
FROM USER_COL_COMMENTS 
WHERE TABLE_NAME = 'SS_ADMINISTRATOR' 
ORDER BY COLUMN_ID;

-- 统计表数量
SELECT COUNT(*) AS TOTAL_TABLES 
FROM USER_TABLES 
WHERE TABLE_NAME LIKE 'SS_%';
```

---

**文档更新时间**: 2026-03-23  
**数据库版本**: v1.0 (14 个核心表)
