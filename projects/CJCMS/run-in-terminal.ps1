# CJCMS 自动启动脚本 (PowerShell)
# 在 Trae CN 终端中执行此脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "CJCMS 项目自动启动 (JDK 26 + Oracle)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 设置环境变量
Write-Host "[1/5] 设置 JDK 26 环境变量..." -ForegroundColor Yellow
$env:JAVA_HOME = "D:\Program Files\Java\jdk-26"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
Write-Host "  ✓ JAVA_HOME = $env:JAVA_HOME" -ForegroundColor Green
Write-Host ""

# 2. 验证 Java
Write-Host "[2/5] 验证 Java 环境..." -ForegroundColor Yellow
try {
    $javaVersion = & "$env:JAVA_HOME\bin\java.exe" -version 2>&1 | Select-String "version" | Select-Object -First 1
    Write-Host "  ✓ $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Java 未找到！请检查安装路径。" -ForegroundColor Red
    pause
    exit 1
}
Write-Host ""

# 3. 验证 Maven
Write-Host "[3/5] 检查 Maven 环境..." -ForegroundColor Yellow
try {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven" | Select-Object -First 1
    if ($mavenVersion) {
        Write-Host "  ✓ $mavenVersion" -ForegroundColor Green
        $useMaven = $true
    } else {
        Write-Host "  ⚠ Maven 未安装，将尝试使用 Maven Wrapper" -ForegroundColor Yellow
        $useMaven = $false
    }
} catch {
    Write-Host "  ⚠ Maven 未找到" -ForegroundColor Yellow
    $useMaven = $false
}
Write-Host ""

# 4. 编译项目
if ($useMaven) {
    Write-Host "[4/5] 编译项目..." -ForegroundColor Yellow
    try {
        mvn clean compile -q
        Write-Host "  ✓ 编译成功" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ 编译失败" -ForegroundColor Red
        pause
        exit 1
    }
} else {
    Write-Host "[4/5] 跳过编译（无 Maven）" -ForegroundColor Yellow
}
Write-Host ""

# 5. 启动项目
Write-Host "[5/5] 启动 Spring Boot 项目..." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在启动 CJCMS..." -ForegroundColor Green
Write-Host "访问地址：http://localhost:8080/login.html" -ForegroundColor Cyan
Write-Host "按 Ctrl+C 停止服务" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($useMaven) {
    mvn spring-boot:run
} else {
    Write-Host "错误：需要 Maven 才能运行项目" -ForegroundColor Red
    Write-Host "请安装 Maven 或使用 start-jdk26.bat 脚本" -ForegroundColor Yellow
    pause
}
