@echo off
if exist "C:\jk\disk-monitor-log.csv" (
    start notepad "C:\jk\disk-monitor-log.csv"
) else (
    echo Log file not found. Run install-disk-monitor.bat first.
)
pause