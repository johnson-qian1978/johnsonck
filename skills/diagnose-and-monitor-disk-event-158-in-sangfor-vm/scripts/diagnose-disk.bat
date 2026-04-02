@echo off
powershell.exe -ExecutionPolicy Bypass -File "C:\jk\Check-Disk.ps1"
echo Disk diagnostic report generated at C:\jk\disk-report.html
pause