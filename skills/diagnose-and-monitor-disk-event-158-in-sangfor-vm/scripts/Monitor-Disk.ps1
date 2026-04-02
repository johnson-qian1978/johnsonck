$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$cpu = (Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue
$mem = (Get-Counter "\Memory\% Committed Bytes In Use").CounterSamples.CookedValue
$diskPerf = Get-Counter "\PhysicalDisk(0 C:)\Current Disk Queue Length",
                      "\PhysicalDisk(0 C:)\Avg. Disk sec/Read",
                      "\PhysicalDisk(0 C:)\Avg. Disk sec/Write",
                      "\PhysicalDisk(0 C:)\Disk Read Bytes/sec",
                      "\PhysicalDisk(0 C:)\Disk Write Bytes/sec"
$queue = [math]::Round($diskPerf.CounterSamples[0].CookedValue, 1)
$readLatency = [math]::Round($diskPerf.CounterSamples[1].CookedValue * 1000, 1)
$writeLatency = [math]::Round($diskPerf.CounterSamples[2].CookedValue * 1000, 1)
$readBytes = [math]::Round($diskPerf.CounterSamples[3].CookedValue / 1MB, 2)
$writeBytes = [math]::Round($diskPerf.CounterSamples[4].CookedValue / 1MB, 2)
$status = if ($readLatency -gt 50 -or $writeLatency -gt 50 -or $queue -gt 10) { "ALERT" } else { "OK" }
$logEntry = "$timestamp,0 C:,$queue,$readLatency,$writeLatency,$readBytes,$writeBytes,$([math]::Round($cpu,1)),$([math]::Round($mem,1)),$status"
$logFile = "C:\jk\disk-monitor-log.csv"
if (!(Test-Path $logFile)) {
    "Time,Disk,QueueLength,AvgReadMs,AvgWriteMs,ReadMBps,WriteMBps,CPU%,Memory%,Status" | Out-File $logFile -Encoding UTF8
}
$logEntry | Out-File $logFile -Append -Encoding UTF8
if ($status -eq "ALERT") {
    $alertFile = "C:\jk\disk-alert-log.txt"
    "$timestamp - ALERT: High disk latency or queue length detected" | Out-File $alertFile -Append -Encoding UTF8
}