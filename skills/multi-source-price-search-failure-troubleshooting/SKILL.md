---
name: "multi-source-price-search-failure-troubleshooting"
description: "排查多源价格搜索失败问题，包括百度搜索 API 500 错误、API 密钥泄露、替代搜索工具（如 Tavily、DuckDuckGo）配置失败、数据时效性不足等。当用户提到“搜索不到价格”、“百度搜不了”、“结果是旧的”、“拼多多价格太高想比价”、“其他搜索方式”、“Tavily 没配置”或需要验证内存/硬件最新报价时，立即触发本技能。适用于电商比价、API 故障诊断、搜索回退策略制定等场景。"
metadata: { "openclaw": { "emoji": "🔍" } }
---

# 多源价格搜索故障排查与替代方案实施

本技能帮助你在主流搜索服务（如百度 AI 搜索）失效时，快速切换至备用方案（如 Tavily），验证数据时效性，并解决因密钥泄露、服务未开通或架构限制导致的搜索中断问题。

## 何时使用本技能
- 当百度搜索返回 500 错误，且已更换 API Key 仍无效，怀疑服务未开通或密钥未生效。
- 用户指出搜索结果过时（如显示数月前的价格），需手动验证最新渠道报价。
- 需要通过非百度方式（如 Tavily、DuckDuckGo、直连电商平台）获取商品实时价格，但相关工具未配置或调用失败。
- DeerFlow 或 OpenClaw 出现 Thread 丢失、HTTP 404 或工具调用异常，需恢复会话状态。

## 步骤

### 1. 确认百度 API Key 泄露并更新
```bash
# 检查 openclaw.json 中的百度 key 是否为历史泄露值：
# bce-v3/ALTAK-ZHH7tSztY6KiGDDcWOJZX/8a8deddac05d0b5f769828a4968055d73d37a397
```
→ **为何重要**：该 key 已在 Git 历史中被标记为泄露，可能已被百度禁用，即使配置正确也会返回 500 错误。

### 2. 替换为新百度 API Key 并重启 Gateway
```json
// openclaw.json 更新示例
"BAIDU_API_KEY": "ALTAK-Q3CyICMVs9f4DrLXXKCHE/fe3b04658f6bd4897a2d784647fb8bc0659bc00b"
```
→ **为何重要**：新 key 需显式创建，但仅替换不足以解决问题——必须在百度智能云控制台确认“千帆 AI 搜索”服务已开通，否则仍返回 500。

### 3. 配置 Tavily 作为主备搜索方案
```bash
# 在 .env 或配置文件中添加
TAVILY_API_KEY=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
```
→ **为何重要**：Tavily 专为 AI 设计，免费额度 1000 次/月，支持中文查询，且无需复杂反爬处理，是百度失效时的最佳替代。

### 4. 执行中文搜索并验证数据时效性
```python
response = tavily.search(
    query="联想 DDR5 5600 16GB 笔记本内存 价格",
    include_answer=True,
    max_results=5
)
```
→ **为何重要**：默认搜索可能返回英文或过期结果（如中关村在线 2024-12-16 的活动价），必须人工核对来源日期，优先采用 CFM 闪存市场等专业渠道的最新报价（如 2026-03-31 的 ¥170）。

### 5. 修复 DeerFlow Thread 丢失问题
```bash
# 定位 checkpoint 数据库
ls /app/backend/.deer-flow/checkpoints.db
# 创建新 Thread（系统自动生成）
```
→ **为何重要**：容器重启或前端缓存会导致旧 Thread ID 失效，抛出 404 异常；强制刷新页面并新建对话可恢复会话状态。

## 常见陷阱与解决方案
❌ 使用泄露的百度 API Key → 百度服务端拒绝请求，返回空 500 → ✅ 立即在控制台禁用旧 key，创建新 key 并确认服务开通  
❌ 依赖 Tavily 但未配置 API Key → 搜索功能完全不可用 → ✅ 从 https://tavily.com 申请免费 key 并写入环境变量  
❌ 直接抓取京东/拼多多页面 → 触发反爬机制（验证码、登录墙）→ ✅ 放弃直连，改用 Tavily 或 DeerFlow 内置的 Jina AI 抓取  
❌ 接受搜索结果中的“活动价”而不验证日期 → 推荐过期低价误导用户 → ✅ 手动打开链接核对最新报价，区分批发价（¥170）与零售合理区间（¥250–350）  
❌ 尝试通过 HTTP 调用 OpenClaw 工具 → 返回 404 → ✅ 理解 OpenClaw 架构：仅支持 WebSocket 会话通信，禁止远程 HTTP 工具调用  

## 关键代码和配置
**Tavily 搜索调用示例（Python）**
```python
from tavily import TavilyClient

client = TavilyClient(api_key="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")
response = client.search(
    query="联想 DDR5 5600 16GB 笔记本内存 价格",
    search_depth="advanced",
    include_answer=True,
    max_results=5
)
print(response["answer"])
```

**OpenClaw 百度 Key 配置片段（openclaw.json）**
```json
{
  "plugins": {
    "baidu-search": {
      "enabled": true,
      "config": {
        "api_key": "ALTAK-Q3CyICMVs9f4DrLXXKCHE/fe3b04658f6bd4897a2d784647fb8bc0659bc00b"
      }
    }
  }
}
```

## 环境与前提条件
- **操作系统**：Linux/macOS/Windows（路径需适配）
- **依赖服务**：
  - OpenClaw Gateway ≥ v0.8.0
  - DeerFlow ≥ v0.5.0（含 SQLite checkpoint 支持）
  - Python ≥ 3.8（用于 Tavily SDK）
- **网络权限**：可访问 `api.tavily.com`、`console.bce.baidu.com`
- **账号权限**：百度智能云项目管理员（用于开通服务）、Tavily 账号（免费注册）

## 附加工具文件
- `scripts/update_baidu_key.py` — 自动替换 openclaw.json 中的百度 API Key 并重启 Gateway
- `scripts/verify_price_freshness.py` — 解析 Tavily 结果，提取来源 URL 并检查页面日期
- `references/deerflow-thread-recovery.md` — DeerFlow Thread 丢失的详细恢复流程

## Companion files

- `scripts/update_baidu_key.py` — automation script
- `scripts/configure_tavily_search.sh` — automation script
- `scripts/verify_price_freshness.py` — automation script
- `references/baidu-api-key-troubleshooting.md` — reference documentation
- `references/tavily-configuration-guide.md` — reference documentation
- `references/deerflow-thread-recovery.md` — reference documentation