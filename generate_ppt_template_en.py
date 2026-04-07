# -*- coding: utf-8 -*-
"""
使用模板生成 PPT - 湖北联通热线运营汇报
纯英文路径版本
"""

import win32com.client as win32
import os

TEMPLATE = r"E:\temp_template.pptx"
OUTPUT = r"E:\AI 生成\OP\首问办结提升专项报告 - 套用模板版.pptx"

os.makedirs(os.path.dirname(OUTPUT), exist_ok=True)

print("正在启动 PowerPoint...")
ppt = win32.DispatchEx('PowerPoint.Application')
ppt.Visible = True

try:
    print(f"打开模板：{TEMPLATE}")
    pres = ppt.Presentations.Open(TEMPLATE)
    
    print(f"模板布局数量：{pres.SlideMaster.CustomLayouts.Count}")
    
    # 删除所有现有幻灯片
    for i in range(pres.Slides.Count, 0, -1):
        pres.Slides(i).Delete()
    
    print("添加新幻灯片...")
    
    # 第 1 页：封面
    slide1 = pres.Slides.Add(1, 1)
    slide1.Shapes.Title.TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好"
    slide1.Shapes.Placeholders(2).TextFrame.TextRange.Text = "聚焦"首问办结"提升人员在线解决能力\n湖北联通热线运营中心\n2026 年 4 月"
    
    # 第 2 页：目录
    slide2 = pres.Slides.Add(2, 2)
    slide2.Shapes.Title.TextFrame.TextRange.Text = "目录"
    content2 = slide2.Shapes.Placeholders(2).TextFrame.TextRange
    content2.Text = "01 问题背景与挑战\r02 三阶段推进策略\r03 三大核心举措\r04 制度保障\r05 成效与展望"
    
    # 第 3 页：问题背景
    slide3 = pres.Slides.Add(3, 2)
    slide3.Shapes.Title.TextFrame.TextRange.Text = "1. 问题背景与挑战"
    content3 = slide3.Shapes.Placeholders(2).TextFrame.TextRange
    content3.Text = "核心问题：\r• 新员工大批量入职 - 回迁初期人员快速扩充\r• 技能水平偏低 - 业务能力不足，首问解决率低\r• 接续辅导少 - 缺乏一对一指导\r• 提单率高 - 问题升级到上级部门\r\r解决思路：以"首问办结"为核心牵引，结合话务场景特点，动态优化流程规范"
    
    # 第 4 页：第一阶段
    slide4 = pres.Slides.Add(4, 2)
    slide4.Shapes.Title.TextFrame.TextRange.Text = "2.1 第一阶段（10-11 月）- 回迁初期"
    content4 = slide4.Shapes.Placeholders(2).TextFrame.TextRange
    content4.Text = "核心关注：新员工技能摸底，首问解决率低位运行\r\r联动举措：\r• 开展新员工技能摸底评估 → 发现问题清单\r• 清理场景发现问题 → 建立问题台账\r• 建立首问解决率监测机制 → 每日跟踪"
    
    # 第 5 页：第二阶段
    slide5 = pres.Slides.Add(5, 2)
    slide5.Shapes.Title.TextFrame.TextRange.Text = "2.2 第二阶段（12-2 月）- 专项攻坚"
    content5 = slide5.Shapes.Placeholders(2).TextFrame.TextRange
    content5.Text = "核心关注：聚焦账期/话费/合约等痛点，专项攻坚\r\r联动举措：\r• 聚焦月头月底账期查询痛点 → 专项研究处理流程\r• 话费疑问处理规范优化 → 减少升级工单\r• 合约续办流程简化 → 提升在线办结率"
    
    # 第 6 页：第三阶段
    slide6 = pres.Slides.Add(6, 2)
    slide6.Shapes.Title.TextFrame.TextRange.Text = "2.3 第三阶段（3 月至今）- 成效显现"
    content6 = slide6.Shapes.Placeholders(2).TextFrame.TextRange
    content6.Text = "核心关注：全面赋权 + 脚本优化，成效显现\r\r联动举措：\r• 省分全面赋权在线办理 → 合约续办、套餐变更、权益流量包\r• 清理解释脚本优化 → 流量争议、话费争议、停机场景\r• 员工快速赋能提升 → 首问解决率显著提升"
    
    # 第 7 页：举措一
    slide7 = pres.Slides.Add(7, 2)
    slide7.Shapes.Title.TextFrame.TextRange.Text = "3.1 健全绩效体系"
    content7 = slide7.Shapes.Placeholders(2).TextFrame.TextRange
    content7.Text = "• 将在线解决能力纳入考核评价体系 → 激发员工主动性\r• 薪酬牵引，激发员工提升技能的内生动力 → 形成良性竞争\r• 萃取优秀案例，定期组织全员学习演练 → 经验快速复制\r• 推动服务经验快速复制 → 整体能力提升"
    
    # 第 8 页：举措二
    slide8 = pres.Slides.Add(8, 2)
    slide8.Shapes.Title.TextFrame.TextRange.Text = "3.2 梳理重难点业务"
    content8 = slide8.Shapes.Placeholders(2).TextFrame.TextRange
    content8.Text = "• 月头月底账期查询 → 专项研究，优化处理流程\r• 话费疑问 → 简化解释脚本，明确处理规范\r• 合约续办 → 省分赋权，在线办理\r• 套餐变更/权益流量包 → 提升在线办结率"
    
    # 第 9 页：举措三
    slide9 = pres.Slides.Add(9, 2)
    slide9.Shapes.Title.TextFrame.TextRange.Text = "3.3 强化质量监督"
    content9 = slide9.Shapes.Placeholders(2).TextFrame.TextRange
    content9.Text = "• 质检深入一线 → "接续指导 + 面对面沟通"\r• 重点人员辅导 → "一对一"靶向辅导\r• 脚本优化 → 流量争议、话费争议、停机等场景\r• 沟通技巧提升 → 优化沟通技巧与处理思路"
    
    # 第 10 页：制度保障
    slide10 = pres.Slides.Add(10, 2)
    slide10.Shapes.Title.TextFrame.TextRange.Text = "4. 制度保障"
    content10 = slide10.Shapes.Placeholders(2).TextFrame.TextRange
    content10.Text = "建立两项核心制度：\r\r《（湖北）工单在线解释处理原则》\r• 明确工单处理标准\r• 规范在线解释流程\r• 减少工单升级\r\r《客服人员服务质量考核管理办法》\r• 将首问解决率纳入考核\r• 建立质量评价机制\r• 激励员工提升技能"
    
    # 第 11 页：成效与展望
    slide11 = pres.Slides.Add(11, 2)
    slide11.Shapes.Title.TextFrame.TextRange.Text = "5. 成效与展望"
    content11 = slide11.Shapes.Placeholders(2).TextFrame.TextRange
    content11.Text = "阶段性成效：\r✅ 首问解决率显著提升\r✅ 提单率明显下降\r✅ 员工业务能力快速提升\r✅ 客户满意度提高\r\r下一步计划：\r📌 持续优化场景脚本\r📌 扩大赋权范围\r📌 深化绩效牵引\r📌 建立长效机制"
    
    # 第 12 页：结束页
    slide12 = pres.Slides.Add(12, 1)
    slide12.Shapes.Title.TextFrame.TextRange.Text = "谢谢聆听"
    slide12.Shapes.Placeholders(2).TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好\n湖北联通热线运营中心\n2026 年 4 月"
    
    print(f"保存到：{OUTPUT}")
    pres.SaveAs(OUTPUT)
    print(f"✅ PPT 生成成功！共 {pres.Slides.Count} 页")
    
except Exception as e:
    print(f"❌ 错误：{e}")
    import traceback
    traceback.print_exc()
    raise
finally:
    try:
        pres.Close()
        ppt.Quit()
    except:
        pass
    print("完成！")
