# DeerFlow 与 OpenClaw 集成 API 规范

## 架构概述

DeerFlow 通过 **Gateway API（端口 8091）** 对外暴露能力，OpenClaw 作为上层调度器，通过 HTTP 请求调用 DeerFlow 执行深度任务。

```
OpenClaw → HTTP POST http://localhost:8091/run → DeerFlow Agent → Sandbox → 结果返回
```

> 📌 注意：DeerFlow **不支持**直接文件调用、进程嵌入或共享内存方式。所有交互必须通过其 RESTful API。

## 核心 API 端点

### `/health` - 服务健康检查

- **方法**：GET
- **用途**：验证 DeerFlow 服务是否就绪
- **成功响应**：`{"status": "ok"}`
- **调用示例**：
  ```bash
  curl http://localhost:8091/health
  ```

### `/run` - 执行智能体任务

- **方法**：POST
- **Content-Type**：`application/json`
- **请求体字段**：
  | 字段 | 类型 | 必填 | 说明 |
  |------|------|------|------|
  | `task` | string | 是 | 用户自然语言任务描述 |
  | `model` | string | 否 | 指定模型名称（需在 `config.yaml` 中定义） |
  | `session_id` | string | 否 | 会话 ID，用于记忆上下文 |

- **成功响应**：
  ```json
  {
    "result": "...",
    "session_id": "..."
  }
  ```

- **调用示例**：
  ```http
  POST http://localhost:8091/run
  Content-Type: application/json

  {
    "task": "分析 GitHub 上 deer-flow 项目的架构",
    "model": "glm-5"
  }
  ```

## 配置要求

DeerFlow 的 `config.yaml` 必须包含有效的模型配置，例如：

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

> 🔑 `api_key` 必须通过环境变量 `$GITCODE_API_KEY` 注入，不可硬编码。

## 错误处理

| HTTP 状态码 | 含义 | 建议操作 |
|------------|------|--------|
| 400 | 请求格式错误 | 检查 JSON 结构和必填字段 |
| 500 | 模型加载失败 | 确认 `config.yaml` 中模型配置正确且 API 密钥有效 |
| 连接拒绝 | DeerFlow 未启动 | 执行 `make docker-start` 并验证 `http://localhost:2026` 可访问 |

## 调试建议

1. 先通过 Web UI (`http://localhost:2026`) 验证 DeerFlow 功能正常
2. 使用 `curl` 或 Postman 测试 `/run` 接口
3. 确保 OpenClaw 与 DeerFlow 运行在同一主机（`localhost` 可达）

---

> 此规范定义了 OpenClaw 与 DeerFlow 协作的唯一合法接口，替代任何非标准调用尝试。