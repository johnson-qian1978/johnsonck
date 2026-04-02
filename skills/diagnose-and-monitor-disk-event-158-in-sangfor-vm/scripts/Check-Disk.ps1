$disks = Get-PhysicalDisk | Where-Object {$_.BusType -eq "SCSI"}
$report = @()
foreach ($disk in $disks) {
    $perf = Get-Counter -Counter "\PhysicalDisk($($disk.DeviceId))\Avg. Disk sec/Read", 
                            "\PhysicalDisk($($disk.DeviceId))\Avg. Disk sec/Write",
                            "\PhysicalDisk($($disk.DeviceId))\Current Disk Queue Length" -ErrorAction SilentlyContinue
    if ($perf) {
        $readLatency = ($perf.CounterSamples[0].CookedValue * 1000)
        $writeLatency = ($perf.CounterSamples[1].CookedValue * 1000)
        $queue = $perf.CounterSamples[2].CookedValue
        $status = if ($readLatency -gt 50 -or $writeLatency -gt 50 -or $queue -gt 10) { "ALERT" } else { "OK" }
        $report += [PSCustomObject]@{
            Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Disk = "$($disk.DeviceId) $($disk.FriendlyName)"
            QueueLength = [math]::Round($queue, 1)
            AvgReadMs = [math]::Round($readLatency, 1)
            AvgWriteMs = [math]::Round($writeLatency, 1)
            Status = $status
        }
    }
}
$report | ConvertTo-Html -Title "Disk Diagnostic Report" | Out-File "C:\jk\disk-report.html"