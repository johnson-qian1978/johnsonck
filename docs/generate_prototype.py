"""
OpenClaw Web UI Prototype - PNG Generator
使用 Pillow 绘制参考 WorkBuddy 风格的界面原型图
"""

from PIL import Image, ImageDraw, ImageFont
import os

# 配置参数
WIDTH = 1400
HEIGHT = 900
OUTPUT_PATH = r"C:\Users\27151\.openclaw\workspace\docs\openclaw-web-ui-prototype.png"

# 颜色定义
COLORS = {
    'bg': '#f5f7fa',           # 背景灰
    'white': '#ffffff',        # 白色
    'primary': '#1677ff',      # 科技蓝
    'success': '#52c41a',      # 成功绿
    'warning': '#faad14',      # 警告黄
    'error': '#ff4d4f',        # 错误红
    'text_main': '#1f1f1f',    # 主文字
    'text_secondary': '#666666',  # 次要文字
    'text_hint': '#999999',    # 提示文字
    'border': '#e8e8e8',       # 边框
    'user_bubble': '#e6f4ff',  # 用户气泡
    'step_success_bg': '#f6ffed',
    'step_success_border': '#b7eb8f',
    'step_process_bg': '#e6f4ff',
    'step_process_border': '#91d5ff',
}

# 布局配置
LAYOUT = {
    'top_bar_height': 60,
    'left_sidebar_width': 240,
    'right_panel_width': 280,
    'bottom_input_height': 180,
}

def get_font(size, bold=False):
    """获取字体（优先使用中文字体）"""
    font_paths = [
        f"C:\\Windows\\Fonts\\msyh.ttc",  # 微软雅黑
        f"C:\\Windows\\Fonts\\simsun.ttc",  # 宋体
        f"C:\\Windows\\Fonts\\simhei.ttf",  # 黑体
    ]
    for path in font_paths:
        if os.path.exists(path):
            try:
                return ImageFont.truetype(path, size)
            except:
                continue
    # 回退到默认字体
    return ImageFont.load_default()

def draw_rounded_rectangle(draw, bbox, radius, fill, outline=None, width=1):
    """绘制圆角矩形"""
    x1, y1, x2, y2 = bbox
    draw.rounded_rectangle(bbox, radius=radius, fill=fill, outline=outline, width=width)

def draw_shadow(draw, bbox, shadow_color='#00000020', offset=3, blur=5):
    """绘制阴影效果"""
    x1, y1, x2, y2 = bbox
    # 简化版本：直接绘制半透明矩形
    shadow_bbox = (x1+offset, y1+offset, x2+offset, y2+offset)
    draw.rounded_rectangle(shadow_bbox, radius=8, fill=shadow_color)

def main():
    # 创建画布
    img = Image.new('RGB', (WIDTH, HEIGHT), COLORS['bg'])
    draw = ImageDraw.Draw(img)
    
    # 获取字体
    font_logo = get_font(20, bold=True)
    font_title = get_font(16, bold=True)
    font_normal = get_font(14)
    font_small = get_font(13)
    font_tiny = get_font(11)
    font_bold = get_font(13, bold=True)
    
    # ==================== 1. 顶部栏 ====================
    top_bar_height = LAYOUT['top_bar_height']
    draw.rectangle([0, 0, WIDTH, top_bar_height], fill=COLORS['white'])
    draw.line([(0, top_bar_height), (WIDTH, top_bar_height)], fill=COLORS['border'], width=1)
    
    # 全局搜索
    draw.text((30, 18), "🔍 全局搜索...", fill=COLORS['text_hint'], font=font_small)
    # 用户信息
    draw.text((WIDTH-200, 18), "🔔  👤 johnson-qian1978 ▼", fill=COLORS['text_secondary'], font=font_small)
    
    # ==================== 2. 左侧导航栏 ====================
    left_width = LAYOUT['left_sidebar_width']
    draw.rectangle([0, top_bar_height, left_width, HEIGHT], fill=COLORS['white'])
    draw.line([(left_width, top_bar_height), (left_width, HEIGHT)], fill=COLORS['border'], width=1)
    
    # Logo
    draw.text((20, top_bar_height + 30), "🐾 OpenClaw", fill=COLORS['primary'], font=font_logo)
    
    # 搜索框
    search_y = top_bar_height + 60
    draw.rounded_rectangle([20, search_y, 220, search_y + 36], radius=18, fill=COLORS['bg'])
    draw.text((35, search_y + 8), "🔍 搜索任务、会话...", fill=COLORS['text_hint'], font=font_small)
    
    # 分隔线
    draw.line([(20, top_bar_height + 120), (220, top_bar_height + 120)], fill=COLORS['border'], width=1)
    
    # 菜单项
    menu_items = [
        ("🆕 新建任务", top_bar_height + 150),
        ("🔧 Claw", top_bar_height + 180),
        ("👥 专家", top_bar_height + 210),
        ("🎯 技能", top_bar_height + 240),
        ("🧩 插件", top_bar_height + 270),
        ("⚙️ 自动化", top_bar_height + 300),
    ]
    
    for text, y in menu_items:
        draw.text((20, y), text, fill=COLORS['text_main'], font=font_normal)
    
    # 分隔线
    draw.line([(20, top_bar_height + 340), (220, top_bar_height + 340)], fill=COLORS['border'], width=1)
    
    # 会话列表
    sessions = [
        ("📝 Web UI 设计文档", "12:45 PM · ✅ 完成", top_bar_height + 370),
        ("🔧 修复 WebSocket 连接", "11:52 AM · ⏸️ 等待中", top_bar_height + 410),
        ("📊 竞品调研报告", "昨天 · ✅ 完成", top_bar_height + 450),
    ]
    
    for title, time, y in sessions:
        draw.text((20, y), title, fill=COLORS['text_main'], font=font_small)
        draw.text((35, y + 20), time, fill=COLORS['text_hint'], font=font_tiny)
    
    # ==================== 3. 中间主内容区 ====================
    main_left = left_width
    main_right = WIDTH - LAYOUT['right_panel_width']
    
    # 对话区域背景
    draw.rectangle([main_left, top_bar_height, main_right, HEIGHT - LAYOUT['bottom_input_height']], fill='#fafafa')
    
    # 用户消息（右侧蓝色气泡）
    user_msg_x = main_left + 660
    user_msg_y = top_bar_height + 60
    draw.text((user_msg_x - 60, user_msg_y - 20), "用户", fill=COLORS['text_secondary'], font=font_tiny)
    draw.rounded_rectangle([user_msg_x, user_msg_y, user_msg_x + 140, user_msg_y + 50], 
                          radius=12, fill=COLORS['user_bubble'], outline=COLORS['primary'])
    draw.text((user_msg_x + 10, user_msg_y + 12), "仿照 WorkBuddy", fill=COLORS['text_main'], font=font_small)
    draw.text((user_msg_x + 10, user_msg_y + 30), "设计新界面", fill=COLORS['text_main'], font=font_small)
    
    # AI 回复容器
    ai_msg_x = main_left + 40
    ai_msg_y = top_bar_height + 140
    draw.text((ai_msg_x, ai_msg_y - 20), "OpenClaw", fill=COLORS['text_secondary'], font=font_tiny)
    
    # AI 消息背景卡片
    card_width = 500
    card_height = 320
    draw.rounded_rectangle([ai_msg_x, ai_msg_y, ai_msg_x + card_width, ai_msg_y + card_height], 
                          radius=12, fill=COLORS['white'], outline=COLORS['border'])
    
    # 步骤卡片 1 - 已完成
    step1_y = ai_msg_y + 20
    draw.rounded_rectangle([ai_msg_x + 20, step1_y, ai_msg_x + card_width - 20, step1_y + 50], 
                          radius=8, fill=COLORS['step_success_bg'], outline=COLORS['step_success_border'])
    draw.text((ai_msg_x + 35, step1_y + 12), "✅", fill=COLORS['success'], font=font_normal)
    draw.text((ai_msg_x + 60, step1_y + 8), "读取设计文档", fill=COLORS['text_main'], font=font_bold)
    draw.text((ai_msg_x + 60, step1_y + 26), "docs/openclaw-web-ui-design.md · 5.1KB", fill=COLORS['text_secondary'], font=font_tiny)
    draw.text((ai_msg_x + card_width - 80, step1_y + 18), "0.3s", fill=COLORS['success'], font=font_tiny)
    
    # 连接线
    draw.line([(ai_msg_x + 250, step1_y + 55), (ai_msg_x + 250, step1_y + 65)], fill='#d9d9d9', width=1)
    
    # 步骤卡片 2 - 已完成
    step2_y = step1_y + 70
    draw.rounded_rectangle([ai_msg_x + 20, step2_y, ai_msg_x + card_width - 20, step2_y + 50], 
                          radius=8, fill=COLORS['step_success_bg'], outline=COLORS['step_success_border'])
    draw.text((ai_msg_x + 35, step2_y + 12), "✅", fill=COLORS['success'], font=font_normal)
    draw.text((ai_msg_x + 60, step2_y + 8), "分析 WorkBuddy 界面特点", fill=COLORS['text_main'], font=font_bold)
    draw.text((ai_msg_x + 60, step2_y + 26), "三栏布局、思考可视化、产物面板", fill=COLORS['text_secondary'], font=font_tiny)
    draw.text((ai_msg_x + card_width - 80, step2_y + 18), "1.2s", fill=COLORS['success'], font=font_tiny)
    
    # 连接线
    draw.line([(ai_msg_x + 250, step2_y + 55), (ai_msg_x + 250, step2_y + 65)], fill='#d9d9d9', width=1)
    
    # 步骤卡片 3 - 进行中
    step3_y = step2_y + 70
    draw.rounded_rectangle([ai_msg_x + 20, step3_y, ai_msg_x + card_width - 20, step3_y + 60], 
                          radius=8, fill=COLORS['step_process_bg'], outline=COLORS['step_process_border'], width=2)
    draw.text((ai_msg_x + 35, step3_y + 12), "🔄", fill=COLORS['primary'], font=font_normal)
    draw.text((ai_msg_x + 60, step3_y + 8), "生成 Excalidraw 原型图", fill=COLORS['text_main'], font=font_bold)
    draw.text((ai_msg_x + 60, step3_y + 26), "绘制高保真界面布局...", fill=COLORS['text_secondary'], font=font_tiny)
    # 进度条
    draw.rounded_rectangle([ai_msg_x + 60, step3_y + 42, ai_msg_x + 260, step3_y + 48], radius=3, fill='#bae7ff')
    draw.rounded_rectangle([ai_msg_x + 60, step3_y + 42, ai_msg_x + 200, step3_y + 48], radius=3, fill=COLORS['primary'])
    draw.text((ai_msg_x + card_width - 100, step3_y + 18), "进行中...", fill=COLORS['primary'], font=font_tiny)
    
    # AI 总结文字
    summary_y = ai_msg_y + card_height + 20
    draw.multiline_text((ai_msg_x, summary_y), 
                       "**找到设计灵感了！**参考 WorkBuddy 的三栏布局，\n我已经为你创建了完整的设计文档 📄", 
                       fill=COLORS['text_main'], font=font_small, spacing=5)
    
    # ==================== 4. 底部输入区 ====================
    bottom_y = HEIGHT - LAYOUT['bottom_input_height']
    draw.rectangle([main_left, bottom_y, main_right, HEIGHT], fill=COLORS['white'])
    draw.rounded_rectangle([main_left + 20, bottom_y + 20, main_right - 20, bottom_y + 160], 
                          radius=12, fill=COLORS['white'], outline=COLORS['border'])
    
    # 输入框
    input_y = bottom_y + 40
    draw.rounded_rectangle([main_left + 40, input_y, main_right - 40, input_y + 80], 
                          radius=8, fill=COLORS['bg'], outline=COLORS['border'])
    draw.text((main_left + 55, input_y + 25), "输入消息或命令... (支持 @提及、#标签)", fill=COLORS['text_hint'], font=font_small)
    
    # 模式切换按钮
    mode_y = bottom_y + 140
    # Craft
    draw.rounded_rectangle([main_left + 40, mode_y, main_left + 110, mode_y + 28], radius=6, fill='#f0f0f0', outline=COLORS['border'])
    draw.text((main_left + 50, mode_y + 6), "Craft", fill=COLORS['text_secondary'], font=font_small)
    # Auto (激活)
    draw.rounded_rectangle([main_left + 120, mode_y, main_left + 190, mode_y + 28], radius=6, fill=COLORS['primary'], outline=COLORS['primary'])
    draw.text((main_left + 130, mode_y + 6), "Auto", fill=COLORS['white'], font=font_small)
    # Skills
    draw.rounded_rectangle([main_left + 200, mode_y, main_left + 270, mode_y + 28], radius=6, fill='#f0f0f0', outline=COLORS['border'])
    draw.text((main_left + 208, mode_y + 6), "Skills", fill=COLORS['text_secondary'], font=font_small)
    
    # 附件按钮
    draw.text((main_left + 300, mode_y + 6), "📎 上传文件", fill=COLORS['text_secondary'], font=font_small)
    draw.text((main_left + 400, mode_y + 6), "📷 截图", fill=COLORS['text_secondary'], font=font_small)
    
    # 发送按钮
    send_x = main_right - 120
    draw.rounded_rectangle([send_x, mode_y, send_x + 80, mode_y + 36], radius=8, fill=COLORS['primary'])
    draw.text((send_x + 15, mode_y + 8), "发送", fill=COLORS['white'], font=font_bold)
    draw.text((send_x + 15, mode_y + 28), "Ctrl+Enter", fill=COLORS['text_hint'], font=font_tiny)
    
    # ==================== 5. 右侧面板 ====================
    right_x = main_right
    draw.rectangle([right_x, top_bar_height, WIDTH, HEIGHT], fill=COLORS['white'])
    draw.line([(right_x, top_bar_height), (WIDTH, top_bar_height)], fill=COLORS['border'], width=1)
    
    # 产物面板标题
    panel_title_y = top_bar_height + 40
    draw.text((right_x + 20, panel_title_y), "📦 产物面板", fill=COLORS['text_main'], font=font_title)
    
    # Tab 页签
    tab_y = top_bar_height + 70
    tabs = [
        ("产物", right_x + 20, True),
        ("全部", right_x + 90, False),
        ("变更", right_x + 160, False),
        ("预览", right_x + 230, False),
    ]
    
    for text, x, active in tabs:
        if active:
            draw.rounded_rectangle([x, tab_y, x + 60, tab_y + 32], radius=6, fill=COLORS['user_bubble'], outline=COLORS['primary'], width=2)
            draw.text((x + 10, tab_y + 8), text, fill=COLORS['primary'], font=font_bold)
        else:
            draw.rounded_rectangle([x, tab_y, x + 60, tab_y + 32], radius=6, fill='#f5f5f5', outline=COLORS['border'])
            draw.text((x + 15, tab_y + 8), text, fill=COLORS['text_secondary'], font=font_small)
    
    # 文件列表项 1
    file1_y = top_bar_height + 130
    draw.rounded_rectangle([right_x + 20, file1_y, right_x + 260, file1_y + 50], radius=8, fill=COLORS['white'], outline=COLORS['border'])
    draw.text((right_x + 35, file1_y + 15), "📄", fill=COLORS['primary'], font=font_normal)
    draw.text((right_x + 60, file1_y + 12), "openclaw-web-ui-design.md", fill=COLORS['text_main'], font=font_small)
    draw.text((right_x + 60, file1_y + 30), "5.1 KB · 刚刚", fill=COLORS['text_hint'], font=font_tiny)
    draw.text((right_x + 220, file1_y + 18), "👁️ 📋 📤", fill=COLORS['text_secondary'], font=font_small)
    
    # 分隔线
    draw.line([(right_x + 20, file1_y + 90), (right_x + 260, file1_y + 90)], fill='#f0f0f0', width=1)
    
    # 预览窗口
    preview_y = top_bar_height + 190
    draw.rounded_rectangle([right_x + 20, preview_y, right_x + 260, preview_y + 200], radius=8, fill=COLORS['bg'], outline=COLORS['border'])
    draw.text((right_x + 35, preview_y + 15), "📊 数据报表预览", fill=COLORS['text_main'], font=font_bold)
    
    # 图表区域
    chart_x = right_x + 35
    chart_y = preview_y + 40
    chart_w = 230
    chart_h = 120
    draw.rounded_rectangle([chart_x, chart_y, chart_x + chart_w, chart_y + chart_h], radius=6, fill=COLORS['white'], outline=COLORS['border'])
    
    # 绘制折线图
    chart_points = [
        (chart_x + 15, chart_y + 90),
        (chart_x + 65, chart_y + 60),
        (chart_x + 115, chart_y + 75),
        (chart_x + 165, chart_y + 40),
        (chart_x + 215, chart_y + 55),
    ]
    draw.line(chart_points, fill=COLORS['primary'], width=2)
    
    # 预览操作按钮
    draw.text((right_x + 35, preview_y + 175), "📥 下载  🔗 分享  🖥️ 全屏", fill=COLORS['text_secondary'], font=font_tiny)
    
    # 分隔线
    draw.line([(right_x + 20, preview_y + 220), (right_x + 260, preview_y + 220)], fill=COLORS['border'], width=1)
    
    # 任务清单标题
    task_title_y = preview_y + 240
    draw.text((right_x + 20, task_title_y), "✅ 任务清单", fill=COLORS['text_main'], font=font_normal)
    
    # 任务项 1 - 已完成
    task1_y = task_title_y + 20
    draw.rounded_rectangle([right_x + 20, task1_y, right_x + 260, task1_y + 36], radius=6, fill=COLORS['white'], outline=COLORS['border'])
    draw.rounded_rectangle([right_x + 35, task1_y + 10, right_x + 51, task1_y + 26], radius=4, fill=COLORS['success'])
    draw.text((right_x + 39, task1_y + 12), "✓", fill=COLORS['white'], font=font_tiny)
    draw.text((right_x + 60, task1_y + 12), "完成设计文档", fill=COLORS['text_hint'], font=font_small)
    # 删除线效果（用灰色文字覆盖）
    draw.line([(right_x + 60, task1_y + 20), (right_x + 150, task1_y + 20)], fill=COLORS['text_hint'], width=1)
    
    # 任务项 2 - 进行中（中优先级）
    task2_y = task1_y + 45
    draw.rounded_rectangle([right_x + 20, task2_y, right_x + 260, task2_y + 36], radius=6, fill=COLORS['white'], outline=COLORS['border'])
    draw.rounded_rectangle([right_x + 35, task2_y + 10, right_x + 51, task2_y + 26], radius=4, fill=COLORS['white'], outline=COLORS['border'])
    draw.text((right_x + 60, task2_y + 12), "搭建项目脚手架", fill=COLORS['text_main'], font=font_small)
    draw.ellipse([(right_x + 230, task2_y + 14), (right_x + 238, task2_y + 22)], fill=COLORS['warning'])
    
    # 任务项 3 - 未开始（高优先级）
    task3_y = task2_y + 45
    draw.rounded_rectangle([right_x + 20, task3_y, right_x + 260, task3_y + 36], radius=6, fill=COLORS['white'], outline=COLORS['border'])
    draw.rounded_rectangle([right_x + 35, task3_y + 10, right_x + 51, task3_y + 26], radius=4, fill=COLORS['white'], outline=COLORS['border'])
    draw.text((right_x + 60, task3_y + 12), "实现核心组件", fill=COLORS['text_main'], font=font_small)
    draw.ellipse([(right_x + 230, task3_y + 14), (right_x + 238, task3_y + 22)], fill=COLORS['error'])
    
    # 进度统计
    progress_y = task3_y + 50
    draw.text((right_x + 20, progress_y), "进度：1/3 已完成 (33%)", fill=COLORS['text_secondary'], font=font_tiny)
    
    # 进度条背景
    draw.rounded_rectangle([right_x + 20, progress_y + 15, right_x + 260, progress_y + 23], radius=4, fill='#f5f5f5')
    # 进度条填充（33%）
    draw.rounded_rectangle([right_x + 20, progress_y + 15, right_x + 107, progress_y + 23], radius=4, fill=COLORS['success'])
    
    # 保存文件
    img.save(OUTPUT_PATH, 'PNG', dpi=(300, 300))
    file_size = os.path.getsize(OUTPUT_PATH) / 1024
    print(f"PNG prototype image generated: {OUTPUT_PATH}")
    print(f"Size: {WIDTH}x{HEIGHT}px")
    print(f"File size: {file_size:.1f} KB")

if __name__ == "__main__":
    main()
