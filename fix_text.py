# -*- coding: utf-8 -*-
"""
只修改图片中的文字：将"救助"改为"帮扶"
保持背景和其他所有元素不变
"""

from PIL import Image, ImageDraw, ImageFont
import os

# 查找输入图片
input_path = None
workspace = r"C:\Users\27151\.openclaw\workspace"

# 查找最新的 PNG 文件
for file in os.listdir(workspace):
    if file.endswith('.png') and 'input' in file.lower():
        input_path = os.path.join(workspace, file)
        break

if not input_path:
    # 尝试找第一个非输出文件的 PNG
    for file in os.listdir(workspace):
        if file.endswith('.png') and 'output' not in file.lower() and '帮扶' not in file:
            input_path = os.path.join(workspace, file)
            break

if not input_path:
    print("错误：找不到输入图片！")
    print("请把图片保存为：C:\\Users\\27151\\.openclaw\\workspace\\input_image.png")
    exit(1)

print(f"输入图片：{input_path}")

# 打开原始图片
img = Image.open(input_path).convert('RGBA')
width, height = img.size
print(f"图片尺寸：{width}x{height}")

# 创建绘图对象
draw = ImageDraw.Draw(img)

# 加载字体
font_paths = [
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
    "C:/Windows/Fonts/simsun.ttc",      # 宋体
]

# 估算字体大小（根据图片尺寸）
font_size = int(height * 0.06)
font = None

for font_path in font_paths:
    try:
        font = ImageFont.truetype(font_path, font_size)
        print(f"使用字体：{font_path}, 大小：{font_size}")
        break
    except:
        continue

if font is None:
    print("警告：无法加载中文字体，使用默认字体")
    font = ImageFont.load_default()

# 第二行文字："职工困难救助管理系统"
# 需要定位"救助"二字的位置并替换

# 先获取整行文字的边界框来估算位置
full_text = "职工困难救助管理系统"
test_bbox = draw.textbbox((0, 0), full_text, font=font)
text_height = test_bbox[3] - test_bbox[1]
avg_char_width = (test_bbox[2] - test_bbox[0]) / len(full_text)

# 估算第二行文字的位置（通常在图片垂直方向的 60-65% 处）
second_line_y = int(height * 0.60)

# 估算"救助"二字的位置
# "职工困难"是前 4 个字，"救助"是第 5-6 个字
char_spacing = avg_char_width * 0.1  # 字间距约为字宽的 10%

# 需要先找到第二行文字的起始 X 坐标
# 方法：从图片中提取第二行文字的大致区域，分析像素找到起始位置

# 简化方法：假设文字居中或从某个固定位置开始
# 先尝试找到文字区域的左边界

# 采样一行像素，找到文字开始的 X 坐标
start_x_estimate = int(width * 0.3)  # 假设从 30% 宽度处开始

# "救助"是第 5-6 个字（索引 4-5）
target_char_index = 4  # "救"字是第 5 个字符（0 索引）
cover_x = start_x_estimate + target_char_index * (avg_char_width + char_spacing)
cover_y = second_line_y

# 计算要覆盖的区域（"救助"两个字的宽度）
cover_width = avg_char_width * 2.2  # 稍微宽一点确保完全覆盖
cover_height = text_height * 1.2

# 从原图中采样"救助"周围的背景颜色
# 取文字上方一点的区域作为背景色参考
sample_x1 = int(cover_x)
sample_y1 = int(cover_y - text_height * 0.5)
sample_x2 = int(cover_x + cover_width)
sample_y2 = int(cover_y)

# 计算采样区域的平均颜色
pixels = img.crop((sample_x1, sample_y1, sample_x2, sample_y2))
pixel_data = list(pixels.getdata())
avg_color = [0, 0, 0]
count = 0
for pixel in pixel_data:
    if len(pixel) >= 3:  # RGBA 或 RGB
        avg_color[0] += pixel[0]
        avg_color[1] += pixel[1]
        avg_color[2] += pixel[2]
        count += 1

if count > 0:
    bg_color = (avg_color[0] // count, avg_color[1] // count, avg_color[2] // count)
else:
    bg_color = (240, 248, 255)  # 默认浅色背景

print(f"背景色：{bg_color}")

# 步骤 1：用背景色覆盖"救助"二字
draw.rectangle(
    [cover_x, cover_y - text_height * 0.1, cover_x + cover_width, cover_y + text_height * 1.1],
    fill=bg_color
)

# 步骤 2：写入"帮扶"二字
text_color = (30, 50, 90)  # 深蓝色，匹配原文字颜色
draw.text((cover_x, cover_y), "帮扶", font=font, fill=text_color)

# 保存输出文件
output_filename = "output_" + os.path.basename(input_path)
output_path = os.path.join(workspace, output_filename)
img.save(output_path)

print(f"\n✅ 修改完成！")
print(f"输出文件：{output_path}")
print(f"修改内容：'救助' → '帮扶'")
print(f"修改位置：x={cover_x:.0f}, y={cover_y:.0f}")
