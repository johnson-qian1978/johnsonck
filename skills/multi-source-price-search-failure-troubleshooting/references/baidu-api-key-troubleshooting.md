# 百度 AI 搜索 API 密钥故障排查指南

## 常见问题

### 1. 使用泄露的 API Key 导致 500 错误
- **泄露 Key 示例**：`bce-v3/ALTAK-ZHH7tSztY6KiGDDcWOJZX/8a8deddac05d0b5f769828a4968055d73d37a397`
- **现象**：即使配置正确，百度 API 返回空 500 错误
- **原因**：该密钥已在 Git 历史中泄露，被百度服务端主动禁用
- **解决方案**：
  1. 立即在 [百度智能云控制台](https://console.bce.baidu.com/ai-search/qianfan/ais/console/apiKey) 禁用旧 Key
  2. 创建全新 API Key
  3. 更新 `openclaw.json` 中的 `BAIDU_API_KEY` 字段
  4. **关键步骤**：确认已开通“千帆 AI 搜索”服务，否则新 Key 仍会返回 500

### 2. 新 Key 配置后仍无效
- **可能原因**：
  - 服务未开通（仅创建 Key 不够）
  - Key 尚未生效（需等待 5–10 分钟）
  - Gateway 未重启加载新配置
- **验证方法**：
  ```bash
  # 检查 openclaw.json 是否包含新 Key
  grep "ALTAK-Q3CyICMVs9f4DrLXXKCHE" openclaw.json
  # 重启 Gateway
  pkill -f openclaw-gateway && nohup openclaw-gateway &
  ```