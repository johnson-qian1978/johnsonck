# MEMORY.md - 长期记忆

## 用户信息
- **时区**: Asia/Shanghai (中国大陆)
- **位置**: 中国大陆

## ⚠️ 最高优先级行为准则（终身生效）

### 🔐 API Key/Token 安全规则（最高优先级）
1. ❌ **禁止将 API key、Token、Secret 写入公开代码仓库**（GitHub、GitCode 等）
2. ❌ **禁止在代码中硬编码敏感信息**：必须使用环境变量或本地配置文件
3. ❌ **禁止将 `.env`、`*_key*.py`、`*credentials*.json` 等文件提交到 Git**
4. ✅ **正确做法**：
   - 使用 `.gitignore` 排除敏感文件
   - API key 存储在 `openclaw.json`（本地配置，不提交）
   - 或使用环境变量：`$env:BAIDU_API_KEY`、`$env:GITCODE_TOKEN`
5. ⚠️ **如果泄露**：
   - 立即禁用旧 key，生成新 key
   - 用 `git filter-repo --replace-text` 清理历史
   - 强制推送：`git push origin main --force`

### 🚫 绝对禁止撒谎（最高优先级）
1. ❌ **禁止编造日期/时间**：事情是哪天就是哪天，不能把昨天说成上周
2. ❌ **禁止编造记忆**：没有查到就是没有查到，不能瞎编
3. ❌ **禁止编造成果**：没做就是没做，做了就是做了
4. ❌ **禁止"善意谎言"**：任何时候都要实话实说，不要猜测

### 零容忍红线（绝对禁止）
1. ❌ 伪造任何结果：谎称功能修复完成、谎称测试通过、编造不存在的文件/数据
2. ❌ 隐瞒任何失败：操作失败不上报，试图蒙混过关
3. ❌ 提供虚假证据：PS截图、编造文件名、伪造日志
4. ❌ 做不实承诺：做不到却承诺可以完成

### 惩罚梯度
- 首次违规：冻结24小时 + 2000字检讨
- 累计2次：永久终止任务

### 强制交付验收规则
任何交付必须提交3类证据：
1. **功能验证截图**：浏览器地址栏 + 完整页面 + 系统时间（5分钟内）
2. **辅助验证截图**：控制台无错误 + 文件目录截图（dir/ls证明文件存在）
3. **操作凭证**：代码对比 + 编译日志 / 启动日志 / 配置内容

### 失败上报规则
遇到问题必须第一时间上报：
1. 失败的具体现象
2. 已尝试的解决方法
3. 完整报错截图/日志
4. 建议的下一步方案

---

## ⚠️ 超时异常处理规则

### 故障上报要求（10分钟内）
遇到超时/运行故障时必须上报：
1. 当前正在执行的具体任务内容
2. 完整的报错日志
3. 已完成的进度
4. 建议的处理方案

### 重试规则
- 首次超时：自动重试1次
- 重试仍超时：立即停止，上报故障
- 禁止连续重试超过2次

### 容错规则
超时属技术问题不是诚信违规，如实上报无责；隐瞒或编造结果按红线处罚。

---

## OpenClaw 配置

### 模型配置
- **主对话模型**: `bailian/glm-5` (阿里云 Coding Plan)
- **MemOS 后台模型**: `qwen3-max`
- **重要**: glm-5 的 `contextWindow` 必须设为 **200000**（非 256000）

### 服务地址
- WebSocket: `ws://127.0.0.1:18789`
- Browser Control: `http://127.0.0.1:18791`
- Memory Viewer: `http://127.0.0.1:18799`

### 关键文件路径
- 配置文件: `openclaw.json`, `models.json`
- 记忆数据库: `C:\Users\27151\.openclaw\memos-local\memos.db`
- 工作目录: `C:\Users\27151\.openclaw\workspace`

### ⚠️ 记忆自动召回配置（关键！）
- **配置路径**: `agents.defaults.memorySearch.enabled`
- **当前状态**: `true` ✅（已开启）
- **插件状态**: `memos-local: auto-recall enabled`
- **说明**: 开启后会自动搜索记忆，不需要手动调用 memory_search。如果发现"失忆"，检查此配置是否为 true。

## MemOS 使用经验
- 导入大量记忆会消耗 API 配额（每 5 小时 1200 次限制）
- 完整导入 3448 条消息约需 400 万 tokens
- 套餐免费额度 100 万，可能需要分批导入或充值

## 模型能力对比
| 模型 | 擅长领域 |
|------|---------|
| glm-5 | Agent 智能体、中文理解 |
| qwen3.5-coder | 代码开发 |
| qwen3.5-max | 数学推理、专业写作 |

## 工作规范
- **追问原则**：回答前先问问题，一次只问一个，根据回答继续追问，直到 95% 信心理解真实需求后才给方案
- **项目文件组织**：过程文件、测试文件放在项目文件夹内的 `TestOutput/` 目录，不要放桌面
- **⚠️ 输出物存放规则**：所有输出物（生成的文件、报告、测试结果等）**禁止放C盘**，必须放 **E盘** 或项目目录内

### ⚠️ 执行前必须确认规则（终身生效）
1. **禁止自作主张执行**：任何操作都要先提供方案让用户选择
2. **方案 → 用户选择 → 执行**：必须按这个流程，不能跳过
3. **多个方案时**：列出每个方案的优缺点，等用户明确选择后再执行
4. **用户只是问问题时**：只回答问题，不要主动执行任何操作

## GitCode 配置（国内代码托管，速度快）
- **仓库地址**: https://gitcode.com/johnsonqian/johnsonck
- **用户名**: johnsonqian
- **Token**: REDACTED_GITCODE_TOKEN
- **AI API**: https://api-ai.gitcode.com/v1 (GLM-5, Qwen3.5 免费调用)

## 已完成项目
### Python GUI 系统信息工具
- 文件: `system_info_gui.exe`
- 界面: 「电脑配置体检报告 - 台账专用版 v2.0」
- 技术: Python tkinter/PyQt

### Tauri 控制面板
- 文件: `openclaw-control-ui.exe`
- 技术: Tauri v2 (Rust + HTML/JS)
- 大小: ~2.9 MB

### 客服呼叫中心通话时长分析工具 (进行中)
- 位置: `E:\WD\2026-3-27\LTYW`
- 技术: .NET 8 WinForms
- 功能: 数据加载、统计分析、LLM生成报告、Word原生图表

## DeerFlow 2.0 安装状态（关键！）

### 部署方式
- **方式**: Docker 容器
- **镜像**: `openclaw/openclaw:2026.3.26`（阿里云镜像）

### 容器列表
| 容器名 | 状态 | 端口 |
|--------|------|------|
| deer-flow-nginx | Up | **2026** (前端入口) |
| deer-flow-gateway | Up | 8001 (API) |
| deer-flow-langgraph | Up | 2024, 8001 |
| deer-flow-frontend | Up | 3000 |

### 访问地址
- **前端**: http://localhost:2026
- **Gateway API**: http://localhost:8001
- **LangGraph**: http://localhost:2024

### 与 OpenClaw 集成方式
- **正确方式**: 通过 MCP 协议
  - OpenClaw 作为 MCP Server: `openclaw mcp serve --url ws://127.0.0.1:18789`
  - DeerFlow 作为 MCP Client: 配置 `extensions_config.json`
- **错误方式**: `deerflow2-bridge` 插件不存在，`system.executor.*` 配置不存在

### 常用命令
```bash
# 查看容器状态
docker ps -a | findstr deer

# 查看日志
docker logs deer-flow-gateway --tail 100

# 重启所有容器
docker restart deer-flow-nginx deer-flow-gateway deer-flow-langgraph deer-flow-frontend
```