# MemOS 记忆访问机制与强制检索配置

## 记忆存储位置

| 类型 | 路径 | 说明 |
|------|------|------|
| SQLite 数据库 | `~/.openclaw/memos-local/memos.db` | 完整对话历史，自动存储 |
| 精选记忆文件 | `MEMORY.md` | 手动维护的关键信息摘要 |
| 时间切片记忆 | `memory/YYYY-MM-DD.md` | 按日归档的记忆片段 |
| Web 界面 | http://127.0.0.1:18799/ | 需密码 `6a58b0d29adb75e607ca9246274c1403` |

## 为什么 AI 会“失忆”？

- **默认行为**：新会话启动时，AI **不会自动加载** `memos.db` 中的历史
- **仅读取** `MEMORY.md`（需手动更新）
- 若未主动执行 `memory_search`，则无法访问数据库中的完整记忆

## 强制记忆检索配置

### 1. AGENTS.md 启动流程增强
在 **Session Startup** 章节添加：
```markdown
3. 🔥 强制记忆搜索 (MANDATORY) — Execute memory_search with key terms from USER.md
```

并附加红线规则：
> ⚠️ 禁止在未执行 `memory_search` 的情况下回复“我没有相关信息”、“我不知道你之前的对话”等表述。

### 2. HEARTBEAT.md 定时检索

在心跳任务中加入：
```markdown
- [ ] 检查是否需执行周期性记忆搜索（距上次 >8 小时？）
```

并在 `AGENTS.md` 的 **Heartbeats** 章节定义：
```markdown
## Periodic Memory Search
- 每8小时至少执行一次 memory_search
- 搜索关键词：{{USER_NAME}}, {{PROJECT_NAME}}, critical decisions
- 状态跟踪：读取/更新 `heartbeat-state.json` 中的 `last_memory_search` 字段
```

## 记忆检索工具调用

AI 应通过内置 `memory_search` 工具查询，而非直接读取文件。该工具会：
- 自动连接 `memos.db`
- 支持关键词模糊匹配
- 返回结构化记忆片段

---

> 配置后，每次会话启动和定时心跳将自动触发记忆检索，彻底避免“一张白纸”问题。