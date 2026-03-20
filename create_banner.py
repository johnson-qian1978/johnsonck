# -*- coding: utf-8 -*-
"""
创建工会系统 Banner 图片
文字：武汉市总工会 职工困难帮扶管理系统
"""

from PIL import Image, ImageDraw, ImageFont
import math

# 创建图片（与原始图片相似的尺寸和风格）
width = 800
height = 200

# 创建渐变蓝色背景
img = Image.new('RGB', (width, height), color=(73, 160, 242))
draw = ImageDraw.Draw(img)

# 绘制渐变背景（从上到下的蓝色渐变）
for y in range(height):
    # 计算渐变颜色
    ratio = y / height
    r = int(135 + (73 - 135) * ratio)
    g = int(175 + (160 - 175) * ratio)
    b = int(235 + (242 - 235) * ratio)
    draw.line([(0, y), (width, y)], fill=(r, g, b))

# 加载字体
font_paths = [
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/simsun.ttc",      # 宋体
]

title_font_size = 36
subtitle_font_size = 32

title_font = None
subtitle_font = None

for font_path in font_paths:
    try:
        title_font = ImageFont.truetype(font_path, title_font_size)
        subtitle_font = ImageFont.truetype(font_path, subtitle_font_size)
        print(f"使用字体：{font_path}")
        break
    except Exception as e:
        continue

if title_font is None:
    title_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()

# 文字颜色（深蓝色）
text_color = (25, 45, 95)

# 第一行：武汉市总工会
title_text = "武汉市总工会"
title_bbox = draw.textbbox((0, 0), title_text, font=title_font)
title_width = title_bbox[2] - title_bbox[0]
title_x = (width - title_width) // 2
title_y = int(height * 0.35)
draw.text((title_x, title_y), title_text, font=title_font, fill=text_color)

# 第二行：职工困难帮扶管理系统
subtitle_text = "职工困难帮扶管理系统"
subtitle_bbox = draw.textbbox((0, 0), subtitle_text, font=subtitle_font)
subtitle_width = subtitle_bbox[2] - subtitle_bbox[0]
subtitle_x = (width - subtitle_width) // 2
subtitle_y = int(height * 0.55)
draw.text((subtitle_x, subtitle_y), subtitle_text, font=subtitle_font, fill=text_color)

# 添加一些装饰元素（左侧的圆形和图标简化版）
# 绘制半透明圆形背景
circle_center_x = int(width * 0.25)
circle_center_y = int(height * 0.5)
circle_radius = 80

# 绘制几个装饰圆圈
for i in range(3):
    offset = i * 15
    draw.ellipse([
        circle_center_x - circle_radius + offset,
        circle_center_y - circle_radius + offset,
        circle_center_x + circle_radius + offset,
        circle_center_y + circle_radius + offset
    ], outline=(255, 255, 255, 128), width=2)

# 保存
output_path = r"C:\Users\27151\.openclaw\workspace\工会系统_帮扶版.png"
img.save(output_path)
print(f"图片已创建：{output_path}")
print(f"尺寸：{width}x{height}")
print(f"文字内容:")
print(f"  第一行：{title_text}")
print(f"  第二行：{subtitle_text}")
