# OpenClaw Windows Desktop UI 开发文档

## 📋 项目概述

### 项目背景
OpenClaw 是一个开源的 AI 助手框架，目前提供 Web 版 Control UI 和命令行界面。本项目旨在开发一个**原生 Windows 桌面应用程序**，参考腾讯 WorkBuddy 的优秀设计，提供更流畅、更直观的本地用户体验。

### 项目目标
1. **短期目标（MVP）**：实现核心对话功能 + 思考过程可视化 + 基础任务管理
2. **中期目标**：完整的插件/技能管理 + 产物面板 + 智能预览
3. **长期愿景**：成为 Windows 平台上最好用的 AI 助手桌面应用

### 设计原则
- ✅ **参考 WorkBuddy**：三栏布局、思考可视化、产物面板
- ✅ **保持 OpenClaw 特色**：WebSocket 实时通信、技能系统、插件生态
- ✅ **原生体验**：Windows 原生 UI、系统托盘、全局快捷键
- ✅ **渐进增强**：从 MVP 开始，逐步迭代

---

## 🏗️ 技术选型

### 方案对比

| 方案 | 优点 | 缺点 | 推荐度 |
|------|------|------|--------|
| **Electron** | 跨平台、Web 技术栈、生态成熟 | 体积大、内存占用高 | ⭐⭐⭐⭐ |
| **Tauri v2** | 体积小、性能好、Rust 后端 | 学习曲线陡、Windows 兼容性需验证 | ⭐⭐⭐⭐⭐ |
| **WPF/.NET** | 纯原生、性能最佳、Windows 深度集成 | 仅限 Windows、开发效率低 | ⭐⭐⭐ |
| **Flutter Desktop** | 跨平台、UI 一致性好、性能不错 | 生态较新、Windows 支持待完善 | ⭐⭐⭐ |

### 🎯 推荐方案：**Tauri v2 + React + TypeScript**

#### 技术栈详情

**前端（Frontend）**
- **框架**: React 18 + TypeScript
- **UI 库**: Shadcn/ui + Tailwind CSS
- **状态管理**: Zustand（轻量）或 Redux Toolkit（复杂场景）
- **构建工具**: Vite
- **路由**: React Router v6

**后端（Backend - Rust）**
- **框架**: Tauri v2
- **WebSocket**: `tokio-tungstenite`
- **系统托盘**: `tauri-plugin-system-tray`
- **全局快捷键**: `tauri-plugin-global-shortcut`
- **文件系统**: Tauri 内置 FS API
- **进程管理**: `tauri-plugin-shell`

**通信协议**
- **WebSocket**: 与 OpenClaw Gateway 通信（ws://127.0.0.1:18789）
- **IPC**: Tauri Command（前端 ↔ Rust 后端）
- **事件总线**: Tauri Event System

#### 为什么选择 Tauri？

1. **体积优势**
   - Electron: ~150MB（包含 Chromium）
   - Tauri: ~10MB（使用系统 WebView2）

2. **性能优势**
   - 内存占用：Tauri 约为 Electron 的 1/3
   - 启动速度：Tauri 快 2-3 倍

3. **安全性**
   - 默认禁用外部链接
   - 细粒度的权限控制
   - 内容安全策略（CSP）

4. **Windows 友好**
   - 使用系统 WebView2（Windows 10/11 自带）
   - 支持 Windows 原生特性（任务栏、通知、托盘）

---

## 📐 架构设计

### 整体架构图

```
┌─────────────────────────────────────────────────────────┐
│                  OpenClaw Windows App                    │
│  ┌───────────────────────────────────────────────────┐  │
│  │              Frontend (React + TS)                │  │
│  │  ┌─────────────┬─────────────┬─────────────────┐  │  │
│  │  │  Left Panel │ Main Chat   │  Right Panel    │  │  │
│  │  │  Navigation │  Area       │  Product/Task   │  │  │
│  │  └─────────────┴─────────────┴─────────────────┘  │  │
│  │                                                   │  │
│  │  State Management (Zustand)                       │  │
│  │  WebSocket Service                                │  │
│  │  UI Components (Shadcn/ui)                        │  │
│  └───────────────────────────────────────────────────┘  │
│                           ↕ IPC (Tauri Commands)        │
│  ┌───────────────────────────────────────────────────┐  │
│  │              Backend (Rust + Tauri)               │  │
│  │  ┌─────────────┬─────────────┬─────────────────┐  │  │
│  │  │  WebSocket  │  System     │  File System    │  │  │
│  │  │  Client     │  Tray       │  & Settings     │  │  │
│  │  └─────────────┴─────────────┴─────────────────┘  │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↕ WebSocket
┌─────────────────────────────────────────────────────────┐
│              OpenClaw Gateway (Localhost)               │
│                   ws://127.0.0.1:18789                  │
└─────────────────────────────────────────────────────────┘
```

### 目录结构

```
openclaw-windows/
├── src/                      # 前端源码
│   ├── components/           # React 组件
│   │   ├── Layout/          # 布局组件
│   │   │   ├── TopBar.tsx
│   │   │   ├── LeftSidebar.tsx
│   │   │   ├── MainContent.tsx
│   │   │   ├── RightPanel.tsx
│   │   │   └── BottomInput.tsx
│   │   ├── Chat/            # 对话相关
│   │   │   ├── MessageList.tsx
│   │   │   ├── MessageBubble.tsx
│   │   │   ├── StepCard.tsx         # 思考步骤卡片
│   │   │   ├── ThoughtVisualizer.tsx # 思考过程可视化
│   │   │   └── MarkdownRenderer.tsx
│   │   ├── ProductPanel/    # 产物面板
│   │   │   ├── ProductTabs.tsx
│   │   │   ├── FileList.tsx
│   │   │   ├── PreviewWindow.tsx    # 智能预览
│   │   │   └── ChangeHistory.tsx
│   │   ├── TaskPanel/       # 任务面板
│   │   │   ├── TaskList.tsx
│   │   │   ├── TaskItem.tsx
│   │   │   └── ProgressBar.tsx
│   │   └── common/          # 通用组件
│   │       ├── Button.tsx
│   │       ├── Input.tsx
│   │       ├── Card.tsx
│   │       └── Loading.tsx
│   ├── pages/               # 页面组件
│   │   ├── Home.tsx
│   │   ├── Settings.tsx
│   │   └── Skills.tsx
│   ├── hooks/               # 自定义 Hooks
│   │   ├── useWebSocket.ts
│   │   ├── useChat.ts
│   │   ├── useTasks.ts
│   │   └── useSettings.ts
│   ├── store/               # 状态管理
│   │   ├── chatStore.ts
│   │   ├── taskStore.ts
│   │   ├── settingsStore.ts
│   │   └── index.ts
│   ├── services/            # API 服务
│   │   ├── websocket.ts
│   │   ├── gateway.ts
│   │   └── storage.ts
│   ├── styles/              # 全局样式
│   │   ├── globals.css
│   │   └── theme.css
│   ├── utils/               # 工具函数
│   │   ├── format.ts
│   │   └── validators.ts
│   ├── types/               # TypeScript 类型
│   │   ├── message.ts
│   │   ├── task.ts
│   │   └── settings.ts
│   ├── App.tsx
│   └── main.tsx
├── src-tauri/               # Tauri 后端（Rust）
│   ├── src/
│   │   ├── main.rs
│   │   ├── websocket.rs     # WebSocket 客户端
│   │   ├── tray.rs          # 系统托盘
│   │   ├── shortcuts.rs     # 全局快捷键
│   │   └── commands.rs      # Tauri Commands
│   ├── Cargo.toml
│   └── tauri.conf.json
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── vite.config.ts
└── README.md
```

---

## 🎨 UI 组件详细设计

### 1. 左侧导航栏（LeftSidebar）

**尺寸**: 240px 宽度，可折叠

**功能模块**:
```tsx
interface LeftSidebarProps {
  sessions: Session[];
  currentSessionId: string;
  onSessionSelect: (id: string) => void;
  onNewSession: () => void;
}

// 结构
- Logo + 品牌名（固定顶部）
- 搜索框（支持会话/任务/文件搜索）
- 功能菜单
  - 🆕 新建任务
  - 🔧 Claw（核心功能）
  - 👥 专家（子代理管理）
  - 🎯 技能（已安装技能）
  - 🧩 插件（插件管理）
  - ⚙️ 自动化（Cron 任务）
- 分隔线
- 会话列表（按时间排序）
  - 标题 + 时间戳 + 状态图标
  - 点击切换会话
  - 右键菜单（重命名、删除、导出）
- 底部用户信息
  - 头像 + 昵称
  - 在线状态
  - 设置入口
```

**交互细节**:
- 悬停高亮
- 拖拽排序会话
- 可调节宽度（200-300px）
- 双击折叠/展开

---

### 2. 中间对话区（MainContent）

**核心特性：思考过程可视化**

```tsx
interface MessageBubble {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  timestamp: number;
  steps?: ThoughtStep[];  // 思考步骤
}

interface ThoughtStep {
  id: string;
  title: string;          // "读取设计文档"
  detail?: string;        // "docs/openclaw-web-ui-design.md · 5.1KB"
  status: 'pending' | 'running' | 'completed' | 'failed';
  duration?: number;      // 耗时（毫秒）
  progress?: number;      // 进度（0-100）
  errorMessage?: string;  // 失败时的错误信息
}

// 组件结构
<MessageBubble>
  {/* 用户消息 - 右侧蓝色气泡 */}
  {role === 'user' && <UserBubble content={content} />}
  
  {/* AI 回复 - 左侧白色卡片 */}
  {role === 'assistant' && (
    <AIBubble>
      {/* 思考步骤卡片列表 */}
      {steps?.map(step => (
        <StepCard
          icon={getStatusIcon(step.status)}
          title={step.title}
          detail={step.detail}
          duration={formatDuration(step.duration)}
          progress={step.progress}
          status={step.status}
        />
      ))}
      
      {/* 自然语言总结 */}
      <SummaryText>{content}</SummaryText>
    </AIBubble>
  )}
</MessageBubble>
```

**StepCard 设计**:
```tsx
const StepCard = ({ icon, title, detail, duration, status, progress }) => {
  const bgColor = status === 'completed' ? '#f6ffed' : 
                  status === 'running' ? '#e6f4ff' : '#fff2f0';
  const borderColor = status === 'completed' ? '#b7eb8f' : 
                      status === 'running' ? '#91d5ff' : '#ffccc7';
  
  return (
    <div className={`step-card ${status}`} style={{ backgroundColor: bgColor, borderColor }}>
      <div className="step-icon">{icon}</div>
      <div className="step-content">
        <div className="step-title">{title}</div>
        <div className="step-detail">{detail}</div>
        {status === 'running' && (
          <ProgressBar value={progress} />
        )}
      </div>
      <div className="step-time">{duration}</div>
    </div>
  );
};
```

---

### 3. 右侧面板（RightPanel）

**四视图切换设计**:

```tsx
type PanelView = 'products' | 'files' | 'changes' | 'tasks';

interface RightPanelProps {
  currentView: PanelView;
  onViewChange: (view: PanelView) => void;
  products: Product[];
  tasks: Task[];
}

// Tab 页签
<TabGroup>
  <Tab id="products" icon="📦" label="产物" />
  <Tab id="files" icon="📄" label="全部" />
  <Tab id="changes" icon="🔄" label="变更" />
  <Tab id="tasks" icon="✅" label="任务" />
</TabGroup>

// 视图内容
{currentView === 'products' && <ProductPanel />}
{currentView === 'files' && <FileExplorer />}
{currentView === 'changes' && <ChangeHistory />}
{currentView === 'tasks' && <TaskList />}
```

#### 产物面板（ProductPanel）

```tsx
interface Product {
  id: string;
  name: string;
  type: 'document' | 'code' | 'data' | 'media';
  size: number;
  createdAt: number;
  path: string;
  previewUrl?: string;
}

<ProductPanel>
  {/* 文件列表 */}
  <FileList>
    {products.map(product => (
      <FileCard
        icon={getFileIcon(product.type)}
        name={product.name}
        size={formatSize(product.size)}
        time={formatTime(product.createdAt)}
        actions={['preview', 'copy', 'download', 'delete']}
        onPreview={() => openPreview(product)}
      />
    ))}
  </FileList>
  
  {/* 智能预览窗口 */}
  {selectedProduct && (
    <PreviewWindow product={selectedProduct}>
      {/* 根据文件类型自动适配 */}
      {product.type === 'data' && <ChartPreview data={product.data} />}
      {product.type === 'code' && <CodePreview code={product.code} />}
      {product.type === 'document' && <MarkdownPreview content={product.content} />}
      {product.type === 'media' && <MediaPreview url={product.previewUrl} />}
    </PreviewWindow>
  )}
</ProductPanel>
```

#### 任务面板（TaskList）

```tsx
interface Task {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'completed';
  priority: 'low' | 'medium' | 'high';
  dueDate?: number;
  completedAt?: number;
}

<TaskList>
  {/* 任务项 */}
  {tasks.map(task => (
    <TaskItem
      checkbox={<Checkbox checked={task.status === 'completed'} />}
      title={task.title}
      priority={<PriorityDot level={task.priority} />}
      dueDate={formatDueDate(task.dueDate)}
      strikethrough={task.status === 'completed'}
    />
  ))}
  
  {/* 进度统计 */}
  <ProgressSummary>
    <Text>进度：{completed}/{total} 已完成 ({percentage}%)</Text>
    <ProgressBar value={percentage} />
  </ProgressSummary>
</TaskList>
```

---

### 4. 底部输入区（BottomInput）

```tsx
interface BottomInputProps {
  value: string;
  onChange: (value: string) => void;
  onSend: () => void;
  mode: 'craft' | 'auto' | 'skills';
  onModeChange: (mode: Mode) => void;
}

<BottomInput>
  {/* 多行输入框 */}
  <TextArea
    value={value}
    onChange={onChange}
    placeholder="输入消息或命令... (支持 @提及、#标签)"
    onKeyDown={(e) => {
      if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
        onSend();
      }
    }}
    autoFocus
  />
  
  {/* 工具栏 */}
  <Toolbar>
    {/* 模式切换 */}
    <ModeSwitcher>
      <ModeButton 
        active={mode === 'craft'} 
        onClick={() => onModeChange('craft')}
      >Craft</ModeButton>
      <ModeButton 
        active={mode === 'auto'} 
        onClick={() => onModeChange('auto')}
      >Auto</ModeButton>
      <ModeButton 
        active={mode === 'skills'} 
        onClick={() => onModeChange('skills')}
      >Skills</ModeButton>
    </ModeSwitcher>
    
    {/* 附件按钮 */}
    <AttachmentButtons>
      <Button icon="📎" tooltip="上传文件" onClick={handleUpload} />
      <Button icon="📷" tooltip="截图" onClick={handleScreenshot} />
      <Button icon="🔗" tooltip="粘贴链接" onClick={handleLink} />
    </AttachmentButtons>
    
    {/* 发送按钮 */}
    <SendButton onClick={onSend} disabled={!value.trim()}>
      发送
      <ShortcutHint>Ctrl+Enter</ShortcutHint>
    </SendButton>
  </Toolbar>
</BottomInput>
```

---

## 🔌 WebSocket 通信设计

### 连接管理

```typescript
// services/websocket.ts
import { io } from 'socket.io-client';

class WebSocketService {
  private socket: Socket | null = null;
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 5;

  connect(url: string = 'ws://127.0.0.1:18789') {
    this.socket = io(url, {
      transports: ['websocket'],
      reconnection: true,
      reconnectionDelay: 1000,
      reconnectionDelayMax: 5000,
      reconnectionAttempts: this.maxReconnectAttempts,
    });

    this.socket.on('connect', () => {
      console.log('✅ WebSocket connected');
      this.reconnectAttempts = 0;
    });

    this.socket.on('disconnect', (reason) => {
      console.log('❌ WebSocket disconnected:', reason);
      this.handleReconnect();
    });

    this.socket.on('message', (data) => {
      this.handleMessage(data);
    });

    this.socket.on('error', (error) => {
      console.error('WebSocket error:', error);
    });
  }

  send(message: any) {
    if (this.socket?.connected) {
      this.socket.emit('message', message);
    } else {
      console.warn('WebSocket not connected, queueing message');
      this.queueMessage(message);
    }
  }

  private handleReconnect() {
    if (this.reconnectAttempts < this.maxReconnectAttempts) {
      this.reconnectAttempts++;
      setTimeout(() => this.connect(), 1000 * this.reconnectAttempts);
    } else {
      console.error('Max reconnect attempts reached');
      // 通知用户
    }
  }
}

export const wsService = new WebSocketService();
```

### 消息格式

```typescript
// 用户消息
interface UserMessage {
  type: 'user_message';
  content: string;
  sessionId: string;
  timestamp: number;
  metadata?: {
    mode?: 'craft' | 'auto' | 'skills';
    attachments?: Attachment[];
  };
}

// AI 回复
interface AIMessage {
  type: 'ai_message';
  content: string;
  sessionId: string;
  timestamp: number;
  steps?: ThoughtStep[];
  metadata?: {
    model?: string;
    duration?: number;
    tokens?: {
      prompt: number;
      completion: number;
    };
  };
}

// 系统事件
interface SystemEvent {
  type: 'system_event';
  event: 'session_created' | 'session_deleted' | 'file_saved' | 'task_updated';
  payload: any;
  timestamp: number;
}
```

---

## 🛠️ 开发路线图

### Phase 1: 项目初始化（1 周）

**目标**: 搭建开发环境，创建基础项目结构

**任务清单**:
- [ ] 安装 Rust 和 Tauri CLI
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  npm install -g @tauri-apps/cli
  ```
- [ ] 创建 Tauri 项目
  ```bash
  npm create tauri-app@latest openclaw-windows
  ```
- [ ] 配置 React + TypeScript + Vite
- [ ] 安装 Shadcn/ui + Tailwind CSS
- [ ] 配置 ESLint + Prettier
- [ ] 设置 Git 仓库和 CI/CD

**交付物**: 可运行的空白应用窗口

---

### Phase 2: 核心布局（1 周）

**目标**: 实现三栏布局 + 基础导航

**任务清单**:
- [ ] TopBar 组件（搜索 + 用户信息）
- [ ] LeftSidebar 组件（菜单 + 会话列表）
- [ ] MainContent 容器
- [ ] RightPanel 容器
- [ ] BottomInput 组件
- [ ] 响应式布局（可调节面板宽度）
- [ ] 深色/浅色主题切换

**交付物**: 静态界面原型（无功能）

---

### Phase 3: WebSocket 通信（1 周）

**目标**: 实现与 OpenClaw Gateway 的实时通信

**任务清单**:
- [ ] WebSocket 服务封装
- [ ] 连接管理（重连、错误处理）
- [ ] 消息收发
- [ ] 会话管理（创建、切换、删除）
- [ ] 消息持久化（IndexedDB）

**交付物**: 可发送/接收消息的聊天界面

---

### Phase 4: 思考过程可视化（2 周）⭐ **核心特性**

**目标**: 实现 WorkBuddy 风格的步骤分解卡片

**任务清单**:
- [ ] StepCard 组件
- [ ] ThoughtVisualizer 组件
- [ ] 状态管理（pending/running/completed/failed）
- [ ] 进度条动画
- [ ] 耗时计算和显示
- [ ] 错误处理和重试机制
- [ ] 可折叠/展开步骤详情

**交付物**: 完整的思考过程可视化功能

---

### Phase 5: 产物面板（2 周）

**目标**: 实现文件管理和智能预览

**任务清单**:
- [ ] ProductPanel 组件
- [ ] FileList + FileCard 组件
- [ ] 文件操作（预览、复制、下载、删除）
- [ ] PreviewWindow 组件
- [ ] 智能预览适配器
  - [ ] 数据报表（图表 + 表格）
  - [ ] 代码文件（语法高亮）
  - [ ] Markdown 文档
  - [ ] 图片/视频
- [ ] 文件监听（新增/修改/删除）

**交付物**: 完整的产物管理和预览功能

---

### Phase 6: 任务管理（1 周）

**目标**: 实现任务清单和进度追踪

**任务清单**:
- [ ] TaskList + TaskItem 组件
- [ ] 复选框和完成状态
- [ ] 优先级标识
- [ ] 截止日期提醒
- [ ] 进度条和统计
- [ ] 拖拽排序
- [ ] 与 OpenClaw Cron 集成

**交付物**: 完整的任务管理功能

---

### Phase 7: 系统集成（1 周）

**目标**: Windows 原生特性集成

**任务清单**:
- [ ] 系统托盘图标
- [ ] 全局快捷键（唤起/隐藏窗口）
- [ ] Windows 通知
- [ ] 开机自启动
- [ ] 单实例检测
- [ ] 自动更新检查

**交付物**: 完整的 Windows 桌面应用

---

### Phase 8: 测试和优化（1 周）

**目标**: 质量保证和性能优化

**任务清单**:
- [ ] 单元测试（Vitest）
- [ ] 端到端测试（Playwright）
- [ ] 性能优化（代码分割、懒加载）
- [ ] 内存泄漏检测
- [ ] 无障碍访问（a11y）
- [ ] 用户测试和反馈收集

**交付物**: 稳定、高性能的发布版本

---

## 📦 打包和分发

### 构建配置

```json
// src-tauri/tauri.conf.json
{
  "build": {
    "beforeBuildCommand": "npm run build",
    "beforeDevCommand": "npm run dev",
    "devPath": "http://localhost:5173",
    "distDir": "../dist"
  },
  "package": {
    "productName": "OpenClaw",
    "version": "1.0.0"
  },
  "tauri": {
    "bundle": {
      "active": true,
      "targets": ["msi", "nsis"],
      "identifier": "com.openclaw.desktop",
      "icon": [
        "icons/icon.ico",
        "icons/icon.png"
      ],
      "windows": {
        "certificateThumbprint": null,
        "digestAlgorithm": "sha256",
        "timestampUrl": ""
      }
    }
  }
}
```

### 构建命令

```bash
# 开发模式
npm run tauri dev

# 生产构建
npm run tauri build

# 输出位置
src-tauri/target/release/bundle/
├── msi/
│   └── OpenClaw_1.0.0_x64_en-US.msi
└── nsis/
    └── OpenClaw_1.0.0_x64-setup.exe
```

---

## 🔒 安全考虑

### 1. WebSocket 安全
- 仅允许 localhost 连接（防止远程攻击）
- 实施 Token 认证
- 消息加密（可选）

### 2. 文件系统权限
- 最小权限原则
- 沙箱隔离
- 用户确认敏感操作

### 3. 内容安全策略（CSP）
```html
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; 
               script-src 'self' 'unsafe-inline'; 
               style-src 'self' 'unsafe-inline'; 
               connect-src 'self' ws://127.0.0.1:18789;">
```

---

## 📊 性能指标

### 目标性能

| 指标 | 目标值 | 测量方式 |
|------|--------|----------|
| 启动时间 | < 2s | 冷启动到可用 |
| 内存占用 | < 150MB | 空闲状态 |
| 消息延迟 | < 100ms | 发送到显示 |
| 帧率 | 60 FPS | 滚动/动画 |
| 安装包大小 | < 50MB | Windows 安装器 |

### 优化策略
- 代码分割（Route-based + Component-based）
- 虚拟列表（长消息列表）
- 图片懒加载
- WebSocket 消息批处理
- Rust 后端高性能计算

---

## 🧪 测试策略

### 单元测试
```typescript
// __tests__/StepCard.test.tsx
import { render, screen } from '@testing-library/react';
import { StepCard } from '@/components/Chat/StepCard';

describe('StepCard', () => {
  it('renders completed step correctly', () => {
    render(
      <StepCard
        title="读取设计文档"
        detail="docs/openclaw-web-ui-design.md"
        status="completed"
        duration={300}
      />
    );
    expect(screen.getByText('读取设计文档')).toBeInTheDocument();
    expect(screen.getByText('0.3s')).toBeInTheDocument();
  });
});
```

### 端到端测试
```typescript
// e2e/chat.spec.ts
import { test, expect } from '@playwright/test';

test('send message and receive response', async ({ page }) => {
  await page.goto('/');
  
  // 输入消息
  await page.locator('textarea').fill('你好');
  await page.locator('button[aria-label="发送"]').click();
  
  // 等待 AI 回复
  await expect(page.locator('.message-bubble.ai')).toBeVisible();
  
  // 验证思考步骤显示
  await expect(page.locator('.step-card')).toHaveCount(3);
});
```

---

## 📚 参考资源

### 官方文档
- [Tauri v2 Docs](https://v2.tauri.app/)
- [React Documentation](https://react.dev/)
- [Shadcn/ui](https://ui.shadcn.com/)
- [Tailwind CSS](https://tailwindcss.com/)

### 开源项目参考
- [WorkBuddy](https://workbuddy.ai) - 设计灵感
- [OpenClaw](https://github.com/openclaw/openclaw) - 现有实现
- [ChatUI](https://chatui.io/) - 聊天界面参考

### 工具和库
- **图标**: Lucide React / Heroicons
- **图表**: Recharts / Chart.js
- **代码高亮**: Prism.js / Highlight.js
- **Markdown**: react-markdown + remark-gfm
- **日期格式化**: date-fns

---

## 🎯 成功标准

### MVP 发布标准（Phase 4 完成）
- ✅ 三栏布局完整
- ✅ WebSocket 稳定连接
- ✅ 消息收发正常
- ✅ 思考过程可视化工作
- ✅ 无明显 Bug

### v1.0 发布标准（Phase 8 完成）
- ✅ 所有核心功能实现
- ✅ 性能指标达标
- ✅ 通过安全审计
- ✅ 用户测试反馈良好
- ✅ 文档完整

---

## 📝 后续迭代计划

### v1.1 - 插件系统
- 插件市场浏览
- 一键安装/卸载
- 插件权限管理

### v1.2 - 多账号支持
- 账号切换
- 配置同步
- 云端备份

### v1.3 - AI 增强
- 语音输入
- 智能建议
- 上下文感知

### v2.0 - 跨平台
- macOS 版本
- Linux 版本
- 移动端（iOS/Android）

---

**版本**: v1.0  
**创建时间**: 2026-03-17  
**作者**: OpenClaw Assistant  
**状态**: 草稿待评审  
**下次更新**: 根据用户反馈调整

---

## 💡 给开发者的建议

1. **从小处着手**: 先实现 MVP，不要一开始就追求完美
2. **频繁测试**: 每完成一个功能就测试，避免后期堆积 Bug
3. **用户反馈**: 尽早发布 Beta 版，收集真实用户反馈
4. **性能优先**: Tauri 的优势就是轻量，不要让前端变得臃肿
5. **保持兼容**: 确保与现有 OpenClaw 生态系统兼容

**记住**: 最好的产品不是一次性做出来的，而是持续迭代优化的结果！🚀
