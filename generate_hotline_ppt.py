# -*- coding: utf-8 -*-
"""
湖北联通热线运营汇报 PPT 生成器
使用 PowerPoint COM 接口生成完整企业汇报 PPT
"""

import win32com.client as win32
import os

OUTPUT_PATH = r"E:\AI 生成\OP\热线运营汇报 - 首问办结 - 完整版.pptx"

# 确保输出目录存在
os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)

print("正在启动 PowerPoint...")
ppt = win32.DispatchEx('PowerPoint.Application')
ppt.Visible = True

try:
    print("创建新演示文稿...")
    pres = ppt.Presentations.Add()
    
    # 定义颜色
    RED = 0xFF6B6B      # 联通红
    BLUE = 0x4472C4     # 商务蓝
    DARK = 0x333333     # 深灰
    WHITE = 0xFFFFFF    # 白色
    
    slide_num = 0
    
    # ========== 第 1 页：封面 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：封面")
    slide = pres.Slides.Add(slide_num, 12)  # ppLayoutTitleOnly
    
    # 标题
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好"
    title.TextFrame.TextRange.Font.Size = 32
    title.TextFrame.TextRange.Font.Bold = True
    title.TextFrame.TextRange.Font.Color.RGB = RED
    title.Top = 100
    
    # 副标题
    subtitle = slide.Shapes.AddTextbox(1, 100, 200, 500, 100)
    subtitle.TextFrame.TextRange.Text = "聚焦"首问办结"提升人员在线解决能力\n\n工作汇报 - 2026 年 4 月"
    subtitle.TextFrame.TextRange.Font.Size = 18
    subtitle.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # 装饰条
    bar = slide.Shapes.AddShape(1, 0, 500, 720, 20)
    bar.Fill.ForeColor.RGB = RED
    
    # ========== 第 2 页：目录 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：目录")
    slide = pres.Slides.Add(slide_num, 12)
    
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "目录"
    title.TextFrame.TextRange.Font.Size = 28
    title.TextFrame.TextRange.Font.Color.RGB = BLUE
    
    contents = [
        "01 问题背景与挑战",
        "02 三阶段推进策略",
        "03 三大核心举措",
        "04 制度保障",
        "05 成效与展望"
    ]
    
    for i, content in enumerate(contents):
        text = slide.Shapes.AddTextbox(1, 100, 150 + i * 80, 500, 60)
        text.TextFrame.TextRange.Text = content
        text.TextFrame.TextRange.Font.Size = 20
        text.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # ========== 第 3 页：问题背景 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：问题背景")
    slide = pres.Slides.Add(slide_num, 12)
    
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "1. 问题背景与挑战"
    title.TextFrame.TextRange.Font.Size = 24
    title.TextFrame.TextRange.Font.Color.RGB = BLUE
    
    problems = [
        "新员工大批量入职 - 回迁初期人员快速扩充",
        "技能水平偏低 - 业务能力不足，首问解决率低",
        "接续辅导少 - 缺乏一对一指导",
        "提单率高 - 问题升级到上级部门"
    ]
    
    for i, problem in enumerate(problems):
        text = slide.Shapes.AddTextbox(1, 100, 150 + i * 70, 550, 60)
        text.TextFrame.TextRange.Text = f"• {problem}"
        text.TextFrame.TextRange.Font.Size = 18
        text.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # 解决思路框
    solution = slide.Shapes.AddShape(1, 100, 430, 550, 80)
    solution.TextFrame.TextRange.Text = "解决思路：以"首问办结"为核心牵引，结合话务场景特点，动态优化流程规范，多措并举提升人员在线解决能力"
    solution.TextFrame.TextRange.Font.Size = 14
    solution.Fill.ForeColor.RGB = BLUE
    solution.TextFrame.TextRange.Font.Color.RGB = WHITE
    
    # ========== 第 4-6 页：三阶段策略 ==========
    phases = [
        ("2.1 第一阶段（10-11 月）- 回迁初期", 
         ["核心关注：新员工技能摸底，首问解决率低位运行", "", "联动举措：", "• 开展新员工技能摸底评估 → 发现问题清单", "• 清理场景发现问题 → 建立问题台账", "• 建立首问解决率监测机制 → 每日跟踪"]),
        
        ("2.2 第二阶段（12-2 月）- 专项攻坚",
         ["核心关注：聚焦账期/话费/合约等痛点，专项攻坚", "", "联动举措：", "• 聚焦月头月底账期查询痛点 → 专项研究", "• 话费疑问处理规范优化 → 减少升级工单", "• 合约续办流程简化 → 提升在线办结率"]),
        
        ("2.3 第三阶段（3 月至今）- 成效显现",
         ["核心关注：全面赋权 + 脚本优化，成效显现", "", "联动举措：", "• 省分全面赋权在线办理", "• 清理解释脚本优化", "• 员工快速赋能提升"])
    ]
    
    for phase_title, phase_content in phases:
        slide_num += 1
        print(f"创建第{slide_num}页：{phase_title}")
        slide = pres.Slides.Add(slide_num, 12)
        
        title = slide.Shapes.Title
        title.TextFrame.TextRange.Text = phase_title
        title.TextFrame.TextRange.Font.Size = 22
        title.TextFrame.TextRange.Font.Color.RGB = BLUE
        
        for i, line in enumerate(phase_content):
            text = slide.Shapes.AddTextbox(1, 100, 130 + i * 60, 550, 50)
            text.TextFrame.TextRange.Text = line
            text.TextFrame.TextRange.Font.Size = 16
            text.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # ========== 第 7-9 页：三大举措 ==========
    measures = [
        ("3.1 健全绩效体系", [
            "将在线解决能力纳入考核评价体系 → 激发员工主动性",
            "薪酬牵引，激发员工提升技能的内生动力 → 形成良性竞争",
            "萃取优秀案例，定期组织全员学习演练 → 经验快速复制",
            "推动服务经验快速复制 → 整体能力提升"
        ]),
        ("3.2 梳理重难点业务", [
            "月头月底账期查询 → 专项研究处理流程",
            "话费疑问 → 简化解释脚本，明确处理规范",
            "合约续办 → 省分赋权，在线办理",
            "套餐变更/权益流量包 → 提升在线办结率"
        ]),
        ("3.3 强化质量监督", [
            "质检深入一线 → "接续指导 + 面对面沟通"",
            "重点人员辅导 → "一对一"靶向辅导",
            "脚本优化 → 流量争议、话费争议、停机场景",
            "沟通技巧提升 → 优化沟通技巧与处理思路"
        ])
    ]
    
    for measure_title, measure_content in measures:
        slide_num += 1
        print(f"创建第{slide_num}页：{measure_title}")
        slide = pres.Slides.Add(slide_num, 12)
        
        title = slide.Shapes.Title
        title.TextFrame.TextRange.Text = measure_title
        title.TextFrame.TextRange.Font.Size = 24
        title.TextFrame.TextRange.Font.Color.RGB = BLUE
        
        for i, line in enumerate(measure_content):
            text = slide.Shapes.AddTextbox(1, 100, 130 + i * 70, 550, 60)
            text.TextFrame.TextRange.Text = f"• {line}"
            text.TextFrame.TextRange.Font.Size = 16
            text.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # ========== 第 10 页：制度保障 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：制度保障")
    slide = pres.Slides.Add(slide_num, 12)
    
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "4. 制度保障"
    title.TextFrame.TextRange.Font.Size = 24
    title.TextFrame.TextRange.Font.Color.RGB = BLUE
    
    # 两个制度框
    box1 = slide.Shapes.AddShape(1, 100, 150, 550, 120)
    box1.TextFrame.TextRange.Text = "《（湖北）工单在线解释处理原则》\n\n• 明确工单处理标准\n• 规范在线解释流程\n• 减少工单升级"
    box1.TextFrame.TextRange.Font.Size = 16
    box1.Fill.ForeColor.RGB = BLUE
    box1.TextFrame.TextRange.Font.Color.RGB = WHITE
    
    box2 = slide.Shapes.AddShape(1, 100, 300, 550, 120)
    box2.TextFrame.TextRange.Text = "《客服人员服务质量考核管理办法》\n\n• 将首问解决率纳入考核\n• 建立质量评价机制\n• 激励员工提升技能"
    box2.TextFrame.TextRange.Font.Size = 16
    box2.Fill.ForeColor.RGB = RED
    box2.TextFrame.TextRange.Font.Color.RGB = WHITE
    
    # ========== 第 11 页：成效与展望 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：成效与展望")
    slide = pres.Slides.Add(slide_num, 12)
    
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "5. 成效与展望"
    title.TextFrame.TextRange.Font.Size = 24
    title.TextFrame.TextRange.Font.Color.RGB = BLUE
    
    # 成效
    achievements = slide.Shapes.AddTextbox(1, 100, 130, 550, 150)
    achievements.TextFrame.TextRange.Text = "阶段性成效：\n\n✅ 首问解决率显著提升\n✅ 提单率明显下降\n✅ 员工业务能力快速提升\n✅ 客户满意度提高"
    achievements.TextFrame.TextRange.Font.Size = 18
    achievements.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # 展望
    plans = slide.Shapes.AddTextbox(1, 100, 300, 550, 150)
    plans.TextFrame.TextRange.Text = "下一步计划：\n\n📌 持续优化场景脚本\n📌 扩大赋权范围\n📌 深化绩效牵引\n📌 建立长效机制"
    plans.TextFrame.TextRange.Font.Size = 18
    plans.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # ========== 第 12 页：结束页 ==========
    slide_num += 1
    print(f"创建第{slide_num}页：结束页")
    slide = pres.Slides.Add(slide_num, 12)
    
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "谢谢聆听"
    title.TextFrame.TextRange.Font.Size = 36
    title.TextFrame.TextRange.Font.Color.RGB = BLUE
    title.Top = 200
    
    subtitle = slide.Shapes.AddTextbox(1, 100, 300, 550, 60)
    subtitle.TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好"
    subtitle.TextFrame.TextRange.Font.Size = 20
    subtitle.TextFrame.TextRange.Font.Color.RGB = DARK
    
    # 保存
    print(f"保存 PPT 到：{OUTPUT_PATH}")
    pres.SaveAs(OUTPUT_PATH)
    print("✅ PPT 生成成功！")
    print(f"共生成 {slide_num} 页幻灯片")
    
except Exception as e:
    print(f"❌ 错误：{e}")
    import traceback
    traceback.print_exc()
    raise
finally:
    # 关闭
    try:
        pres.Close()
        ppt.Quit()
    except:
        pass
    
    print("完成！")
