# 每日记忆同步脚本
# 用途：从 MemOS 获取对话记忆并保存到本地 memory 目录

param(
    [int]$DaysBack = 7,
    [string]$OutputDir = "C:\Users\27151\.openclaw\workspace\memory"
)

$ErrorActionPreference = "Stop"

# 配置
$MEMOS_API_KEY = "mpg-gsojtYqkBAFpdw/FFacWWi4c5SYbhFHcC/llGs80"
$MEMOS_BASE_URL = "https://memos.memtensor.cn/api/openmem/v1"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "📌 每日 MemOS 记忆同步" -ForegroundColor Cyan
Write-Host "========================================"
Write-Host "开始时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "同步范围：过去 $DaysBack 天"
Write-Host "输出目录：$OutputDir"
Write-Host ""

# 确保输出目录存在
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    Write-Host "✓ 创建记忆目录：$OutputDir"
}

# 搜索关键词列表
$SearchQueries = @(
    "system_info_gui",
    "control-ui",
    "OpenClaw Control UI",
    "CJCMS",
    "长江 CMS",
    "GH_BMD",
    "项目进度",
    "BUG 修复",
    "用户偏好",
    "系统配置"
)

$AllMemories = @()

foreach ($query in $SearchQueries) {
    Write-Host "🔍 搜索：$query"
    
    try {
        $body = @{
            text = $query
            tags = @("openclaw")
            limit = 20
        } | ConvertTo-Json -Depth 3
        
        $headers = @{
            "Content-Type" = "application/json"
            "Authorization" = "Token $MEMOS_API_KEY"
        }
        
        $response = Invoke-RestMethod -Uri "$MEMOS_BASE_URL/search/memory" -Method POST -Headers $headers -Body $body
        
        if ($response.data -and $response.data.memory_detail_list) {
            $count = $response.data.memory_detail_list.Count
            Write-Host "  ✓ 找到 $count 条记忆" -ForegroundColor Green
            
            foreach ($memory in $response.data.memory_detail_list) {
                $AllMemories += [PSCustomObject]@{
                    Time = $memory.create_time
                    Value = $memory.memory_value
                    Query = $query
                }
            }
        }
    } catch {
        Write-Host "  ✗ 搜索失败：$($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "📊 同步结果汇总" -ForegroundColor Cyan
Write-Host "========================================"
Write-Host "总共获取记忆数：$($AllMemories.Count)"

if ($AllMemories.Count -gt 0) {
    # 按日期分组保存
    $grouped = $AllMemories | Group-Object { [DateTime]::FromUnixTimeMilliseconds($_.Time).ToString('yyyy-MM-dd') }
    
    foreach ($group in $grouped) {
        $date = $group.Name
        $filePath = Join-Path $OutputDir "$date-memos.md"
        
        Write-Host "`n📁 保存文件：$filePath"
        
        $content = @"
# $date - MemOS 同步记忆

**同步时间:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  
**来源:** MemOS Cloud  
**记忆数量:** $($group.Group.Count)

---

"@
        
        foreach ($item in $group.Group | Sort-Object Time -Descending) {
            $time = [DateTime]::FromUnixTimeMilliseconds($item.Time).ToString('HH:mm')
            $content += "## [$time] `$($item.Query)`

$($item.Value)

---

"
        }
        
        Set-Content -Path $filePath -Value $content -Encoding UTF8
        Write-Host "  ✓ 保存成功 ($($group.Group.Count) 条)" -ForegroundColor Green
    }
    
    # 显示最新记忆
    Write-Host "`n📋 最新 5 条记忆:" -ForegroundColor Yellow
    $AllMemories | Sort-Object Time -Descending | Select-Object -First 5 | Format-Table Time, Value -AutoSize
} else {
    Write-Host "⚠️  未找到任何记忆" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "同步完成！" -ForegroundColor Green
Write-Host "结束时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "========================================"
