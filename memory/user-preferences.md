# 用户偏好记录 - 2026-03-17

## 💡 重要教训

### 用户明确偏好：手动安装 > 自动安装

**原因：**
1. ✅ **可以看到进度** - 知道安装到哪里了
2. ✅ **可以及时发现卡死** - 如果卡住能立即处理
3. ✅ **有掌控感** - 每一步都清楚
4. ✅ **可以对话** - 不会因为后台任务阻塞会话

**具体场景：**
- 凡是能下载 `.exe` 双击安装的软件 → **用户自己安装**
- 不要让我在后台长时间运行安装任务
- 如果需要等待，应该让用户看到进度界面

---

## 🌏 国内镜像加速（重要！）

### 用户明确要求：所有下载都要先设置国内镜像

**适用场景：**
- Rust (rustup)
- Node.js (npm)
- Python (pip)
- Git (GitHub)
- Docker
- 任何国外源的下载

### Rust 镜像设置（已验证有效）⭐

```cmd
# 在运行 rustup-init.exe 之前设置
set RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
set RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
```

**速度对比：**
- ❌ 官方源：30-50 KB/s
- ✅ 中科大镜像：1-5 MB/s（快 30-100 倍）

### 其他常用镜像

**npm (Node.js):**
```cmd
npm config set registry https://registry.npmmirror.com
```

**pip (Python):**
```cmd
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

**Git (GitHub):**
```cmd
git config --global url."https://ghproxy.com/".insteadOf "https://github.com/"
```

---

## 🎯 最佳实践

### ✅ 正确做法：
1. **先检查是否需要国内镜像** ✓
2. **提供镜像设置命令** ✓
3. **帮用户下载安装器** ✓
4. **告诉用户双击哪里** ✓
5. **等用户安装完成后验证** ✓
6. **继续下一步** ✓

### ❌ 错误做法：
1. 直接用国外源下载（慢）✗
2. 在后台运行长时间安装任务 ✗
3. 用户看不到进度 ✗
4. 不知道是否卡死 ✗
5. 阻塞会话，无法对话 ✗
6. 安装失败也不知道 ✗

---

## 📋 今天的问题总结

### VS Build Tools 安装
- ❌ 自动安装卡在 83%
- ❌ 用户看不到进度
- ❌ 卡死了也不知道
- ✅ **解决：** 用户手动重启安装程序，选择精简组件

### Rust 安装
- ❌ 后台安装出现文件冲突
- ❌ 反复重试浪费大量时间
- ❌ 用户完全不知道发生了什么
- ✅ **解决：** 清理现场，用户自己双击 rustup-init.exe

---

## 🚀 以后要记住

**原则：** 让用户掌控安装过程，我做辅助工作

**具体操作：**
1. 帮忙下载安装器 ✓
2. 提供清晰的安装步骤 ✓
3. 等待用户完成 ✓
4. 帮助验证安装结果 ✓
5. 不要占用后台长时间运行 ✗

---

**记录时间：** 2026-03-17 15:06  
**触发事件：** Rust 和 VS Build Tools 安装问题  
**用户原话：** "只要是可以下载.EXE 双击安装的，还是我自己来安装吧，这样稳妥些"
