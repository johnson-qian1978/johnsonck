---
name: "diagnose-and-monitor-disk-event-158-in-sangfor-vm"
description: "用于诊断和监控深信服（Sangfor）虚拟机中因 Disk Event 158（磁盘 GUID 冲突）导致的频繁死机问题。当用户提到服务器黑屏死机、意外重启、Windows 事件日志中的 Disk 158 或 Kernel-Power 41 错误、虚拟机克隆后异常、或需要部署磁盘 I/O 监控脚本时，应立即触发此技能。即使用户误称‘安装 KB2983588 补丁’，也应激活本技能——因为 KB2983588 实为知识库文章而非可安装补丁，真正解决方案需在虚拟化平台重置磁盘标识符。"
metadata: { "openclaw": { "emoji": "💾" } }
---

# 诊断并监控深信服虚拟机中的 Disk Event 158 问题

本技能帮助你准确识别由磁盘 GUID 冲突引发的间歇性死机，并部署轻量级磁盘性能监控方案，为联系深信服技术支持提供关键证据。

## 何时使用此技能
- 当深信服虚拟机出现无征兆黑屏死机，且 Windows 事件查看器中存在 **Disk Event 158** 和 **Kernel-Power 41** 错误组合。
- 用户误以为需“安装 KB2983588 补丁”，实则该编号仅为微软知识库文章（非可下载补丁），问题根源在虚拟化层。
- 需要替换原有的内存监控脚本，转而监控磁盘 I/O 性能（如队列长度、读写延迟），以捕获死机前的性能恶化趋势。
- 用户已排除内存问题（如已加内存），且无需与其他服务器对比，专注解决单一虚拟机的磁盘标识冲突。

## 步骤
1. **确认问题现象与日志**  
   检查 Windows 事件日志，确认多次死机均伴随 Disk 158（磁盘标识符重复）和 Kernel-Power 41（意外关机）。当前磁盘性能可能正常（如读取延迟 <1ms），但历史错误表明问题为间歇性。  
   *为什么重要：Disk 158 本身是警告，但在深信服虚拟化环境中可能被放大为致命故障，导致系统崩溃。*

2. **澄清 KB2983588 的真实性质**  
   明确 KB2983588 是微软知识库文章编号（https://learn.microsoft.com/zh-tw/troubleshoot/windows-client/backup-and-storage/event-id-158-for-identical-disk-guids），解释其内容为“虚拟机克隆后未重置磁盘 GUID”，而非可安装的补丁。Microsoft Update Catalog 中无法搜索到该补丁。  
   *为什么重要：避免用户浪费时间尝试无效的补丁安装，引导其聚焦虚拟化平台修复。*

3. **生成 HTML 诊断报告**  
   运行 `diagnose-disk.bat`，在 `C:\jk\disk-report.html` 生成包含系统配置（SANGFOR VM、双 SCSI 磁盘）、当前性能指标及历史错误摘要的报告。  
   *为什么重要：提供可视化证据，便于用户提交给深信服技术支持。*

4. **部署磁盘监控脚本（可选但推荐）**  
   以管理员身份运行 `install-disk-monitor.bat`，创建计划任务每 5 分钟执行 `Monitor-Disk.ps1`，记录磁盘队列长度、读写延迟等指标至 CSV 日志。  
   *为什么重要：虽无法记录死机瞬间，但可捕获死机前 5 分钟的性能恶化（如队列从 2 升至 15），补充事件日志缺失的量化数据。*

5. **准备深信服支持材料**  
   整理问题描述，明确请求：“在深信服虚拟化平台重置虚拟磁盘 GUID（类似 Hyper-V 的 `Set-VHD -ResetDiskIdentifier` 操作）”，并附上 HTML 报告和日志片段。  
   *为什么重要：深信服需在宿主机层面操作（如清理快照、调整磁盘为独立模式），客户机内无法解决。*

## 常见陷阱与解决方案
❌ 误将 KB2983588 当作可安装补丁 → 浪费时间搜索不存在的 .msu 文件 → ✅ 明确其为知识库文档，转向虚拟化平台修复。  
❌ 使用中文命名监控脚本文件 → 在部分系统触发 GBK 编码错误 → ✅ 所有脚本文件名和内容均使用纯英文（如 `diagnose-disk.bat`）。  
❌ 设置过高监控频率（如每分钟） → 增加不必要的 I/O 负载 → ✅ 采用 5 分钟间隔，在资源占用（CPU<0.5%）与数据捕获能力间取得平衡。  
❌ 仅依赖 Windows 事件日志 → 缺少死机前的性能数值趋势 → ✅ 部署监控脚本记录队列长度、延迟等量化指标，形成完整证据链。

## 关键代码与配置
`Check-Disk.ps1`（磁盘诊断脚本）：
```powershell
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
```

`Monitor-Disk.ps1`（定时监控脚本）：
```powershell
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
$readMBps = [math]::Round($diskPerf.CounterSamples[3].CookedValue / 1MB, 1)
$writeMBps = [math]::Round($diskPerf.CounterSamples[4].CookedValue / 1MB, 1)
$status = if ($readLatency -gt 50 -or $writeLatency -gt 50 -or $queue -gt 10) { "ALERT" } else { "OK" }

$logEntry = "$timestamp,0 C:,$queue,$readLatency,$writeLatency,$readMBps,$writeMBps,$([math]::Round($cpu,1)),$([math]::Round($mem,1)),$status"
Add-Content -Path "C:\jk\disk-monitor.log" -Value $logEntry
if ($status -eq "ALERT") { Add-Content -Path "C:\jk\disk-alert-log.txt" -Value $logEntry }
```

## 环境与前提条件
- **操作系统**：Windows Server 2016/2019/2022（深信服虚拟机）
- **虚拟化平台**：深信服 aCloud（使用 VirtIO SCSI 磁盘控制器）
- **权限要求**：部署监控脚本需本地管理员权限（用于创建计划任务）
- **依赖组件**：PowerShell 5.1+，Performance Counters 正常工作
- **磁盘配置**：至少一个 SCSI 类型物理磁盘（脚本默认监控 DeviceId 0）

## 配套文件
- `scripts/diagnose-disk.bat` — 一次性运行磁盘诊断并生成 HTML 报告
- `scripts/install-disk-monitor.bat` — 安装每 5 分钟执行的磁盘监控计划任务
- `scripts/stop-disk-monitor.bat` — 停止并删除磁盘监控计划任务
- `scripts/view-disk-log.bat` — 用记事本打开磁盘监控日志文件
- `scripts/Check-Disk.ps1` — PowerShell 磁盘诊断核心逻辑
- `scripts/Monitor-Disk.ps1` — PowerShell 定时监控与日志记录逻辑

## Companion files

- `scripts/Check-Disk.ps1` — automation script
- `scripts/Monitor-Disk.ps1` — automation script
- `scripts/diagnose-disk.bat` — automation script
- `scripts/install-disk-monitor.bat` — automation script
- `scripts/stop-disk-monitor.bat` — automation script
- `scripts/view-disk-log.bat` — automation script
- `references/kb2983588-clarification.md` — reference documentation
- `references/disk-monitoring-script-spec.md` — reference documentation