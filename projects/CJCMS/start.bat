@echo off
chcp 65001 >nul
echo ========================================
echo   长江 CMS 系统启动脚本
echo ========================================
echo.

cd /d %~dp0

echo 正在启动 Spring Boot 应用...
echo.

mvn spring-boot:run

pause
