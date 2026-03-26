@echo off
chcp 65001 >nul
echo ========================================
echo 设置 JDK 26 环境变量
echo ========================================
echo.

REM 设置系统环境变量（需要管理员权限）
setx JAVA_HOME "D:\Program Files\Java\jdk-26" /M
setx PATH "%PATH%;D:\Program Files\Java\jdk-26\bin" /M

echo [成功] 环境变量已设置！
echo.
echo JAVA_HOME = D:\Program Files\Java\jdk-26
echo.
echo 注意：环境变量设置后，需要重新打开命令行窗口才能生效。
echo.
pause
