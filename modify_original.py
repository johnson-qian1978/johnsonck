# -*- coding: utf-8 -*-
"""
修改原始图片：将"救助"改为"帮扶"
保持所有其他元素不变
"""

from PIL import Image, ImageDraw, ImageFont

# 原始图片路径
input_path = r"E:\工作目录\D\work\项目资料\武汉市总工会\2026\6726a5d4-fd8b-4be7-8a9f-1bcf0db92925.png"
output_path = r"C:\Users\27151\.openclaw\workspace\工会系统_帮扶版_最终.png"

# 打开原始图片
img = Image.open(input_path).convert('RGB')
width, height = img.size
print(f"原始图片尺寸：{width}x{height}")

# 创建绘图对象
draw = ImageDraw.Draw(img)

# 加载中文字体（微软雅黑 Bold）
font_paths = [
    "C:/Windows/Fonts/msyhbd.ttc",      # 微软雅黑 Bold
    "C:/Windows/Fonts/msyh.ttc",        # 微软雅黑
    "C:/Windows/Fonts/simhei.ttf",      # 黑体
]

# 估算字体大小（第二行文字约占图片高度的 8-9%）
font_size = int(height * 0.085)
font = None

for font_path in font_paths:
    try:
        font = ImageFont.truetype(font_path, font_size)
        print(f"使用字体：{font_path}, 大小：{font_size}px")
        break
    except:
        continue

if font is None:
    print("警告：使用默认字体")
    font = ImageFont.load_default()

# 目标："职工困难救助管理系统" -> "职工困难帮扶管理系统"
# 需要精确定位"救助"二字

# 先测试文字尺寸
test_text = "职工困难救助管理系统"
bbox = draw.textbbox((0, 0), test_text, font=font)
text_width = bbox[2] - bbox[0]
text_height = bbox[3] - bbox[1]
avg_char_width = text_width / len(test_text)

print(f"整行文字宽度：{text_width:.1f}px")
print(f"平均字符宽度：{avg_char_width:.1f}px")
print(f"文字高度：{text_height:.1f}px")

# 第二行文字的位置（从原图精确测量）
# 原图尺寸 584x179，第二行文字大约在 y=105px 处
second_line_y = int(height * 0.586)  # 约 105px

# 文字起始 X 坐标（从原图看，第二行从 x=305px 左右开始）
subtitle_start_x = int(width * 0.522)  # 约 305px

# "救助"是第 5-6 个字（索引 4-5）
target_index = 4  # "救"字的索引
char_spacing = avg_char_width * 0.05  # 字间距

# 计算"救助"二字的精确位置
cover_x = subtitle_start_x + target_index * (avg_char_width + char_spacing)
cover_y = second_line_y

# 覆盖区域（"救助"两个字）
cover_width = avg_char_width * 2.15  # 稍微宽一点确保完全覆盖
cover_height = text_height * 1.2

print(f"\n修改区域:")
print(f"  X: {cover_x:.0f} - {cover_x + cover_width:.0f}")
print(f"  Y: {cover_y - text_height*0.1:.0f} - {cover_y + text_height*1.1:.0f}")

# 从"救助"文字正上方采样背景色（最准确）
sample_x = int(cover_x + cover_width / 2)
sample_y = int(cover_y - text_height * 0.7)

if 0 <= sample_x < width and 0 <= sample_y < height:
    bg_color = img.getpixel((sample_x, sample_y))
    print(f"采样背景色：RGB{bg_color}")
else:
    # 备用：从附近区域采样
    bg_color = img.getpixel((int(cover_x), int(cover_y - 10)))
    print(f"备用背景色：RGB{bg_color}")

# 步骤 1：用背景色完全覆盖"救助"二字
draw.rectangle(
    [cover_x, cover_y - text_height * 0.1, cover_x + cover_width, cover_y + text_height * 1.1],
    fill=bg_color
)

# 步骤 2：写入"帮扶"二字
# 原文字颜色是深蓝色
text_color = (25, 45, 95)  # 深蓝色

# 写入"帮扶"二字，位置微调使其与周围文字完美对齐
text_x = cover_x  # 不偏移，直接覆盖
text_y = cover_y - text_height * 0.05  # 微调垂直位置
draw.text((text_x, text_y), "帮扶", font=font, fill=text_color)

# 保存输出文件（高质量 PNG）
img.save(output_path, format='PNG')

print(f"\n[OK] 修改完成！")
print(f"输出文件：{output_path}")
print(f"\n修改摘要:")
print(f"  原文字：职工困难救助管理系统")
print(f"  新文字：职工困难帮扶管理系统")
print(f"  修改位置：第 5-6 个字符 ('救助' -> '帮扶')")
print(f"  字体：微软雅黑 Bold, {font_size}px")
print(f"  背景色：RGB{bg_color}")
print(f"  文字色：RGB{text_color}")
