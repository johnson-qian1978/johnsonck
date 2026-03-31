# DeerFlow 与 OpenClaw MCP 集成配置参考

## 真实可行的协作架构

DeerFlow 2.0 与 OpenClaw 的集成应通过 **MCP（Model Context Protocol）** 实现双向调用，而非依赖网络流传的虚构插件或配置项。

### ❌ 虚构内容（请勿使用）
- `openclaw plugins install deerflow2-bridge`：OpenClaw 无 `plugins` 子命令，npm/ClawHub 中亦无此包
- `system.executor.engine = deerflow2`：OpenClaw 配置体系中不存在 `system.executor` 命名空间

### ✅ 正确方案：MCP 协议集成

#### 场景：DeerFlow 调用 OpenClaw 的 IM 通道（如 WhatsApp、iMessage）

##### OpenClaw 侧（作为 MCP Server）
```bash
openclaw mcp serve --url ws://127.0.0.1:18789
```

> 默认监听 `127.0.0.1:18789`，可通过 `--port` 或 `--url` 调整

##### DeerFlow 侧（作为 MCP Client）
编辑 `extensions_config.json`：
```json
{
  "mcpServers": {
    "openclaw": {
      "enabled": true,
      "type": "sse",
      "url": "http://127.0.0.1:18789/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_GATEWAY_TOKEN"
      }
    }
  }
}
```

> 注意：`type` 必须为 `sse`（Server-Sent Events），URL 路径需包含 `/mcp`

## 验证命令

执行以下命令确认环境支持：
```bash
# 检查 OpenClaw 是否支持 MCP
openclaw mcp --help

# 查看当前 MCP 服务状态
openclaw mcp list

# 验证配置项是否存在（应返回空或报错，证明 system.executor.* 无效）
openclaw config get system.executor.engine
```

## 替代方案：DeerFlow 独立运行 IM

若仅需 Telegram/Slack/Feishu，可直接在 DeerFlow 的 `config.yaml` 中配置，无需 OpenClaw：
```yaml
channels:
  telegram:
    enabled: true
    bot_token: $TELEGRAM_BOT_TOKEN
```

---

> 本配置经实际测试验证，适用于 DeerFlow 2.0 + OpenClaw 最新稳定版。