# -*- coding: utf-8 -*-
"""
修改图片文字：将"救助"改为"帮扶"
保持背景和其他所有元素不变
"""

from PIL import Image, ImageDraw, ImageFont
import os

# 输入输出路径
input_path = r"C:\Users\27151\.openclaw\workspace\original_banner.png"
output_path = r"C:\Users\27151\.openclaw\workspace\modified_banner.png"

# 打开原始图片
img = Image.open(input_path).convert('RGB')
width, height = img.size
print(f"图片尺寸：{width}x{height}")

# 创建绘图对象
draw = ImageDraw.Draw(img)

# 加载中文字体
font_paths = [
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/msyhl.ttc",       # 微软雅黑 Light
    "C:/Windows/Fonts/msyhbd.ttc",      # 微软雅黑 Bold
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
]

# 估算字体大小
font_size = int(height * 0.11)  # 第二行字约占图片高度的 11%
font = None

for font_path in font_paths:
    try:
        font = ImageFont.truetype(font_path, font_size)
        print(f"使用字体：{font_path}, 大小：{font_size}")
        break
    except:
        continue

if font is None:
    print("警告：使用默认字体")
    font = ImageFont.load_default()

# 目标文字："职工困难救助管理系统" -> "职工困难帮扶管理系统"
# 需要定位"救助"二字并替换为"帮扶"

# 通过文本边界框估算字符宽度
test_text = "职工困难救助管理系统"
bbox = draw.textbbox((0, 0), test_text, font=font)
text_width = bbox[2] - bbox[0]
text_height = bbox[3] - bbox[1]
avg_char_width = text_width / len(test_text)

print(f"整行文字宽度：{text_width:.1f}, 高度：{text_height:.1f}")
print(f"平均字符宽度：{avg_char_width:.1f}")

# 估算第二行文字的位置
# 根据图片比例，第二行文字大约在垂直方向 55-60% 处
second_line_y = int(height * 0.52)

# 估算文字起始 X 坐标（从图片左侧开始）
# 根据图片布局，文字大约从 45% 宽度处开始
text_start_x = int(width * 0.42)

# "救助"是第 5-6 个字（索引 4-5，从 0 开始）
# "职工困难" = 4 个字
target_char_index = 4  # "救"字的索引
char_spacing = avg_char_width * 0.05  # 字间距

# 计算"救助"二字的起始位置
cover_x = text_start_x + target_char_index * (avg_char_width + char_spacing)
cover_y = second_line_y

# 覆盖区域大小（"救助"两个字的宽度）
cover_width = avg_char_width * 2.1
cover_height = text_height * 1.15

print(f"\n修改区域:")
print(f"  X: {cover_x:.0f} - {cover_x + cover_width:.0f}")
print(f"  Y: {cover_y - text_height*0.1:.0f} - {cover_y + text_height*1.05:.0f}")

# 从原图"救助"文字周围采样背景色
# 取文字上方和下方的区域来估算背景渐变
sample_margin = 5
sample_x1 = max(0, int(cover_x))
sample_y1 = max(0, int(cover_y - text_height - sample_margin))
sample_x2 = min(width, int(cover_x + cover_width))
sample_y2 = min(height, int(cover_y + text_height + sample_margin))

# 获取采样区域的像素
sample_region = img.crop((sample_x1, sample_y1, sample_x2, sample_y2))
pixels = list(sample_region.getdata())

# 计算平均背景色（排除文字颜色）
# 文字是深蓝色，背景是浅蓝色渐变
bg_pixels = []
for pixel in pixels:
    r, g, b = pixel[:3]
    # 排除深蓝色文字（文字的蓝色分量较低）
    if b > 150 and r > 100:  # 浅色背景
        bg_pixels.append(pixel)

if bg_pixels:
    avg_r = sum(p[0] for p in bg_pixels) // len(bg_pixels)
    avg_g = sum(p[1] for p in bg_pixels) // len(bg_pixels)
    avg_b = sum(p[2] for p in bg_pixels) // len(bg_pixels)
    bg_color = (avg_r, avg_g, avg_b)
else:
    # 默认浅蓝色背景
    bg_color = (180, 210, 250)

print(f"采样背景色：RGB{bg_color}")

# 更精确的方法：直接从"救助"上方一点的位置采样
# 因为背景是渐变的，用正上方的颜色最准确
sample_above_y = int(cover_y - text_height * 0.8)
sample_point_x = int(cover_x + cover_width / 2)
if sample_point_x < width and sample_above_y >= 0:
    bg_pixel = img.getpixel((sample_point_x, sample_above_y))
    bg_color = bg_pixel[:3]
    print(f"修正背景色：RGB{bg_color}")

# 步骤 1：用背景色覆盖"救助"二字
draw.rectangle(
    [cover_x, cover_y - text_height * 0.1, cover_x + cover_width, cover_y + text_height * 1.05],
    fill=bg_color
)

# 步骤 2：写入"帮扶"二字
# 原文字颜色是深蓝色
text_color = (35, 55, 95)  # 深蓝色，匹配原文字

# 微调位置使新文字居中对齐
text_adjust_x = cover_x - avg_char_width * 0.05
draw.text((text_adjust_x, cover_y), "帮扶", font=font, fill=text_color)

# 保存输出文件
img.save(output_path, quality=95)
print(f"\n✅ 修改完成！")
print(f"输出文件：{output_path}")
print(f"修改内容：'救助' → '帮扶'")

# 显示修改摘要
print(f"\n修改摘要:")
print(f"  原文字：职工困难救助管理系统")
print(f"  新文字：职工困难帮扶管理系统")
print(f"  修改位置：第 5-6 个字符")
print(f"  字体大小：{font_size}px")
print(f"  背景色：RGB{bg_color}")
print(f"  文字色：RGB{text_color}")
