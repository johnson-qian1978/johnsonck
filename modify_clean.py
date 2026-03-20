# -*- coding: utf-8 -*-
"""
修改原始图片：将"救助"改为"帮扶"
使用纯色填充确保干净
"""

from PIL import Image, ImageDraw, ImageFont

input_path = r"E:\工作目录\D\work\项目资料\武汉市总工会\2026\6726a5d4-fd8b-4be7-8a9f-1bcf0db92925.png"
output_path = r"C:\Users\27151\.openclaw\workspace\工会系统_帮扶版_最终版.png"

img = Image.open(input_path).convert('RGB')
width, height = img.size
draw = ImageDraw.Draw(img)

# 加载字体
font = ImageFont.truetype("C:/Windows/Fonts/msyhbd.ttc", 16)

# 精确坐标（根据原图 584x179 测量）
# "职工困难救助管理系统" - "救助"是第 5-6 个字
# 第二行起始位置：x=305, y=105
# 每个字约 16px 宽，间距约 1px

subtitle_start_x = 305
subtitle_y = 105
char_width = 16
char_spacing = 1

# "救助"二字的位置（第 5-6 个字）
target_x = subtitle_start_x + 4 * (char_width + char_spacing)
target_y = subtitle_y

# 从"救助"上方采样背景色
bg_color = img.getpixel((target_x + 15, target_y - 12))
print(f"采样背景色：RGB{bg_color}")

# 用背景色完全覆盖"救助"二字（稍微大一点确保完全覆盖）
draw.rectangle(
    [target_x - 1, target_y - 2, target_x + char_width * 2 + 2, target_y + 18],
    fill=bg_color
)

# 写入"帮扶"
text_color = (25, 45, 95)
draw.text((target_x, target_y), "帮扶", font=font, fill=text_color)

# 保存
img.save(output_path, format='PNG')
print(f"[OK] 修改完成：{output_path}")
