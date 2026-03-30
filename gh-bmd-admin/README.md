# GH_BMD 管理系统

仿照武汉医疗互助界面风格的 BMD 表增删改查 Web 应用。

## 功能特点

- ✅ 左侧导航菜单
- ✅ 搜索过滤（按名称、类型）
- ✅ 数据表格展示
- ✅ 新增、编辑、删除功能
- ✅ 分页显示
- ✅ 响应式设计

## 快速开始

### 1. 安装依赖

```bash
cd gh-bmd-admin
npm install
```

### 2. 启动服务

```bash
npm start
```

### 3. 访问应用

打开浏览器访问：http://localhost:3000

## 技术栈

- **前端**: Vue 3 + Element Plus
- **后端**: Node.js + Express
- **数据库**: Oracle (oracledb)

## 接口说明

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/bmd | 获取所有 BMD 数据 |
| POST | /api/bmd | 新增 BMD |
| PUT | /api/bmd/:id | 更新 BMD |
| DELETE | /api/bmd/:id | 删除 BMD |

## 注意事项

- 确保 Oracle 数据库已启动且可访问
- 数据库连接配置在 `server.js` 中
- 默认端口：3000
