@echo off
chcp 65001 >nul
cd /d "%~dp0"

REM 记录日志
set LOGFILE=%~dp0error.log
echo ======================================== > %LOGFILE%
echo 错误日志 - %date% %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%

echo 正在启动图形界面版本...
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

REM 检查 PyQt5 是否安装
python -c "import PyQt5" >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未安装 PyQt5，正在尝试安装... >> %LOGFILE%
    echo 正在安装 PyQt5...
    pip install PyQt5 >> %LOGFILE% 2>&1
    if %errorlevel% neq 0 (
        echo [错误] PyQt5 安装失败 >> %LOGFILE%
        echo 错误：PyQt5 安装失败，请手动运行：pip install PyQt5
        pause
        exit /b 1
    )
    echo [信息] PyQt5 安装成功 >> %LOGFILE%
)

REM 运行 GUI 程序
echo [信息] 正在运行 system_info_viewer_gui.py... >> %LOGFILE%
python system_info_viewer_gui.py >> %LOGFILE% 2>&1

if %errorlevel% neq 0 (
    echo [错误] 程序运行失败，请查看日志文件：%LOGFILE%
    echo 程序运行失败，错误已记录到 error.log
) else (
    echo [信息] 程序运行成功 >> %LOGFILE%
)

echo.
pause
