# DeerFlow Thread 丢失恢复指南

## 问题现象
- 用户操作时出现 HTTP 404 错误
- 提示 “Thread not found” 或会话中断
- 容器重启或前端缓存清理后旧对话无法继续

## 根本原因
DeerFlow 使用 SQLite 数据库存储会话状态（checkpoint），路径通常为：
```
/app/backend/.deer-flow/checkpoints.db
```
当系统重启、容器重建或前端缓存失效时，旧 Thread ID 失效，导致 404。

## 恢复步骤

### 1. 确认 checkpoint 数据库存在
```bash
ls /app/backend/.deer-flow/checkpoints.db
```

### 2. 强制刷新前端页面
- 清除浏览器缓存
- 重新打开对话界面

### 3. 系统自动创建新 Thread
- DeerFlow 在检测到无效 Thread ID 时会自动生成新会话
- 无需手动干预，但历史上下文将丢失

## 预防措施
- 避免频繁重启 Gateway 服务
- 在生产环境中启用持久化存储卷（Persistent Volume）挂载 `.deer-flow` 目录
- 不依赖 HTTP 调用 OpenClaw 工具（仅支持 WebSocket 会话通信）