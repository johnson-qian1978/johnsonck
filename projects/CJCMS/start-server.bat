@echo off
chcp 65001 >nul
title 长江 CMS 启动日志

echo ========================================
echo   长江 CMS 系统启动中...
echo ========================================
echo.

cd /d E:\CJCMS

echo [%time%] 停止旧的 Java 进程...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [%time%] 开始编译...
call "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" clean compile

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ 编译失败！请检查上面的错误信息。
    echo.
    pause
    exit /b 1
)

echo.
echo [%time%] ✅ 编译成功！
echo [%time%] 正在启动应用...
echo.
echo ========================================
echo   应用启动日志（实时监控）
echo ========================================
echo.

call "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" spring-boot:run

echo.
echo ========================================
echo   应用已停止
echo ========================================
echo.
pause
