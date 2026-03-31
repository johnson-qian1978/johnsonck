# HEARTBEAT.md

# Keep this file empty (or with only comments) to skip heartbeat API calls.

# Add tasks below when you want the agent to check something periodically.

## 🔥 心跳任务清单

每次心跳时检查：

1. **记忆搜索** — 如果距离上次搜索超过 8 小时，执行 `memory_search` 搜索用户名、当前项目等关键词，恢复上下文记忆
2. **检查 heartbeat-state.json** — 确认各项检查的时间戳

如果所有检查都正常且无需提醒，回复 `HEARTBEAT_OK`
