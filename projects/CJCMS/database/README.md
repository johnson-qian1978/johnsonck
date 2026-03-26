# CJCMS 数据库文件（清理后）

## 📁 保留的文件

| 文件名 | 大小 | 用途 | 状态 |
|--------|------|------|------|
| `schema_nvarchar2.sql` | 13KB | **建表脚本**（所有中文字段使用 NVARCHAR2） | ✅ 推荐使用 |
| `insert_data_nvarchar2.sql` | 4KB | **测试数据插入脚本**（包含完整中文数据） | ✅ 推荐使用 |
| `report.sql` | 2.5KB | 数据验证报告（在 PL/SQL Developer 中查看） | ✅ 可用 |
| `verify_data.sql` | 2KB | 数据验证脚本 | ✅ 可用 |
| `README.md` | 5KB | 本说明文档 | 📖 |
| `README_COMPLETE.md` | 5KB | 完整的数据库初始化报告 | 📖 |

## 🚀 快速开始

### 方法 1: 手动执行（推荐）

在 **PL/SQL Developer** 中依次执行：

1. **建表**: 
   - File → Open → `schema_nvarchar2.sql`
   - 按 **F8** 执行

2. **插入数据**:
   - File → Open → `insert_data_nvarchar2.sql`
   - 按 **F8** 执行

3. **验证**:
   - File → Open → `report.sql`
   - 按 **F8** 执行

### 方法 2: 命令行执行

```bash
cd E:\CJCMS\database
sqlplus CJCMS/1@localhost:1521/ORCL @schema_nvarchar2.sql
sqlplus CJCMS/1@localhost:1521/ORCL @insert_data_nvarchar2.sql
sqlplus CJCMS/1@localhost:1521/ORCL @report.sql
```

## 🔑 默认账号

### 后台管理员
```
用户名：admin
密码：admin123
角色：超级管理员
```

### 前台用户
```
用户名：testuser
密码：123456
用户组：普通会员
```

## 📊 数据库结构

### 已创建的表（19 张）

#### 系统核心表（5 张）
- CJ_SYS_SITE - 站点表
- CJ_SYS_MENU - 菜单表
- CJ_SYS_CONFIG - 系统配置表
- CJ_SYS_OPERATION_LOG - 操作日志表
- CJ_SYS_ERROR_LOG - 错误日志表

#### 管理员与权限表（6 张）
- CJ_ADM_ADMINISTRATOR - 管理员表
- CJ_ADM_ROLE - 角色表
- CJ_ADM_ADMIN_ROLE - 管理员角色关联表
- CJ_ADM_ROLE_MENU - 角色菜单权限表
- CJ_ADM_DATA_PERMISSION - 数据权限表
- CJ_ADM_LOGIN_LOG - 登录日志表

#### 内容管理表（5 张）
- CJ_CMS_CHANNEL - 栏目表
- CJ_CMS_MODEL - 内容模型表
- CJ_CMS_MODEL_FIELD - 模型字段表
- CJ_CMS_CONTENT - 内容表
- CJ_CMS_TEMPLATE - 模板表

#### 用户管理表（3 张）
- CJ_USER_USER - 前台用户表
- CJ_USER_GROUP - 用户组表
- CJ_USER_SUBMISSION - 用户投稿表

## 🎯 技术特点

### NVARCHAR2 优势
- ✅ **生僻字完全支持**：内部使用 UTF-16 编码
- ✅ **多语言兼容**：支持中文、英文、日文等
- ✅ **Oracle 官方推荐**：国际化应用最佳实践
- ✅ **开发透明**：Java/MyBatis 自动处理

### 字段类型说明
- **NVARCHAR2(n)**: 存储 Unicode 字符（所有中文字段）
- **NCLOB**: 存储大文本 Unicode 数据
- **VARCHAR2(n)**: 存储 ASCII 字符（ID、CODE 等）

## ⚠️ PL/SQL Developer 设置

如果看到乱码，请检查：

1. **Tools → Preferences → Oracle → Connection**
   - 取消勾选 "Auto-detect code page"
   - 设置 NLS_LANG: `SIMPLIFIED CHINESE_CHINA.GBK`

2. **重启 PL/SQL Developer**

## 📝 验证数据

执行 `report.sql` 后，应该看到：

```
管理员信息
用户名          真实姓名              部门
--------------- -------------------- --------------------
admin           超级管理员            技术部

角色信息
角色名称              角色代码
-------------------- --------------------
超级管理员            super_admin
站点管理员            site_admin
内容编辑              content_editor

站点信息
站点名称              描述
-------------------- --------------------
长江 CMS 主站         长江 CMS 官方主站

栏目信息
栏目名称
--------------------
根栏目
公司新闻
产品展示

内容信息
标题                  作者
-------------------- --------------------
长江 CMS 系统正式发布   管理员
```

## 🗑️ 已删除的文件

以下旧文件已删除：
- ❌ 所有旧的建表脚本（create_tables_*.sql）
- ❌ 所有旧的插入脚本（insert_*.sql，除了最新的 nvarchar2 版本）
- ❌ 临时验证脚本（check_*.sql, verify.sql 等）
- ❌ 批处理文件（init.bat, run_setup.bat）
- ❌ PowerShell 脚本（init-database.ps1）
- ❌ 其他临时文件

## 📞 问题排查

### 问题 1: 表不存在
**解决**: 先执行 `schema_nvarchar2.sql` 创建表

### 问题 2: 中文显示乱码
**解决**: 检查 PL/SQL Developer 的 NLS_LANG 设置

### 问题 3: ORA-00001 唯一约束冲突
**解决**: 先删除旧数据或重建表

### 问题 4: ORA-02291 外键约束失败
**解决**: 确保按顺序插入（先父表后子表）

## 📚 相关文档

- **完整报告**: `README_COMPLETE.md`
- **技能文档**: `E:\CJCMS\skills\self-healing-coder\SUMMARY.md`

---

**最后更新**: 2026-03-24  
**清理完成**: ✅ 只保留最新可用文件  
**数据库状态**: ✅ 已初始化，包含测试数据  
**字符集方案**: ✅ NVARCHAR2 (UTF-16)
