# 查询物理内存信息（用于识别 OEM 内存型号）
# 解决 Windows 显示 "Unknown" 的问题

Write-Host "[信息] 查询物理内存信息..." -ForegroundColor Cyan
Write-Host ""

Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object PartNumber, Speed, Capacity, BankLabel, DeviceLocator | Format-Table -AutoSize

Write-Host ""
Write-Host "[提示] OEM 内存编码示例解析：" -ForegroundColor Yellow
Write-Host "  TDS5DSAG08-56TB46C → TDS=联想ThinkPlus, 56=DDR5-5600, 16=16GB" -ForegroundColor White
Write-Host "  若 PartNumber 为空，可结合联想电脑管家或 BIOS 信息交叉验证。" -ForegroundColor Gray
