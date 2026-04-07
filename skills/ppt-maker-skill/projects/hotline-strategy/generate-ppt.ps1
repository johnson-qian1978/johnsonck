# PowerPoint COM PPT Generator - 湖北联通热线运营汇报

param(
    [string]$templatePath = "E:\xwechat_files\wxid_mdr454piydvj21_ff6f\msg\file\2026-04\集团发言---坚持问题靶向发力 助推热线运营长效向好 - 副本.pptx",
    [string]$outputPath = "E:\AI 生成\OP\热线运营汇报 - 首问办结.pptx"
)

# 创建 PowerPoint 应用
$powerpoint = New-Object -ComObject PowerPoint.Application
$powerpoint.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue

# 检查模板文件是否存在
if (Test-Path $templatePath) {
    Write-Host "Opening template: $templatePath"
    $presentation = $powerpoint.Presentations.Open($templatePath)
} else {
    Write-Host "Template not found, creating new presentation"
    $presentation = $powerpoint.Presentations.Add()
}

# 添加新幻灯片（使用第 1 个布局）
$slide = $presentation.Slides.Add(1, 1)  # ppLayoutTitle

# 设置标题
$titleShape = $slide.Shapes.Title
$titleShape.TextFrame.TextRange.Text = "坚持问题靶向发力 助推热线运营长效向好"
$titleShape.TextFrame.TextRange.Font.Size = 28
$titleShape.TextFrame.TextRange.Font.Bold = [Microsoft.Office.Core.MsoTriState]::msoTrue

# 设置副标题
$subtitleShape = $slide.Shapes.Placeholders(2)
$subtitleShape.TextFrame.TextRange.Text = "聚焦"新员工大批量入职、技能低、接续少、提单率高"的问题`r`n以"首问办结"为核心牵引，多措并举提升人员在线解决能力"
$subtitleShape.TextFrame.TextRange.Font.Size = 16

# 添加时间轴（左侧）
$left = 50
$top = 150
$width = 250
$height = 300

$timeAxis = $slide.Shapes.AddShape(
    [Microsoft.Office.Core.MsoAutoShapeType]::msoShapeRectangle,
    $left, $top, $width, $height
)
$timeAxis.TextFrame.TextRange.Text = "时间轴`r`n`r`n第一阶段 (10-11 月)`r`n回迁初期`r`n`r`n第二阶段 (12-2 月)`r`n专项攻坚`r`n`r`n第三阶段 (3 月至今)`r`n成效显现"
$timeAxis.TextFrame.TextRange.Font.Size = 12
$timeAxis.Fill.ForeColor.RGB = 0xFF6B6B  # 红色背景

# 添加策略矩阵（右侧）
$left = 320
$top = 150
$width = 400
$height = 300

$matrix = $slide.Shapes.AddShape(
    [Microsoft.Office.Core.MsoAutoShapeType]::msoShapeRectangle,
    $left, $top, $width, $height
)
$matrix.TextFrame.TextRange.Text = "策略矩阵`r`n`r`n健全绩效体系 | 梳理重难点业务 | 强化质量监督`r`n`r`n[详细内容见完整 PPT]"
$matrix.TextFrame.TextRange.Font.Size = 11

# 添加制度保障（底部）
$left = 50
$top = 460
$width = 670
$height = 80

$footer = $slide.Shapes.AddShape(
    [Microsoft.Office.Core.MsoAutoShapeType]::msoShapeRectangle,
    $left, $top, $width, $height
)
$footer.TextFrame.TextRange.Text = "制度保障`r`n• 建立《（湖北）工单在线解释处理原则》`r`n• 建立《客服人员服务质量考核管理办法》"
$footer.TextFrame.TextRange.Font.Size = 12
$footer.Fill.ForeColor.RGB = 0x4472C4  # 蓝色背景
$footer.TextFrame.TextRange.Font.Color.RGB = 0xFFFFFF  # 白色文字

# 保存文件
$presentation.SaveAs($outputPath)
Write-Host "PPT saved to: $outputPath"

# 关闭演示文稿
$presentation.Close()
$powerpoint.Quit()

# 释放 COM 对象
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($powerpoint) | Out-Null
Write-Host "Done!"
