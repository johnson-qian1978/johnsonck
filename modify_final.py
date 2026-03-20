# -*- coding: utf-8 -*-
"""
修改原始图片：将"救助"改为"帮扶"
使用更精确的方法
"""

from PIL import Image, ImageDraw, ImageFont
import numpy as np

# 原始图片路径
input_path = r"E:\工作目录\D\work\项目资料\武汉市总工会\2026\6726a5d4-fd8b-4be7-8a9f-1bcf0db92925.png"
output_path = r"C:\Users\27151\.openclaw\workspace\工会系统_帮扶版_完美.png"

# 打开原始图片并转换为 numpy 数组
img = Image.open(input_path).convert('RGB')
width, height = img.size
print(f"原始图片尺寸：{width}x{height}")

# 创建绘图对象
draw = ImageDraw.Draw(img)

# 加载中文字体（微软雅黑 Bold）
font_size = 16  # 稍微大一点
font = ImageFont.truetype("C:/Windows/Fonts/msyhbd.ttc", font_size)

# 目标："职工困难救助管理系统" -> "职工困难帮扶管理系统"
# 根据原图精确测量：
# - 第二行文字起始 X ≈ 305px (52.2% width)
# - 第二行文字 Y ≈ 105px (58.6% height)  
# - "救助"是第 5-6 个字

# 先测量完整文字的宽度来推算每个字的位置
test_text = "职工困难救助管理系统"
bbox = draw.textbbox((0, 0), test_text, font=font)
text_width = bbox[2] - bbox[0]
text_height = bbox[3] - bbox[1]
avg_char_width = text_width / len(test_text)

print(f"平均字符宽度：{avg_char_width:.1f}px")
print(f"文字高度：{text_height:.1f}px")

# 第二行文字位置
subtitle_y = int(height * 0.586)  # ~105px
subtitle_start_x = int(width * 0.522)  # ~305px

# "救助"二字的位置（第 5-6 个字，索引 4-5）
target_index = 4
char_spacing = avg_char_width * 0.05
cover_x = subtitle_start_x + target_index * (avg_char_width + char_spacing)
cover_y = subtitle_y - text_height * 0.1  # 稍微向上调整

# 覆盖区域大小
cover_width = avg_char_width * 2.2
cover_height = text_height * 1.3

print(f"\n修改区域:")
print(f"  X: {cover_x:.0f} - {cover_x + cover_width:.0f}")
print(f"  Y: {cover_y:.0f} - {cover_y + cover_height:.0f}")

# 方法：从"救助"上方区域复制背景色块来覆盖
# 这样能保持完美的渐变背景
sample_y_top = int(cover_y - text_height * 0.8)
sample_height = int(text_height * 0.6)

if sample_y_top >= 0:
    # 从正上方复制一块背景
    bg_sample = img.crop((
        int(cover_x), 
        sample_y_top, 
        int(cover_x + cover_width), 
        sample_y_top + sample_height
    ))
    
    # 将采样的背景粘贴到要覆盖的区域
    img.paste(bg_sample, (int(cover_x), int(cover_y)))

# 现在写入"帮扶"二字
text_color = (25, 45, 95)  # 深蓝色，匹配原文字

# 微调位置使新文字与周围完美对齐
text_x = cover_x - avg_char_width * 0.02
text_y = cover_y - text_height * 0.05

draw.text((text_x, text_y), "帮扶", font=font, fill=text_color)

# 保存输出文件
img.save(output_path, format='PNG', optimize=True)

print(f"\n[OK] 修改完成！")
print(f"输出文件：{output_path}")
print(f"文件大小：{os.path.getsize(output_path) / 1024:.1f} KB")
print(f"\n修改摘要:")
print(f"  原文字：职工困难救助管理系统")
print(f"  新文字：职工困难帮扶管理系统")
print(f"  字体：微软雅黑 Bold, {font_size}px")
print(f"  文字颜色：RGB{text_color}")
