# DeerFlow Windows 安装前置条件与依赖说明

## 核心依赖关系

DeerFlow 2.0 **不支持原生 Windows 环境**，因其依赖 `forbiddenfruit==0.1.4` 等仅兼容 POSIX 系统的 Python 包。必须通过以下组合提供 Linux 兼容层：

- **WSL2（Windows Subsystem for Linux 2）**：提供完整的 Linux 内核兼容环境
- **Docker Desktop**：依赖 WSL2 作为容器后端，用于运行 `aio_sandbox`

> ⚠️ 即使 Docker Desktop 已安装至 `C:\Program Files\Docker\Docker`，若未启用 WSL2，Docker 服务将无法启动，表现为 "Docker Desktop is unable to start"。

## 验证清单

| 组件 | 验证命令 | 预期输出 |
|------|--------|--------|
| WSL2 | `wsl --list --verbose` | 至少包含一个发行版（如 Ubuntu），状态为 `Running`，版本为 `2` |
| Docker Desktop | `docker info`（在 WSL 中执行） | 显示 Docker 引擎信息，无错误 |
| Ubuntu 发行版 | `wsl -d Ubuntu -e uname -a` | 返回 Linux 内核信息 |

## 安装顺序（不可颠倒）

1. **以管理员权限打开 PowerShell**
2. 执行 `wsl --install -d Ubuntu` 并重启电脑
3. 首次启动 Ubuntu，设置用户名和密码
4. 安装 [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
5. 启动 Docker Desktop，确认系统托盘图标为“Running”

> 💡 提示：Docker Desktop 安装过程中若卡住，通常是因为正在后台下载 WSL2 内核或 Hyper-V 组件，请耐心等待或手动预装 WSL2。

## 常见失败模式

- **现象**：`uv sync` 卡在 `Building forbiddenfruit==0.1.4`
  **原因**：在 Windows 原生命令行（CMD/PowerShell）中执行，非 WSL 环境
  **解决**：所有 DeerFlow 操作必须在 WSL Ubuntu 终端中进行

- **现象**：Docker Desktop 启动失败，提示 “unable to start”
  **原因**：WSL2 未安装或未设为默认版本
  **解决**：运行 `wsl --set-default-version 2` 并确保至少有一个 WSL2 发行版

- **现象**：`make docker-start` 成功但 OpenClaw 调用失败
  **原因**：未通过 `localhost:8091` 调用 Gateway API
  **解决**：所有外部集成必须使用 HTTP 接口，而非文件或进程调用

## 环境变量要求

DeerFlow 的 `config.yaml` 中若引用 `$GITCODE_API_KEY`，需在 WSL Ubuntu 中设置：

```bash
export GITCODE_API_KEY=your_actual_key
```

或在启动服务前写入 `~/.bashrc`。

---

> 此文档适用于所有在 Windows 上部署 DeerFlow 2.0 的场景，是 SKILL.md 中“步骤”部分的技术补充。