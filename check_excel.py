# -*- coding: utf-8 -*-
import os
import sys

# 使用原始字符串
base = r"E:\工作目录\D\work\项目资料\贵阳市医疗互助保障管理系统\2025 年\综合给付"
print(f"Base path: {base}")
print(f"Exists: {os.path.exists(base)}")

if os.path.exists(base):
    for f in os.listdir(base):
        print(f"  - {f}")
else:
    print("Path not found!")
