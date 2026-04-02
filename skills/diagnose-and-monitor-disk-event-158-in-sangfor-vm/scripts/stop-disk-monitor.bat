@echo off
schtasks /delete /tn "DiskMonitor" /f
echo Disk monitor task stopped and removed.
pause