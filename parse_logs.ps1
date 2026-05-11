# 解析服务器事件日志 - 只输出关键信息
$logDir31 = "E:\工作目录\D\work\项目资料\武汉市医疗互助管理系统\2026\日志\31\Logs"
$logDir34 = "E:\工作目录\D\work\项目资料\武汉市医疗互助管理系统\2026\日志\34\logs"

$logs = @(
    @{Server="31"; Path="$logDir31\System.evtx"}
    @{Server="31"; Path="$logDir31\Application.evtx"}
    @{Server="34"; Path="$logDir34\System.evtx"}
    @{Server="34"; Path="$logDir34\Application.evtx"}
)

foreach ($log in $logs) {
    Write-Host "=== Server $($log.Server) - $($log.Path | Split-Path -Leaf) ==="
    try {
        $events = Get-WinEvent -Path $log.Path -FilterXPath "*[System[Level=1 or Level=2]]" -Oldest -MaxEvents 200
        foreach ($e in $events) {
            $msg = $e.Message
            if ($msg.Length -gt 250) { $msg = $msg.Substring(0,250) + "..." }
            Write-Host "$($e.TimeCreated) | $($e.LevelDisplayName) | ID:$($e.Id) | $($e.ProviderName) | $msg"
        }
        Write-Host "Total: $($events.Count)"
    } catch {
        Write-Host "Error: $_"
        try {
            $events = Get-WinEvent -Path $log.Path -Oldest -MaxEvents 200 | Where-Object { $_.Level -le 2 }
            foreach ($e in $events) {
                $msg = $e.Message
                if ($msg.Length -gt 250) { $msg = $msg.Substring(0,250) + "..." }
                Write-Host "$($e.TimeCreated) | $($e.LevelDisplayName) | ID:$($e.Id) | $($e.ProviderName) | $msg"
            }
            Write-Host "Total: $($events.Count)"
        } catch {
            Write-Host "Cannot read: $_"
        }
    }
    Write-Host ""
}
