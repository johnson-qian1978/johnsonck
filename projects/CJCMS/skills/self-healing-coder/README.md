# Self-Healing Coder - 自我修复程序员

## 命令
```bash
/heal [file_path] [error_message]
/fix [issue_description]
```

## 工作流程

### 1. 错误捕获
- 解析错误信息
- 定位错误位置（文件、行号）
- 提取错误类型

### 2. 安全检查
```powershell
# 检查是否在白名单路径
if (-not (Test-PathInAllowedPaths $filePath)) {
    Write-Error "文件不在允许范围内，跳过修复"
    return
}

# 检查工作树是否干净
if (-not (Test-GitWorkingTreeClean)) {
    Write-Warning "工作树不干净，请先提交或暂存更改"
    return
}
```

### 3. 错误分析
- 语法错误 → 自动修复
- 逻辑错误 → 生成修复方案
- 依赖错误 → 跳过并告警
- 环境错误 → 跳过并告警

### 4. 生成修复方案
```yaml
修复方案:
  - 修改的文件: [最多 3 个]
  - 修改的类型: [仅限函数体、导入语句]
  - 预计影响: [低/中/高]
  - 回滚方案: [必须提供]
```

### 5. 执行修复
- 创建新分支：`auto-fix/timestamp-issue-id`
- 应用修复
- 运行测试验证
- 生成修复报告

### 6. 验证和回滚
```powershell
# 验证修复
$testResult = Run-Tests -FilePath $filePath

if (-not $testResult.Passed) {
    # 修复失败，自动回滚
    git reset --hard HEAD
    Write-Error "修复失败，已回滚。错误：$($testResult.Error)"
    
    # 记录失败
    Add-FailureToLog -Error $testResult.Error -Attempt $attemptCount
    
    # 检查是否触发熔断
    if ($attemptCount -ge 10) {
        Trigger-CircuitBreaker
        Write-Error "已达到最大重试次数，触发熔断。请人工介入。"
    }
    
    return
}
```

## 🔒 安全限制

### 禁止的操作
- ❌ 删除文件
- ❌ 修改 pom.xml / package.json
- ❌ 修改 .env 配置文件
- ❌ 修改构建脚本
- ❌ 执行系统命令

### 允许的操作
- ✅ 修改函数体
- ✅ 修复语法错误
- ✅ 添加缺失的 import
- ✅ 修正变量命名
- ✅ 修复拼写错误

## 📊 监控面板

实时显示：
- 当前修复进度
- 已尝试次数
- 成功率统计
- 资源使用情况

## 🛑 紧急停止

任何时候可以执行：
```bash
/stop-heal  # 立即停止当前修复
/reset-counter  # 重置失败计数
/show-status  # 显示当前状态
```

---

**配置完成时间**: 2026-03-24  
**安全等级**: 🔒 高（严格的防死循环机制）
