import sqlite3
import os

db_path = r"C:\Users\27151\.openclaw\memos-local\memos.db"

if not os.path.exists(db_path):
    print(f"数据库不存在: {db_path}")
    exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# 查看 chunks 表结构
cursor.execute("PRAGMA table_info(chunks)")
print("chunks 表结构:")
for col in cursor.fetchall():
    print(f"  {col[1]}: {col[2]}")

# 总记忆条数
cursor.execute("SELECT COUNT(*) FROM chunks")
total = cursor.fetchone()[0]
print(f"\n总记忆条数: {total}")

# 按角色统计
cursor.execute("""
    SELECT role, COUNT(*) as count 
    FROM chunks 
    GROUP BY role
""")
print("\n按角色统计:")
for row in cursor.fetchall():
    print(f"  {row[0]}: {row[1]} 条")

# 查看最近的5条记忆
cursor.execute("""
    SELECT id, role, substr(content, 1, 100) as content_preview
    FROM chunks 
    ORDER BY id DESC 
    LIMIT 5
""")
print("\n最近的5条记忆（内容预览）:")
for row in cursor.fetchall():
    print(f"  ID: {row[0]}, Role: {row[1]}")
    print(f"    Content: {row[2]}...")
    print()

# 数据库大小
db_size = os.path.getsize(db_path) / (1024 * 1024)
print(f"数据库大小: {db_size:.2f} MB")

conn.close()