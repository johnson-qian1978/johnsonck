# -*- coding: utf-8 -*-
"""
重新绘制工会系统 Banner（修改文字为"帮扶"）
尽量还原原始设计
"""

from PIL import Image, ImageDraw, ImageFont
import math

# 创建图片（根据看到的比例估算）
width = 900
height = 300

# 创建渐变蓝色背景（从上到下的浅蓝到中蓝）
img = Image.new('RGB', (width, height), color=(135, 206, 250))
draw = ImageDraw.Draw(img)

# 绘制细腻的渐变背景
for y in range(height):
    ratio = y / height
    # 顶部颜色：浅蓝白
    r1, g1, b1 = 240, 248, 255
    # 底部颜色：中蓝色
    r2, g2, b2 = 135, 206, 250
    
    r = int(r1 + (r2 - r1) * ratio)
    g = int(g1 + (g2 - g1) * ratio)
    b = int(b1 + (b2 - b1) * ratio)
    draw.line([(0, y), (width, y)], fill=(r, g, b))

# 加载字体
font_paths = [
    "C:/Windows/Fonts/msyhbd.ttc",      # 微软雅黑 Bold
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
]

title_font_size = 48
subtitle_font_size = 42

title_font = None
subtitle_font = None

for font_path in font_paths:
    try:
        title_font = ImageFont.truetype(font_path, title_font_size)
        subtitle_font = ImageFont.truetype(font_path, subtitle_font_size)
        print(f"使用字体：{font_path}")
        break
    except:
        continue

if title_font is None:
    title_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()

# 文字颜色（深蓝色，与原文匹配）
text_color = (30, 50, 100)

# 第一行：武汉市总工会
title_text = "武汉市总工会"
title_bbox = draw.textbbox((0, 0), title_text, font=title_font)
title_width = title_bbox[2] - title_bbox[0]
title_x = (width - title_width) // 2
title_y = int(height * 0.38)
draw.text((title_x, title_y), title_text, font=title_font, fill=text_color)

# 第二行：职工困难帮扶管理系统（已修改）
subtitle_text = "职工困难帮扶管理系统"
subtitle_bbox = draw.textbbox((0, 0), subtitle_text, font=subtitle_font)
subtitle_width = subtitle_bbox[2] - subtitle_bbox[0]
subtitle_x = (width - subtitle_width) // 2
subtitle_y = int(height * 0.55)
draw.text((subtitle_x, subtitle_y), subtitle_text, font=subtitle_font, fill=text_color)

# 添加左侧的装饰元素（简化版）
# 圆形背景
circle_center_x = int(width * 0.28)
circle_center_y = int(height * 0.5)
circle_radius = 90

# 绘制半透明圆环
for i in range(5):
    offset = i * 8
    alpha = int(80 - i * 12)
    draw.ellipse([
        circle_center_x - circle_radius + offset,
        circle_center_y - circle_radius + offset,
        circle_center_x + circle_radius + offset,
        circle_center_y + circle_radius + offset
    ], outline=(255, 255, 255, alpha), width=2)

# 绘制简化的界面图标（白色矩形代表屏幕）
screen_x = circle_center_x - 60
screen_y = circle_center_y - 40
screen_w = 120
screen_h = 80

# 屏幕背景
draw.rounded_rectangle([screen_x, screen_y, screen_x + screen_w, screen_y + screen_h], 
                       radius=5, fill=(255, 255, 255, 200))

# 屏幕内的简化图表线条
chart_y = screen_y + 15
for i in range(3):
    bar_x = screen_x + 15 + i * 28
    bar_h = 20 + i * 8
    draw.rectangle([bar_x, chart_y, bar_x + 18, chart_y + bar_h], 
                   fill=(100, 150, 255, 180))

# 保存
output_path = r"C:\Users\27151\.openclaw\workspace\工会系统_帮扶版_重绘.png"
img.save(output_path)
print(f"\n[OK] 图片已创建：{output_path}")
print(f"尺寸：{width}x{height}")
print(f"\n文字内容:")
print(f"  第一行：{title_text}")
print(f"  第二行：{subtitle_text} ← 已修改")
