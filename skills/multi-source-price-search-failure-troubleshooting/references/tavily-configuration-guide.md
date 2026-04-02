# Tavily 搜索配置与使用指南

## 为什么选择 Tavily？
- 专为 AI 应用设计，支持自然语言查询
- 免费额度：1000 次/月
- 支持中文搜索，结果包含来源链接与日期
- 无需处理反爬机制（对比直连京东/拼多多）

## 配置步骤

### 1. 获取 API Key
- 访问 https://tavily.com 注册账号
- 在 Dashboard 获取免费 API Key（格式如 `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`）

### 2. 写入环境变量或配置文件
```bash
# .env 文件示例
TAVILY_API_KEY=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
```

### 3. Python 调用示例
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

## 注意事项
- 默认搜索可能返回过期结果（如活动价），必须人工核对来源页面日期
- 优先采用专业渠道（如 CFM 闪存市场）的最新报价
- 若未配置 API Key，Tavily 搜索功能将完全不可用