@echo off
schtasks /create /tn "DiskMonitor" /tr "powershell.exe -ExecutionPolicy Bypass -File C:\jk\Monitor-Disk.ps1" /sc minute /mo 5 /f
echo Disk monitor installed as scheduled task 'DiskMonitor' (runs every 5 minutes)
pause