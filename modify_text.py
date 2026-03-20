# -*- coding: utf-8 -*-
"""
修改图片中的文字：将"救助"改为"帮扶"
"""

from PIL import Image, ImageDraw, ImageFont
import numpy as np
import cv2

# 读取图片
img_path = r"C:\Users\27151\.openclaw\workspace\input_image.png"
output_path = r"C:\Users\27151\.openclaw\workspace\output_image.png"

# 打开图片
img = Image.open(img_path)
width, height = img.size

print(f"图片尺寸：{width}x{height}")

# 创建绘图对象
draw = ImageDraw.Draw(img)

# 使用黑体或微软雅黑字体
# 尝试加载中文字体
font_paths = [
    "C:/Windows/Fonts/simsun.ttc",      # 宋体
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/YaHei.ttf",       # 微软雅黑
]

font_size = int(height * 0.08)  # 字体大小约为图片高度的 8%
font = None

for font_path in font_paths:
    try:
        font = ImageFont.truetype(font_path, font_size)
        print(f"使用字体：{font_path}")
        break
    except:
        continue

if font is None:
    font = ImageFont.load_default()
    print("使用默认字体")

# 原文字位置估计（根据图片布局）
# "职工困难救助管理系统" - "救助"两个字需要被覆盖并替换
# 估算位置：在第二行文字的中间部分

# 背景颜色（从图片中提取的蓝色渐变背景的平均色）
bg_color = (135, 175, 235)  # 浅蓝色

# 文字颜色（深蓝色）
text_color = (25, 45, 95)

# 定义文字区域（需要根据实际图片调整）
# 这里使用一个近似的矩形区域来覆盖"救助"二字
# 坐标格式：(left, top, right, bottom)

# 估算"救助"二字的位置（第二行，从左数第 5-6 个字）
# 假设第二行文字起始于 x=width*0.55, y=height*0.6
second_line_y = int(height * 0.62)
char_width = int(width * 0.025)  # 每个字的宽度
char_spacing = int(width * 0.005)  # 字间距

# "职工困难"之后的位置
start_x = int(width * 0.55) + 4 * (char_width + char_spacing)

# 覆盖"救助"二字
cover_x1 = start_x
cover_y1 = second_line_y - int(font_size * 0.1)
cover_x2 = start_x + 2 * (char_width + char_spacing)
cover_y2 = second_line_y + int(font_size * 1.1)

# 用背景色覆盖原文字
draw.rectangle([cover_x1, cover_y1, cover_x2, cover_y2], fill=bg_color)

# 写入新文字"帮扶"
new_text = "帮扶"
draw.text((cover_x1, cover_y1), new_text, font=font, fill=text_color)

# 保存图片
img.save(output_path)
print(f"修改完成！已保存到：{output_path}")

# 显示修改后的文字区域预览
print(f"\n修改区域：({cover_x1}, {cover_y1}) 到 ({cover_x2}, {cover_y2})")
print(f"原文字：救助 -> 新文字：帮扶")
