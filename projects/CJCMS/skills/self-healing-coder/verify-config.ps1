# Self-Healing Coder 配置验证器
# 用于检查技能配置是否安全

param(
    [string]$ConfigPath = "E:\CJCMS\skills\self-healing-coder\SKILL.md"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Self-Healing Coder 配置验证" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$config = Get-Content $ConfigPath -Raw

# 检查关键安全配置
$checks = @{
    "最大重试次数" = ($config -match 'max_retries:\s*([5-9]|10|[1-5][0-9])' -and $config -match 'max_retries:\s*(10|15)')
    "熔断机制启用" = ($config -match 'circuit_breaker:' -and $config -match 'enabled:\s*true')
    "修复范围限制" = ($config -match 'scope_limits:' -and $config -match 'max_files_per_fix:')
    "禁止危险操作" = ($config -match 'forbidden_operations:' -and $config -match 'delete_file')
    "人工确认节点" = ($config -match 'manual_confirmation:')
    "资源限制" = ($config -match 'resource_limits:')
    "Git 保护" = ($config -match 'git_protection:')
    "文件白名单" = ($config -match 'allowed_paths:')
}

$allPassed = $true

foreach ($check in $checks.GetEnumerator()) {
    $status = if ($check.Value) { "✅ 通过" } else { "❌ 失败" }
    $color = if ($check.Value) { "Green" } else { "Red" }
    
    Write-Host "$($check.Key): " -NoNewline
    Write-Host $status -ForegroundColor $color
    
    if (-not $check.Value) {
        $allPassed = $false
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

if ($allPassed) {
    Write-Host "✅ 所有安全检查通过！" -ForegroundColor Green
    Write-Host "可以安全使用 Self-Healing Coder 技能" -ForegroundColor Green
} else {
    Write-Host "❌ 部分安全检查未通过" -ForegroundColor Red
    Write-Host "请检查 SKILL.md 配置文件" -ForegroundColor Yellow
    Write-Host "建议：不要使用该技能直到所有检查通过" -ForegroundColor Yellow
}

Write-Host "========================================" -ForegroundColor Cyan

return $allPassed
