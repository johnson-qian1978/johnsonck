# CJCMS 快速参考手册

## 📋 数据库表速查

### 核心业务表

| 表名 | 用途 | 关键字段 |
|------|------|---------|
| **ss_Site** | 站点管理 | SITE_ID, SITE_NAME, SITE_DOMAIN |
| **ss_Channel** | 栏目管理 | CHANNEL_ID, CHANNEL_NAME, PARENT_ID |
| **ss_Content** | 内容管理 | CONTENT_ID, TITLE, CONTENT, STATUS |
| **ss_Template** | 模板管理 | TEMPLATE_NAME, TEMPLATE_CONTENT |

### 用户权限表

| 表名 | 用途 | 关键字段 |
|------|------|---------|
| **ss_Administrator** | 管理员 | USER_NAME, PASSWORD_HASH, ROLE_ID |
| **ss_Role** | 角色 | ROLE_NAME, ROLE_CODE |
| **ss_AdminRole** | 管理员 - 角色关联 | ADMIN_ID, ROLE_ID |
| **ss_User** | 普通用户 | USER_NAME, GROUP_ID, STATUS |

### 系统管理表

| 表名 | 用途 | 关键字段 |
|------|------|---------|
| **ss_Config** | 系统配置 | CONFIG_KEY, CONFIG_VALUE |
| **ss_AccessToken** | API 密钥 | ACCESS_TOKEN, EXPIRES_AT |
| **ss_Log** | 操作日志 | ACTION_TYPE, ACTION_DESCRIPTION |
| **ss_ErrorLog** | 错误日志 | ERROR_TYPE, ERROR_MESSAGE |

---

## 🔍 常用 SQL 查询

### 查看所有表
```sql
SELECT TABLE_NAME, COMMENTS 
FROM USER_TAB_COMMENTS 
WHERE TABLE_NAME LIKE 'SS_%' 
ORDER BY TABLE_NAME;
```

### 查看表的字段
```sql
SELECT COLUMN_NAME, DATA_TYPE, COMMENTS 
FROM USER_COL_COMMENTS uc
JOIN USER_TAB_COLUMNS ut ON uc.TABLE_NAME = ut.TABLE_NAME AND uc.COLUMN_NAME = ut.COLUMN_NAME
WHERE uc.TABLE_NAME = 'SS_ADMINISTRATOR'
ORDER BY ut.COLUMN_ID;
```

### 查看管理员及其角色
```sql
SELECT a.USER_NAME, a.REAL_NAME, r.ROLE_NAME, r.ROLE_CODE
FROM ss_Administrator a
LEFT JOIN ss_Role r ON a.ROLE_ID = r.ROLE_ID;
```

### 查看站点及栏目
```sql
SELECT s.SITE_NAME, c.CHANNEL_NAME, c.PARENT_ID
FROM ss_Site s
LEFT JOIN ss_Channel c ON s.SITE_ID = c.SITE_ID
ORDER BY s.SITE_NAME, c.SORT_ORDER;
```

### 查看已发布内容
```sql
SELECT TITLE, AUTHOR, STATUS, PUBLISH_TIME
FROM ss_Content
WHERE STATUS = 1
ORDER BY PUBLISH_TIME DESC;
```

---

## 🔐 状态码说明

### STATUS 字段值
- **0** = 草稿/禁用
- **1** = 已发布/启用

### CHECK_STATUS 字段值（内容审核）
- **0** = 待审核
- **1** = 已通过
- **2** = 已拒绝

---

## 📝 数据插入示例

### 创建新站点
```sql
INSERT INTO ss_Site (SITE_ID, SITE_NAME, SITE_DOMAIN, STATUS)
VALUES (siteserver_Site_SEQ.NEXTVAL, '示例站点', 'www.example.com', 1);
```

### 创建管理员
```sql
INSERT INTO ss_Administrator (ID, USER_NAME, PASSWORD_HASH, REAL_NAME, EMAIL, ROLE_ID, STATUS)
VALUES (siteserver_Administrator_SEQ.NEXTVAL, 'zhangsan', 'password123', '张三', 'zhangsan@example.com', 1, 1);
```

### 发布内容
```sql
INSERT INTO ss_Content (CONTENT_ID, SITE_ID, CHANNEL_ID, TITLE, CONTENT, AUTHOR, STATUS, PUBLISH_TIME)
VALUES (model_Content_SEQ.NEXTVAL, 1, 1, '标题', '内容...', '作者', 1, SYSDATE);
```

---

## ⚠️ 注意事项

1. **所有表都使用 NVARCHAR2 支持中文**
2. **主键统一使用 NUMBER(19)**
3. **时间字段使用 TIMESTAMP**
4. **长文本使用 NCLOB**
5. **删除表时使用 CASCADE CONSTRAINTS**

---

**最后更新**: 2026-03-23
