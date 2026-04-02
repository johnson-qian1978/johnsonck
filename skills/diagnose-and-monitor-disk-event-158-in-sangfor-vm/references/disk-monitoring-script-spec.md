# 磁盘监控脚本技术规范

## 监控频率与资源占用
- **执行间隔**：每 5 分钟一次（通过计划任务）
- **单次执行时间**：约 1–2 秒
- **CPU 占用**：< 0.5%
- **内存占用**：约 10 MB（PowerShell 进程）
- **I/O 影响**：极低，仅读取性能计数器，不写入磁盘数据

## 监控指标与告警阈值
| 指标 | 性能计数器路径 | 告警阈值 | 说明 |
|------|----------------|----------|------|
| 平均读取延迟 | `\PhysicalDisk(*)\Avg. Disk sec/Read` | > 50 ms | 转换为毫秒单位 |
| 平均写入延迟 | `\PhysicalDisk(*)\Avg. Disk sec/Write` | > 50 ms | 转换为毫秒单位 |
| 磁盘队列长度 | `\PhysicalDisk(*)\Current Disk Queue Length` | > 10 | 表示 I/O 请求积压 |
| 读取吞吐量 | `\PhysicalDisk(*)\Disk Read Bytes/sec` | — | 记录原始值（MB/s） |
| 写入吞吐量 | `\PhysicalDisk(*)\Disk Write Bytes/sec` | — | 记录原始值（MB/s） |
| CPU 使用率 | `\Processor(_Total)\% Processor Time` | — | 辅助分析 |
| 内存使用率 | `\Memory\% Committed Bytes In Use` | — | 辅助分析 |

## 日志格式（CSV）
```csv
时间,Disk,QueueLength,AvgReadMs,AvgWriteMs,ReadMBps,WriteMBps,CPU%,Memory%,Status
2026-04-01 11:30:00,"0 C:",2.5,8.3,5.2,12.5,3.2,35.2,45.3,OK
2026-04-01 11:35:00,"0 C:",15.2,52.1,48.3,2.1,1.5,45.2,52.1,ALERT
```

## 文件命名规范
- 所有脚本文件名必须为 **纯英文**（如 `diagnose-disk.bat`）
- 避免中文字符，防止在部分系统触发 GBK 编码错误

## 局限性说明
- 无法记录硬死机瞬间的数据（因系统完全无响应）
- 主要价值在于捕获死机前 **5 分钟内的性能恶化趋势**（如队列长度突增、延迟飙升）
- 需配合 Windows 事件日志（Disk 158 + Kernel-Power 41）形成完整证据链