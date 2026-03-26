# 长江 CMS 启动脚本 - 详细日志版
$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  长江 CMS 系统启动中..." -ForegroundColor Cyan
Write-Host "========================================"
Write-Host ""

Set-Location E:\CJCMS

Write-Host "[1/4] 停止旧的 Java 进程..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -eq "java"} | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "[2/4] 检查 Maven 是否存在..." -ForegroundColor Yellow
$mavenPath = "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd"
if (-not (Test-Path $mavenPath)) {
    Write-Host "❌ Maven 不存在：$mavenPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "按任意键退出..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
Write-Host "✅ Maven 路径正确" -ForegroundColor Green

Write-Host "[3/4] 开始编译..." -ForegroundColor Yellow
Write-Host ""

& $mavenPath clean compile

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ 编译失败！错误代码：$LASTEXITCODE" -ForegroundColor Red
    Write-Host ""
    Write-Host "按任意键退出..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "[4/4] ✅ 编译成功！正在启动应用..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  应用启动日志（实时监控）"
Write-Host "========================================"
Write-Host ""
Write-Host "提示：如果启动失败，错误信息会显示在下方" -ForegroundColor Yellow
Write-Host "      成功后请勿关闭此窗口，应用需要它运行" -ForegroundColor Yellow
Write-Host ""

& $mavenPath spring-boot:run

$exitCode = $LASTEXITCODE

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  应用已停止 (退出代码：$exitCode)"
Write-Host "========================================"
Write-Host ""

if ($exitCode -ne 0) {
    Write-Host "❌ 应用启动失败！退出代码：$exitCode" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因：" -ForegroundColor Yellow
    Write-Host "  1. 端口 8080 被占用" -ForegroundColor Yellow
    Write-Host "  2. 配置文件错误" -ForegroundColor Yellow
    Write-Host "  3. 缺少必要的依赖" -ForegroundColor Yellow
    Write-Host "  4. 数据库连接失败" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "✅ 应用正常停止" -ForegroundColor Green
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
