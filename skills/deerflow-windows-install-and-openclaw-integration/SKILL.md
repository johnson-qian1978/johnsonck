---
name: "deerflow-windows-install-and-openclaw-integration"
description: "在 Windows 系统上成功安装并运行 DeerFlow 2.0，并实现其与 OpenClaw 的协同工作。当用户提到“DeerFlow Windows 安装”、“DeerFlow 跑不起来”、“forbiddenfruit 报错”、“Docker Desktop 卡住”、“WSL 未安装”、“如何让 OpenClaw 和 DeerFlow 一起用”、“配置 DeerFlow 模型”或“DeerFlow 与 OpenClaw 协作方案”时，必须触发本技能。即使用户只说“想在 Windows 上跑 DeerFlow”或“DeerFlow 怎么和 OpenClaw 配合”，也应激活此技能——因为 DeerFlow 官方不支持原生 Windows，必须通过 WSL2 + Docker 方案，且协作需明确指令规范。"
metadata: { "openclaw": { "emoji": "🦌" } }
---

# 在 Windows 上安装 DeerFlow 2.0 并与 OpenClaw 协同工作

本技能提供经过验证的完整路径：通过 WSL2 + Docker Desktop 在 Windows 上运行 DeerFlow，并定义其与 OpenClaw 的三种协作模式及用户指令规范。

## 何时使用本技能
- 当你在 Windows 上尝试原生安装 DeerFlow 但卡在 `forbiddenfruit==0.1.4` 编译错误时（该包仅支持 Linux/macOS）。
- 当你已安装 Docker Desktop 但无法启动容器，怀疑缺少 WSL2 后端依赖时。
- 当你需要明确 DeerFlow 与 OpenClaw 如何分工协作，并希望获得可直接使用的指令模板和配置示例时。
- 当你想在本地部署 DeerFlow 并通过 OpenClaw 调用其深度任务能力，但不确定架构集成方式时。

## 步骤

### 1. 安装 WSL2（必需前提）
```powershell
wsl --install -d Ubuntu
```
**为什么重要**：Docker Desktop on Windows 强制依赖 WSL2 作为容器后端。即使 Docker 程序已安装至 `C:\Program Files\Docker\Docker`，若无 WSL2 仍无法运行任何容器。安装后需重启电脑，并在首次启动时设置 Ubuntu 用户名和密码。

### 2. 启动 Docker Desktop
重启后，Docker Desktop 应自动启动。确认系统托盘中出现 Docker 鲸鱼图标，且状态为“Running”。  
**为什么重要**：DeerFlow 的 Sandbox（`aio_sandbox`）依赖 Docker 容器执行代码，必须确保 Docker 服务正常就绪。

### 3. 克隆并配置 DeerFlow
```bash
git clone https://github.com/bytedance/deer-flow.git
cd deer-flow
cp config.example.yaml config.yaml
```
编辑 `config.yaml`，填入模型配置（推荐 GitCode GLM-5）：
```yaml
models:
  - name: glm-5
    use: langchain_openai:ChatOpenAI
    model: glm-5
    api_key: $GITCODE_API_KEY
    base_url: https://api-ai.gitcode.com/v1
```
**为什么重要**：DeerFlow 默认配置可能指向不可用模型，必须显式指定可用 API 端点和密钥环境变量。

### 4. 启动 DeerFlow 服务
```bash
make docker-init  # 拉取 sandbox 镜像
make docker-start # 启动核心服务
```
**为什么重要**：`docker-init` 确保 Sandbox 所需的 Docker 镜像已下载；`docker-start` 同时启动 Web UI（端口 2026）和 Gateway API（端口 8091），后者是 OpenClaw 集成的关键接口。

### 5. 验证服务状态
- 访问 Web UI：http://localhost:2026
- 测试 API：`curl http://localhost:8091/health`
**为什么重要**：确认 DeerFlow 已完全就绪，避免因服务未启动导致 OpenClaw 调用失败。

## 坑点与解决方案
❌ 直接在 Windows 原生环境运行 `uv sync` → 因 `forbiddenfruit` 依赖 POSIX 特性，编译永久卡死 → ✅ 必须通过 WSL2 提供 Linux 环境  
❌ 安装 Docker Desktop 但跳过 WSL2 → Docker 服务显示“unable to start” → ✅ 先执行 `wsl --install -d Ubuntu` 并重启  
❌ 使用默认 `config.yaml` 未配置模型 → 启动时报模型加载错误 → ✅ 显式配置 `base_url` 和 `$GITCODE_API_KEY` 环境变量  
❌ 试图通过文件路径直接调用 DeerFlow → 忽略其基于 HTTP Gateway 的设计 → ✅ 所有外部调用必须通过 `localhost:8091` API

## 关键代码和配置

### `config.yaml` 核心片段
```yaml
models:
  - name: glm-5
    use: langchain_openai:ChatOpenAI
    model: glm-5
    api_key: $GITCODE_API_KEY
    base_url: https://api-ai.gitcode.com/v1

sandbox:
  use: deerflow.community.aio_sandbox:AioSandboxProvider

memory:
  enabled: true
  storage_path: memory.json
```

### OpenClaw 调用 DeerFlow 的 API 示例
```http
POST http://localhost:8091/run
Content-Type: application/json

{
  "task": "分析 GitHub 上 deer-flow 项目的架构",
  "model": "glm-5"
}
```

## 环境和先决条件
- **操作系统**：Windows 10/11（需启用 WSL2 功能）
- **权限**：PowerShell 管理员权限（用于安装 WSL）
- **依赖软件**：
  - Docker Desktop ≥ 4.0（自动绑定 WSL2 后端）
  - Ubuntu 22.04 LTS（通过 WSL 安装）
- **API 密钥**：GitCode 账户的 `$GITCODE_API_KEY`（免费额度足够）
- **磁盘空间**：至少 5GB（含 WSL Ubuntu、Docker 镜像、DeerFlow 仓库）

## Companion files
- `scripts/deerflow-start.sh` — 自动化启动脚本：检查 WSL/Docker 状态后执行 `make docker-start`
- `references/deerflow-openclaw-collab.md` — 详细协作架构图、三种集成方式对比表、故障排查清单