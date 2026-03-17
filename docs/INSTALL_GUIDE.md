# OpenClaw Windows UI - 开发环境准备清单

## ✅ 快速检查清单

### 必须安装的工具

| 工具 | 状态 | 安装命令 | 用途 |
|------|------|----------|------|
| **Node.js v18+** | ✅ 已安装 (v24.13.0) | `winget install OpenJS.NodeJS.LTS` | JavaScript 运行时 |
| **npm v9+** | ✅ 已安装 (v11.6.2) | 随 Node.js 自动安装 | 包管理器 |
| **Rust + Cargo** | ⏳ 安装中 | `winget install Rustlang.Rustup` | Tauri 后端编译 |
| **WebView2** | ✅ 已安装 (v145.0.3800.97) | `winget install Microsoft.WebView2` | Windows WebView |
| **VS Build Tools** | ❓ 待确认 | `winget install Microsoft.VisualStudio.2022.BuildTools` | C++ 编译工具 |

---

## 🚀 一键初始化项目

等待 Rust 安装完成后，运行以下命令：

```bash
# 1. 创建 Tauri 项目
npm create tauri-app@latest openclaw-windows -- --template react-ts

# 2. 进入项目目录
cd openclaw-windows

# 3. 安装依赖
npm install

# 4. 安装 Tauri CLI
npm install -g @tauri-apps/cli@latest

# 5. 启动开发服务器
npm run tauri dev
```

---

## 📦 MVP 最小依赖包

### 核心依赖（必须）

```bash
# 状态管理
npm install zustand

# 路由
npm install react-router-dom

# WebSocket
npm install socket.io-client

# 图标
npm install lucide-react

# 工具库
npm install date-fns lodash-es uuid
```

### UI 组件（推荐 Shadcn/ui）

```bash
# 初始化 Tailwind CSS
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# 初始化 Shadcn/ui
npx shadcn-ui@latest init

# 安装基础组件
npx shadcn-ui@latest add button input card dialog tabs progress checkbox scroll-area dropdown-menu tooltip avatar badge skeleton
```

### 富文本和媒体

```bash
# Markdown 渲染
npm install react-markdown remark-gfm rehype-highlight

# 代码高亮
npm install prismjs @types/prismjs

# 图表
npm install recharts
```

### 测试工具

```bash
# 单元测试
npm install -D vitest @testing-library/react @testing-library/jest-dom jsdom

# E2E 测试
npm install -D @playwright/test
npx playwright install
```

---

## 🛠️ 完整的 package.json 示例

```json
{
  "name": "openclaw-windows",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "tauri": "tauri",
    "test": "vitest",
    "test:e2e": "playwright test",
    "lint": "eslint . --ext ts,tsx"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.0",
    "zustand": "^4.4.7",
    "socket.io-client": "^4.7.2",
    "react-markdown": "^9.0.1",
    "remark-gfm": "^4.0.0",
    "rehype-highlight": "^7.0.0",
    "recharts": "^2.10.3",
    "date-fns": "^3.0.0",
    "lodash-es": "^4.17.21",
    "uuid": "^9.0.1",
    "lucide-react": "^0.300.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^2.1.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.43",
    "@types/react-dom": "^18.2.17",
    "@types/node": "^20.10.0",
    "@types/lodash-es": "^4.17.11",
    "@types/uuid": "^9.0.7",
    "@vitejs/plugin-react": "^4.2.1",
    "typescript": "^5.3.3",
    "vite": "^5.0.8",
    "tailwindcss": "^3.3.6",
    "postcss": "^8.4.32",
    "autoprefixer": "^10.4.16",
    "vitest": "^1.0.4",
    "@testing-library/react": "^14.1.2",
    "@playwright/test": "^1.40.1",
    "eslint": "^8.55.0",
    "prettier": "^3.1.1"
  }
}
```

---

## 🔧 Rust 后端配置

在 `src-tauri/Cargo.toml` 中添加：

```toml
[package]
name = "openclaw-windows"
version = "1.0.0"
edition = "2021"

[build-dependencies]
tauri-build = { version = "2.0", features = [] }

[dependencies]
tauri = { version = "2.0", features = [] }
tauri-plugin-shell = "2.0"
tauri-plugin-fs = "2.0"
tauri-plugin-dialog = "2.0"
tauri-plugin-notification = "2.0"
tokio = { version = "1", features = ["full"] }
tokio-tungstenite = "0.21"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
```

---

## 📝 开发流程

### 1. 环境准备（已完成 80%）
- ✅ Node.js + npm
- ✅ WebView2
- ⏳ Rust（安装中）
- ❓ VS Build Tools（可能需要）

### 2. 项目初始化（5 分钟）
```bash
npm create tauri-app@latest openclaw-windows
cd openclaw-windows
npm install
```

### 3. 安装依赖（2 分钟）
```bash
# 核心依赖
npm install zustand react-router-dom socket.io-client lucide-react

# UI 组件
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
npx shadcn-ui@latest init
```

### 4. 启动开发（1 分钟）
```bash
npm run tauri dev
```

**总计**: 约 10-15 分钟即可完成环境搭建！

---

## ⚠️ 常见问题

### Q1: Rust 安装失败
**解决**: 
```bash
# 手动下载安装
curl https://sh.rustup.rs -sSf | sh
# 或者下载离线安装包：https://rustup.rs/
```

### Q2: Tauri 编译错误
**解决**: 
- 确保安装了 VS Build Tools
- 勾选"使用 C++ 的桌面开发"工作负载
- 重启终端后重试

### Q3: WebView2 找不到
**解决**: 
```bash
winget install Microsoft.WebView2
# 或者下载：https://developer.microsoft.com/en-us/microsoft-edge/webview2/
```

### Q4: 端口被占用
**解决**: 
```bash
# 修改 vite.config.ts 中的端口
# 或者关闭占用端口的程序
netstat -ano | findstr :5173
taskkill /PID <PID> /F
```

---

## 📚 参考资源

- [Tauri v2 官方文档](https://v2.tauri.app/)
- [React 官方文档](https://react.dev/)
- [Shadcn/ui 文档](https://ui.shadcn.com/)
- [Tailwind CSS 文档](https://tailwindcss.com/)
- [OpenClaw 开发文档](./openclaw-windows-dev-plan.md)

---

## 🎯 下一步行动

1. **等待 Rust 安装完成**（当前正在进行）
2. **验证安装**: `rustc --version && cargo --version`
3. **创建项目**: `npm create tauri-app@latest openclaw-windows`
4. **开始开发**!

---

**更新时间**: 2026-03-17 13:15  
**状态**: Rust 安装中 ⏳
