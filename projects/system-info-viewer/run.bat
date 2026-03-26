@echo off
chcp 65001 >nul
cd /d "%~dp0"

REM 记录日志
set LOGFILE=%~dp0error.log
echo ======================================== > %LOGFILE%
echo 错误日志 - %date% %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%

echo 正在启动系统信息查看工具...
echo 日志文件：%LOGFILE%

REM 检查 Python 是否安装
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未找到 Python，请先安装 Python 3.8+ >> %LOGFILE%
    echo 错误：未找到 Python，请先安装 Python 3.8+
    pause
    exit /b 1
)

echo [信息] Python 路径：>> %LOGFILE%
where python >> %LOGFILE% 2>&1

REM 运行程序
echo [信息] 正在运行 system_info_viewer.py... >> %LOGFILE%
python system_info_viewer.py >> %LOGFILE% 2>&1

if %errorlevel% neq 0 (
    echo [错误] 程序运行失败，请查看日志文件：%LOGFILE%
    echo 程序运行失败，错误已记录到 error.log
) else (
    echo [信息] 程序运行成功 >> %LOGFILE%
)

echo.
pause
