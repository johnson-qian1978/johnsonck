## [LRN-20260316-001] 技能配置隔离

**Logged**: 2026-03-16T16:43:00+08:00
**Priority**: high
**Status**: pending
**Area**: config

### Summary
技能安装失败会导致 OpenClaw 无法启动，需要将技能配置与主配置分离。

### Details
用户反馈：
- 安装技能后 OpenClaw 启动失败
- 需要删除技能和插件配置才能恢复
- 希望技能安装不影响主配置

当前问题：
- 技能配置在 `openclaw.json` 的 `skills.entries` 中
- 插件配置在 `openclaw.json` 的 `plugins.entries` 中
- 配置错误会导致 Gateway 无法启动

### Suggested Action
1. **技能配置独立文件**
   - 创建 `skills.json` 或 `skills/` 目录
   - 每个技能独立配置文件
   - 主配置只保留核心设置

2. **配置加载顺序**
   - 先加载主配置（`openclaw.json`）
   - 再加载技能配置（`skills/*.json`）
   - 技能加载失败不影响主配置

3. **技能安装沙盒**
   - 新技能先安装到 `skills/staging/`
   - 验证成功后再启用
   - 支持一键回滚

4. **配置验证**
   - 安装前验证技能配置格式
   - 验证通过再写入配置
   - 失败时自动恢复备份

### Metadata
- Source: user_feedback
- Related Files: ~/.openclaw/openclaw.json
- Tags: config, skills, stability, isolation
- See Also: 

---

## [LRN-20260316-002] ClawHub 技能商店状态

**Logged**: 2026-03-16T16:43:00+08:00
**Priority**: medium
**Status**: pending
**Area**: skills

### Summary
ClawHub 技能商店目前为空，没有热门技能推荐。

### Details
访问 clawhub.ai 检查结果：
- 热门技能：无
- 推荐技能：无
- 技能总数：0

建议：
- 使用 OpenClaw 内置技能
- 从 GitHub 手动安装技能
- 等待 ClawHub 生态完善

### Metadata
- Source: web_research
- Related URLs: https://clawhub.ai/, https://clawhub.ai/skills
- Tags: clawhub, skills, marketplace

---
