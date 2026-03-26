# Self-Healing Coder - 自我修复程序员技能配置

## 技能说明
自动检测代码错误、分析原因、生成修复方案并验证的自动化编程助手。

## ⚠️ 死循环防护机制（强制启用）

### 1. 最大重试次数限制
```yaml
max_retries: 10  # 最多尝试 10 次修复（默认 20 次）
```

### 2. 进展检测
```yaml
require_progress: true  # 每次修复必须有进展
progress_check_interval: 3  # 每 3 次检查一次进展
```

### 3. 熔断机制
```yaml
circuit_breaker:
  enabled: true
  threshold: 10  # 10 次失败后触发熔断
  cooldown_minutes: 30  # 熔断后冷却 30 分钟
```

### 4. 修复范围限制
```yaml
scope_limits:
  max_files_per_fix: 3  # 每次最多修改 3 个文件
  allowed_operations:
    - modify_function_body
    - fix_syntax_error
    - add_missing_import
    - fix_typo
  forbidden_operations:
    - delete_file
    - modify_dependency_config
    - modify_system_env
    - modify_build_config
```

### 5. 人工确认节点
```yaml
manual_confirmation:
  required_for:
    - more_than_3_fixes  # 超过 3 次修复需要确认
    - dependency_changes  # 依赖变更需要确认
    - config_changes  # 配置文件修改需要确认
  auto_confirm_for:
    - syntax_error  # 语法错误自动确认
    - typo_fix  # 拼写错误自动确认
```

### 6. 错误边界定义
```yaml
error_boundaries:
  skip_on_errors:
    - "OutOfMemoryError"  # 内存不足跳过
    - "StackOverflowError"  # 栈溢出跳过
    - "EnvironmentNotReady"  # 环境未就绪跳过
    - "DependencyConflict"  # 依赖冲突需要人工介入
  max_error_message_length: 500  # 错误信息截断
```

### 7. 资源限制
```yaml
resource_limits:
  max_cpu_percent: 50  # 最多使用 50% CPU
  max_memory_mb: 2048  # 最多使用 2GB 内存
  max_execution_time_seconds: 300  # 单次修复最多 5 分钟
```

### 8. 日志和审计
```yaml
logging:
  log_all_attempts: true  # 记录所有尝试
  save_failed_fixes: true  # 保存失败的修复方案
  alert_on_circuit_break: true  # 熔断时告警
```

## 📋 使用规范

### ✅ 适合的场景
1. 语法错误修复
2. 简单的逻辑错误
3. 缺失的导入语句
4. 变量命名错误
5. 单元测试失败修复

### ❌ 不适合的场景（会直接跳过）
1. 跨语言依赖冲突
2. 需要领域专业知识的业务逻辑
3. 性能优化问题
4. 架构设计问题
5. 第三方库的 bug
6. 环境配置问题

## 🛡️ 安全配置

### 文件访问白名单
```yaml
allowed_paths:
  - "src/**/*.java"
  - "src/**/*.js"
  - "src/**/*.ts"
  - "src/**/*.py"
  - "test/**/*.java"
  - "test/**/*.js"
  - "test/**/*.ts"
  - "test/**/*.py"

forbidden_paths:
  - "**/pom.xml"
  - "**/package.json"
  - "**/requirements.txt"
  - "**/.env*"
  - "**/*.sh"
  - "**/*.bat"
  - "node_modules/**"
  - ".git/**"
```

### Git 保护
```yaml
git_protection:
  require_clean_working_tree: true  # 工作树必须干净
  create_branch_for_fix: true  # 在新分支上修复
  branch_prefix: "auto-fix/"  # 分支前缀
  auto_commit: false  # 不自动提交
  require_review: true  # 需要代码审查
```

## 📊 监控指标

### 关键指标
- `fix_success_rate`: 修复成功率（目标 > 70%）
- `avg_fix_attempts`: 平均修复次数（目标 < 3）
- `circuit_break_triggers`: 熔断触发次数（目标 = 0）
- `false_positive_rate`: 误报率（目标 < 10%）

### 告警阈值
- 连续失败 5 次 → 警告
- 连续失败 10 次 → 熔断
- 成功率低于 50% → 暂停技能并告警

## 🔄 更新历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0 | 2026-03-24 | 初始版本，包含完整的防死循环机制 |

---

**重要提示**: 
- 首次使用时，建议先在测试项目上运行
- 定期检查修复日志，优化配置
- 如遇到复杂问题，优先选择人工修复
