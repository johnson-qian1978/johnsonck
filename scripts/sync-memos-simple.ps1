# 每日记忆同步脚本 - 简化版
param(
    [int]$DaysBack = 7,
    [string]$OutputDir = "C:\Users\27151\.openclaw\workspace\memory"
)

Write-Host "=== MemOS Memory Sync ==="
Write-Host "Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "Days: $DaysBack"
Write-Host ""

# Ensure output directory exists
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# API config
$API_KEY = "mpg-gsojtYqkBAFpdw/FFacWWi4c5SYbhFHcC/llGs80"
$BASE_URL = "https://memos.memtensor.cn/api/openmem/v1"

# Search queries
$queries = @("system_info_gui", "CJCMS", "BUG", "project")

$totalMemories = 0

foreach ($q in $queries) {
    Write-Host "Searching: $q"
    try {
        $body = @{ text = $q; tags = @("openclaw"); limit = 10 } | ConvertTo-Json
        $headers = @{ "Content-Type" = "application/json"; "Authorization" = "Token $API_KEY" }
        $result = Invoke-RestMethod -Uri "$BASE_URL/search/memory" -Method POST -Headers $headers -Body $body
        
        if ($result.data -and $result.data.memory_detail_list) {
            $count = $result.data.memory_detail_list.Count
            Write-Host "  Found: $count" -ForegroundColor Green
            $totalMemories += $count
            
            # Display first 3
            $result.data.memory_detail_list | Select-Object -First 3 | ForEach-Object {
                $time = [DateTime]::FromUnixTimeMilliseconds($_.create_time).ToString('MM-dd HH:mm')
                Write-Host "  [$time] $($_.memory_value.Substring(0,[Math]::Min(60,$_.memory_value.Length)))..."
            }
        }
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== Summary ==="
Write-Host "Total memories: $totalMemories"
Write-Host "Completed: $(Get-Date -Format 'HH:mm:ss')"
