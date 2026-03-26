@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

set LOGFILE=%~dp0error.log

REM 清空旧日志
echo ======================================== > %LOGFILE%
echo 启动日志 - %date% %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%
echo. >> %LOGFILE%

echo [信息] 启动 Windows 系统信息查看工具... >> %LOGFILE%
echo.

REM 检查 EXE 是否存在
if not exist "SystemInfoViewer.exe" (
    echo [错误] 未找到 SystemInfoViewer.exe >> %LOGFILE%
    echo 错误：未找到 SystemInfoViewer.exe
    echo 请确保 EXE 文件在同一目录下
    goto :error
)

echo [信息] 找到 SystemInfoViewer.exe >> %LOGFILE%
echo [信息] 开始运行... >> %LOGFILE%
echo.

REM 运行 EXE
SystemInfoViewer.exe

if %errorlevel% neq 0 (
    echo. >> %LOGFILE%
    echo [错误] 程序运行失败，错误代码：%errorlevel% >> %LOGFILE%
    echo [错误] 时间：%date% %time% >> %LOGFILE%
    echo.
    echo 程序运行失败！
    echo 错误已记录到：error.log
    echo.
    echo 按任意键查看错误日志...
    pause >nul
    notepad %LOGFILE%
) else (
    echo. >> %LOGFILE%
    echo [信息] 程序运行成功 >> %LOGFILE%
    echo [信息] 完成时间：%date% %time% >> %LOGFILE%
)

:error
echo.
pause
