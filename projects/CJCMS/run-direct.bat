@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo CJCMS Startup (JDK 26)
echo ========================================

set JAVA_HOME=D:\Program Files\Java\jdk-26
set PATH=%JAVA_HOME%\bin;%PATH%

cd /d %~dp0

echo Starting CJCMS...
echo.

java -cp "target/classes" com.cjcms.CjcmsApplication

pause
