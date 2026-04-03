# 检查 Disk Event 158 日志（用于诊断服务器死机问题）
# 需要管理员权限运行

Write-Host "[信息] 正在检查 Event ID 158（磁盘事件）..." -ForegroundColor Cyan

$events = Get-WinEvent -LogName System | Where-Object { $_.Id -eq 158 } | Format-List *

if ($events) {
    Write-Host "[发现] 检测到 Event ID 158 事件：" -ForegroundColor Yellow
    $events
} else {
    Write-Host "[未发现] 未找到 Event ID 158 事件。" -ForegroundColor Green
}

Write-Host "" 
Write-Host "[提示] Event ID 158 通常表示磁盘短暂丢失或重新枚举，可能由存储层不稳定引起。" -ForegroundColor Magenta
Write-Host "       若频繁出现，请检查：" -ForegroundColor Magenta
Write-Host "       - 存储设备固件版本" -ForegroundColor Magenta
Write-Host "       - 存储协议（建议 NVMe-oF 替代 iSCSI）" -ForegroundColor Magenta
Write-Host "       - 磁盘健康状态（使用 chkdsk /f /r）" -ForegroundColor Magenta
