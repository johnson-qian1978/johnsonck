---
name: "deerflow-openclaw-integration-and-memory-optimization"
description: "如何可靠集成 DeerFlow 2.0 与 OpenClaw，并优化本地记忆机制以避免 AI 助手“失忆”。使用此技能当你需要：强制会话启动时自动搜索记忆、配置定时心跳触发记忆检索、安装并配置百度/Tavily 搜索技能、验证网络流传的 DeerFlow+OpenClaw 集成方案真实性（如 deerflow2-bridge 插件或 system.executor.* 配置）、通过 MCP 协议实现双向调用。即使用户只说“你昨天怎么又装失忆了”或“确保记住我的设置”，也应触发本技能。"
metadata: { "openclaw": { "emoji": "🦞" } }
---

# DeerFlow 与 OpenClaw 集成及记忆机制强化指南

本技能帮助你建立 DeerFlow 2.0 与 OpenClaw 的真实可行集成方案，并通过强制记忆搜索机制杜绝 AI “一张白纸”式回答。

## 何时使用此技能
- 当你需要确保每次新会话开始时，AI 主动搜索本地记忆（而非声称“不知道之前对话”）
- 当你想配置定时任务（如每8小时）自动检索近期项目、用户名等关键记忆
- 当你看到网上教程提到 `deerflow2-bridge` 插件、`system.executor.engine` 等配置，需验证其真实性
- 当你需要安装并配置外部搜索能力（如百度搜索、Tavily）以辅助信息验证
- 当你计划通过 MCP 协议让 DeerFlow 调用 OpenClaw 的通道能力（如 WhatsApp、iMessage）

## 步骤

### 1. 强化 AGENTS.md 启动流程：强制记忆搜索
在 `AGENTS.md` 的 **Session Startup** 部分新增第3步：
```markdown
3. 🔥 强制记忆搜索 (MANDATORY) — Execute memory_search with key terms from USER.md
```
并在下方添加红线规则：
> 禁止在未执行 `memory_search` 的情况下回复“我没有相关信息”、“我不知道你之前的对话”或类似表述。

**为什么重要**：默认情况下，AI 不会自动加载 `memos.db` 中的完整对话历史，仅依赖手动维护的 `MEMORY.md`。强制搜索确保能访问所有已存记忆。

### 2. 配置 HEARTBEAT.md 定时记忆检索
在 `AGENTS.md` 的 **Heartbeats** 章节新增 **Periodic Memory Search** 规则：
- 每8小时至少执行一次 `memory_search`
- 搜索关键词包括：用户名、当前项目名、关键决策术语
- 使用 `heartbeat-state.json` 记录上次搜索时间戳，避免重复

同时在 `HEARTBEAT.md` 任务清单中加入检查项：
```markdown
- [ ] 检查是否需执行周期性记忆搜索（距上次 >8 小时？）
```

**为什么重要**：防止长时间运行后因上下文丢失而“遗忘”重要背景，尤其适用于跨天任务。

### 3. 安装并配置搜索技能
执行以下命令安装两个核心搜索技能：
```bash
npx clawhub install openclaw-tavily-search
npx clawhub install baidu-search
```

配置 API 密钥（任选一种方式）：
```env
# 方式一：写入 ~/.openclaw/.env
BAIDU_API_KEY=你的百度API密钥
TAVILY_API_KEY=你的TavilyAPI密钥

# 方式二：临时环境变量（Windows CMD）
set BAIDU_API_KEY=...
set TAVILY_API_KEY=...
```

**为什么重要**：所有外部搜索（百度、Tavily、Brave）均需有效 API 密钥，不存在“免密内置搜索”。安装后可通过脚本调用，用于验证网络信息真伪。

### 4. 验证集成方案真实性（关键步骤）
对任何声称的“一键集成”方案，必须执行以下验证命令：

```bash
# 检查插件是否存在
openclaw plugins list  # 若输出不含 deerflow2-bridge，则该插件不存在

# 检查配置项是否有效
openclaw config get system.executor.engine  # 若返回空或报错，说明该配置路径无效
openclaw config get gateway.mcp.enabled     # 验证 MCP 开关是否存在
```

**为什么重要**：多篇网络文章（包括阿里云、知乎）虚构了 `deerflow2-bridge` 插件和 `system.executor.*` 配置，属典型 AI 幻觉。必须通过实际命令验证。

### 5. 实施真实 MCP 集成方案
若需 DeerFlow 调用 OpenClaw 的 IM 通道（如 WhatsApp），采用 **MCP 协议**：

**OpenClaw 侧（作为 MCP Server）**：
```bash
openclaw mcp serve --url ws://127.0.0.1:18789
```

**DeerFlow 侧（作为 MCP Client）**，编辑 `extensions_config.json`：
```json
{
  "mcpServers": {
    "openclaw": {
      "enabled": true,
      "type": "sse",
      "url": "http://127.0.0.1:18789/mcp"
    }
  }
}
```

**为什么重要**：这是目前唯一经验证可行的双向协作方式。DeerFlow 可直接调用 OpenClaw 提供的工具链，无需虚构插件。

### 6. 保存验证结果到本地记忆
将对比结论（如“阿里云文章架构理念正确但命令虚构”）写入当日记忆文件：
```markdown
<!-- memory/2026-03-31.md -->
## DeerFlow + OpenClaw 集成真相
- ✅ 正确：OpenClaw 负责交互，DeerFlow 负责流程编排
- ❌ 虚构：`deerflow2-bridge` 插件、`system.executor.*` 配置
- ✅ 真实方案：通过 MCP 协议集成（openclaw mcp serve + DeerFlow extensions_config.json）
```

**为什么重要**：形成可追溯的本地知识库，避免未来重复验证。

## 常见陷阱与解决方案

❌ 盲信网络教程中的 `openclaw plugins install deerflow2-bridge`  
→ **为何失败**：npm 和 OpenClaw 插件仓库中均无此包，系 AI 幻觉产物  
→ ✅ **正确做法**：先用 `openclaw plugins list` 验证插件存在性，再执行安装

❌ 配置 `system.executor.engine deerflow2` 后重启无效果  
→ **为何失败**：OpenClaw 配置体系中不存在 `system.executor` 命名空间  
→ ✅ **正确做法**：放弃该路径，改用 MCP 协议实现引擎协作

❌ 安装搜索技能后仍无法使用百度搜索  
→ **为何失败**：技能目录为空或缺少 API 密钥（常见于同步中断）  
→ ✅ **正确做法**：重新安装技能（`npx clawhub install baidu-search`），并显式配置 `BAIDU_API_KEY`

❌ 心跳机制未触发记忆搜索  
→ **为何失败**：未在 `HEARTBEAT.md` 中加入检查逻辑，或状态文件缺失  
→ ✅ **正确做法**：确保 `heartbeat-state.json` 存在，并在心跳任务中主动比对时间戳

## 关键代码与配置

### AGENTS.md 强制记忆搜索片段
```markdown
3. 🔥 强制记忆搜索 (MANDATORY) — Execute memory_search with key terms from USER.md

> ⚠️ 红线规则：禁止在未搜索记忆的情况下说“我没有相关信息”、“我不知道你之前的对话”。
```

### HEARTBEAT.md 定时检查逻辑
```markdown
## Periodic Memory Search
- 每8小时执行一次 memory_search
- 搜索词：{{USER_NAME}}, {{PROJECT_NAME}}, critical decisions
- 状态跟踪：读取/更新 `heartbeat-state.json` 中的 `last_memory_search`
```

### DeerFlow MCP 客户端配置 (`extensions_config.json`)
```json
{
  "mcpServers": {
    "openclaw": {
      "enabled": true,
      "type": "sse",
      "url": "http://127.0.0.1:18789/mcp"
    }
  }
}
```

### OpenClaw MCP 服务启动命令
```bash
openclaw mcp serve --url ws://127.0.0.1:18789
```

## 环境与前提条件

- **OpenClaw 版本**：≥2026.3.22（支持 `mcp serve` 子命令）
- **DeerFlow 版本**：2.0+（支持 MCP 客户端配置）
- **操作系统**：Windows 10/11 或 Linux（路径示例基于 Windows）
- **依赖工具**：
  - Node.js ≥18.x（用于 `npx clawhub`）
  - Python 3.8+（部分搜索技能依赖）
- **权限要求**：
  - 对 `~/.openclaw/` 目录有读写权限
  - 可执行 `openclaw` CLI 命令
- **网络要求**：
  - 可访问 Tavily/Baidu API（需代理则配置环境变量）

## 配套文件

- `scripts/install-search-skills.ps1` — 自动安装百度和 Tavily 搜索技能的 PowerShell 脚本
- `references/deerflow-mcp-config-examples.json` — DeerFlow MCP 客户端配置模板集合
- `memory/2026-03-31.md` — DeerFlow+OpenClaw 集成方案验证结论存档

## Companion files

- `scripts/install_search_skills.sh` — automation script
- `scripts/verify_integration.sh` — automation script
- `scripts/start_openclaw_mcp_server.sh` — automation script
- `references/mcp-integration-config.md` — reference documentation
- `references/search-skills-installation.md` — reference documentation
- `references/memory-access-mechanisms.md` — reference documentation