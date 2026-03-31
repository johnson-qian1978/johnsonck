import os
import json
import sys

# 设置 API key
os.environ["BAIDU_API_KEY"] = "bce-v3/ALTAK-ZHH7tSztY6KiGDDcWOJZX/8a8deddac05d0b5f769828a4968055d73d37a397"

# 导入搜索脚本
sys.path.insert(0, r"C:\Users\27151\.openclaw\workspace\skills\baidu-search\scripts")
import search as baidu_search

# 执行搜索
result = baidu_search.baidu_search(
    os.environ["BAIDU_API_KEY"],
    {
        "messages": [{"content": "DeerFlow OpenClaw 协作 集成 配置", "role": "user"}],
        "search_source": "baidu_search_v2",
        "resource_type_filter": [{"type": "web", "top_k": 10}],
        "search_filter": {}
    }
)

print(json.dumps(result, indent=2, ensure_ascii=False))