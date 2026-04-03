@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 此脚本需要管理员权限运行！
    echo 请右键点击脚本 -> "以管理员身份运行"
    pause
    exit /b 1
)

echo [信息] 开始禁用开机启动项...
echo.

:: 删除注册表启动项（无需管理员权限）
echo [步骤1] 删除注册表启动项...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "cesvc" /f 2>nul && echo ✅ 已删除：cesvc (360浏览器助手)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_003C2D238EA337939507FA5AC2DEC310" /f 2>nul && echo ✅ 已删除：MicrosoftEdgeAutoLaunch

:: 禁用任务计划程序项（需管理员权限）
echo.
echo [步骤2] 禁用任务计划程序项...

schtasks /Change /TN "360ZipUpdaterLoop" /Disable 2>nul && echo ✅ 已禁用：360ZipUpdaterLoop
schtasks /Change /TN "AdobeAAMUpdater-1.0-MicrosoftAccount-27151114@qq.com" /Disable 2>nul && echo ✅ 已禁用：AdobeAAMUpdater
schtasks /Change /TN "WpsUpdateLogonTask_27151" /Disable 2>nul && echo ✅ 已禁用：WpsUpdateLogonTask_27151
schtasks /Change /TN "WpsUpdateTask_27151" /Disable 2>nul && echo ✅ 已禁用：WpsUpdateTask_27151
schtasks /Change /TN "WpsWakeWnsLogonTask" /Disable 2>nul && echo ✅ 已禁用：WpsWakeWnsLogonTask
schtasks /Change /TN "QuarkUpdaterTaskUser1.0.0.21{F9AA8F57-9907-4044-A611-1D67C77FCB7E}" /Disable 2>nul && echo ✅ 已禁用：QuarkUpdaterTask

echo.
echo [完成] 所有操作执行完毕！
echo 建议：重启电脑使更改生效。
pause
