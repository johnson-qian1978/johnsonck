@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

if exist "error.log" (
    notepad error.log
) else (
    echo 错误日志文件不存在！
    echo.
    echo 只有当程序运行出错时才会生成 error.log 文件
    echo.
    pause
)
