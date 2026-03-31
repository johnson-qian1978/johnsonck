# OpenClaw 搜索技能安装与配置指南

## 可用搜索技能

OpenClaw 本身不内置免密搜索能力。所有外部搜索均需通过 ClawHub 安装技能并配置 API 密钥。

### 官方推荐技能
| 技能名称 | 安装命令 | 所需 API |
|--------|--------|--------|
| Tavily 搜索 | `npx clawhub install openclaw-tavily-search` | [Tavily API Key](https://tavily.com) |
| 百度搜索 | `npx clawhub install baidu-search` | 百度智能云 API Key |

> ⚠️ 注意：截至当前版本，**无“百度搜索”内置技能**，必须显式安装。技能目录为空或缺失 SKILL.md 表示未正确安装。

## 配置 API 密钥

### 方式一：全局环境文件（推荐）
创建或编辑 `~/.openclaw/.env`：
```env
TAVILY_API_KEY=your_tavily_key_here
BAIDU_API_KEY=your_baidu_key_here
```

### 方式二：临时环境变量（会话级）
```bash
# Windows CMD
set TAVILY_API_KEY=...
set BAIDU_API_KEY=...

# macOS/Linux
export TAVILY_API_KEY=...
export BAIDU_API_KEY=...
```

## 验证安装

1. 检查技能目录是否存在：
   ```bash
   ls ~/.agents/skills/openclaw-tavily-search/
   ```
2. 确认包含 `SKILL.md` 和可执行脚本
3. 尝试调用（需在会话中由 AI 触发）

## 常见问题

**Q：安装后仍无法搜索？**
A：90% 原因为缺少 API 密钥。请确认 `.env` 文件路径正确且密钥有效。

**Q：能否使用 Brave 搜索？**
A：可以，但需通过 `openclaw configure --section web` 配置 Brave Search API Key，同样需要注册获取。

---

> 所有搜索技能均依赖第三方 API，不存在“免密本地搜索”。安装前请确保已获取对应密钥。