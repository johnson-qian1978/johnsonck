# CJCMS 文档索引

## 📚 文档列表

### 核心文档（2026-03-23 更新）

| 序号 | 文档名称 | 文件路径 | 说明 | 更新时间 |
|------|---------|---------|------|---------|
| 1 | **项目说明** | [README.md](./README.md) | CJCMS 项目简介、快速开始指南 | 2026-03-23 |
| 2 | **数据库设计** | [database-design.md](./database-design.md) | 14 个核心表的详细设计文档 | 2026-03-23 |
| 3 | **快速参考** | [quick-reference.md](./quick-reference.md) | 常用 SQL、状态码、数据插入示例 | 2026-03-23 |

### 历史文档（待更新）

| 序号 | 文档名称 | 说明 | 创建时间 |
|------|---------|------|---------|
| 4 | 00-文档目录说明.md | 文档结构说明 | 2026-03-20 |
| 5 | 01-系统概述.md | 系统功能介绍 | 2026-03-20 |
| 6 | 02-数据库设计说明.md | 原数据库设计（旧版） | 2026-03-20 |
| 7 | 03-系统架构说明.md | 系统架构设计 | 2026-03-20 |
| 8 | 04-系统详细设计.md | 详细设计文档 | 2026-03-20 |

---

## 🎯 推荐阅读顺序

### 新手入门
1. 📘 **[README.md](./README.md)** - 了解项目概况和快速开始
2. 📗 **[quick-reference.md](./quick-reference.md)** - 快速上手常用操作
3. 📕 **[database-design.md](./database-design.md)** - 深入了解数据库设计

### 开发人员
1. 📕 **[database-design.md](./database-design.md)** - 表结构详细设计
2. 📗 **[quick-reference.md](./quick-reference.md)** - 常用 SQL 参考
3. 📘 **[README.md](./README.md)** - 项目结构和开发规范

### 运维人员
1. 📘 **[README.md](./README.md)** - 部署指南
2. 📗 **[quick-reference.md](./quick-reference.md)** - 数据库维护 SQL
3. 📕 **[database-design.md](./database-design.md)** - 表结构说明

---

## 📊 当前系统状态

### 数据库版本
- **版本**: v1.0
- **表数量**: 14 个核心表
- **字符集**: ZHS16GBK
- **命名规范**: ss_前缀

### 已创建的表
1. ss_AccessToken - API 密钥表
2. ss_Administrator - 管理员表
3. ss_AdminRole - 管理员角色关系表
4. ss_Channel - 栏目表
5. ss_ChannelGroup - 栏目组表
6. ss_Config - 系统配置表
7. ss_Content - 内容表
8. ss_ContentCheck - 内容审核表
9. ss_ErrorLog - 错误日志表
10. ss_Log - 管理员操作日志表
11. ss_Role - 角色表
12. ss_Site - 站点表
13. ss_Template - 模板表
14. ss_User - 用户表

---

## 🔗 相关链接

- **公司官网**: http://www.changjiangdata.com/web/
- **SSCMS 官方文档**: https://sscms.com/docs/v7/model/
- **Oracle 官方文档**: https://docs.oracle.com/en/database/

---

## 📝 文档更新记录

### 2026-03-23
- ✅ 创建 README.md - 项目说明和快速开始指南
- ✅ 创建 database-design.md - 14 个核心表的详细设计
- ✅ 创建 quick-reference.md - 快速参考手册
- ✅ 创建 INDEX.md - 本文档索引

### 2026-03-20
- 创建初始文档（00-04 系列）

---

## 💡 使用建议

1. **首次使用**: 从 [README.md](./README.md) 开始，了解项目概况
2. **日常开发**: 查阅 [quick-reference.md](./quick-reference.md) 获取常用 SQL
3. **深入学习**: 阅读 [database-design.md](./database-design.md) 了解表结构
4. **遇到问题**: 先查看文档，再检查数据库表结构

---

**文档维护**: CJCMS 开发团队  
**最后更新**: 2026-03-23  
**文档版本**: v1.0
