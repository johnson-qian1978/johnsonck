# 长江 CMS 启动脚本
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  长江 CMS 系统启动中..." -ForegroundColor Cyan
Write-Host "========================================"
Write-Host ""

Set-Location E:\CJCMS

Write-Host "[1/3] 停止旧的 Java 进程..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -eq "java"} | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "[2/3] 开始编译..." -ForegroundColor Yellow
Write-Host ""

& "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" clean compile

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ 编译失败！请检查上面的错误信息。" -ForegroundColor Red
    Write-Host ""
    Write-Host "按任意键退出..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "[3/3] ✅ 编译成功！正在启动应用..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  应用启动日志（实时监控）"
Write-Host "========================================"
Write-Host ""

& "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" spring-boot:run

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  应用已停止"
Write-Host "========================================"
Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
