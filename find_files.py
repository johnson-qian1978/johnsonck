# -*- coding: utf-8 -*-
import os
import sys

if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

# 从 E:\工作目录 开始搜索
root = r"E:\工作目录"
print(f"Searching from: {root}")

found_files = []
for dirpath, dirnames, filenames in os.walk(root):
    for filename in filenames:
        if '综合给付' in filename and filename.endswith('.xlsx'):
            fullpath = os.path.join(dirpath, filename)
            # 只找贵阳市和 2025 年的
            if '贵阳' in dirpath and '2025' in dirpath:
                found_files.append(fullpath)
                print(f"Found: {fullpath}")

print(f"\nTotal found: {len(found_files)}")
