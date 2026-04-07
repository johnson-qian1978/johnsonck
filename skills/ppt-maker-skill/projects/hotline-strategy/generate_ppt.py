# -*- coding: utf-8 -*-
import win32com.client as win32
import os

TEMPLATE = r"E:\xwechat_files\wxid_mdr454piydvj21_ff6f\msg\file\2026-04\集团发言---坚持问题靶向发力 助推热线运营长效向好 - 副本.pptx"
OUTPUT = r"E:\AI 生成\OP\热线运营汇报 - 首问办结.pptx"

os.makedirs(os.path.dirname(OUTPUT), exist_ok=True)
print("Starting PowerPoint...")
ppt = win32.DispatchEx("PowerPoint.Application")
ppt.Visible = True

try:
    if os.path.exists(TEMPLATE):
        print(f"Opening template: {TEMPLATE}")
        pres = ppt.Presentations.Open(TEMPLATE)
    else:
        print("Creating new presentation")
        pres = ppt.Presentations.Add()
    
    slide = pres.Slides.Add(1, 1)
    
    # Title
    title = slide.Shapes.Title
    title.TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好"
    title.TextFrame.TextRange.Font.Size = 28
    title.TextFrame.TextRange.Font.Bold = True
    
    # Subtitle
    subtitle = slide.Shapes.Placeholders(2)
    subtitle.TextFrame.TextRange.Text = "聚焦首问办结 提升人员在线解决能力"
    subtitle.TextFrame.TextRange.Font.Size = 16
    
    # Time axis (left)
    time_axis = slide.Shapes.AddShape(1, 50, 150, 250, 300)
    time_axis.TextFrame.TextRange.Text = "Time Axis\n\nPhase 1 (Oct-Nov)\nPhase 2 (Dec-Feb)\nPhase 3 (Mar-Present)"
    time_axis.TextFrame.TextRange.Font.Size = 12
    time_axis.Fill.ForeColor.RGB = 0xFF6B6B
    
    # Matrix (right)
    matrix = slide.Shapes.AddShape(1, 320, 150, 400, 300)
    matrix.TextFrame.TextRange.Text = "Strategy Matrix\n\nPerformance | Business | Quality"
    matrix.TextFrame.TextRange.Font.Size = 11
    
    # Footer
    footer = slide.Shapes.AddShape(1, 50, 460, 670, 80)
    footer.TextFrame.TextRange.Text = "Policy Support\nTwo regulations established"
    footer.TextFrame.TextRange.Font.Size = 12
    footer.Fill.ForeColor.RGB = 0x4472C4
    footer.TextFrame.TextRange.Font.Color.RGB = 0xFFFFFF
    
    print(f"Saving to: {OUTPUT}")
    pres.SaveAs(OUTPUT)
    print("SUCCESS!")
    
except Exception as e:
    print(f"ERROR: {e}")
    raise
finally:
    try:
        pres.Close()
        ppt.Quit()
    except:
        pass
    import gc
    gc.collect()
    print("Done!")
