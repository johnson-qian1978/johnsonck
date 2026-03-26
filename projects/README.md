# 🚀 项目源码

这里存放所有开发项目的源码，每个项目都有独立的目录。

---

## 📋 项目列表

| 项目名称 | 技术栈 | 状态 | 说明 |
|----------|--------|------|------|
| [CJCMS](./CJCMS/) | Spring Boot + Oracle | 🟡 开发中 | 长江内容管理系统 |
| [system-info-viewer](./system-info-viewer/) | Python + tkinter | ✅ 完成 | 系统信息查看器 |

---

## 📁 项目详情

### CJCMS - 长江内容管理系统

```
CJCMS/
├── src/main/java/        # Java 源码
│   ├── controller/       # 控制器
│   ├── service/          # 服务层
│   ├── entity/           # 实体类
│   └── mapper/           # MyBatis Mapper
├── src/main/resources/   # 资源文件
│   ├── static/           # 静态页面
│   └── application.yml   # 配置文件
├── database/             # SQL 脚本
├── docs/                 # 项目文档
└── pom.xml               # Maven 配置
```

**启动方式**:
```bash
cd E:\CJCMS
mvn spring-boot:run
```

---

### System Info Viewer - 系统信息查看器

```
system-info-viewer/
├── system_info_viewer_gui_v2.py  # GUI 主程序 (最新版)
├── system_info_viewer.py         # 命令行版本
├── device_brands.py              # 设备品牌识别
├── README.md                     # 项目说明
└── TEST_REPORT.md                # 测试报告
```

**运行方式**:
```bash
python system_info_viewer_gui_v2.py
```

---

## 🔧 版本管理规范

每个项目完成后必须：
1. ✅ 复制源码到此目录
2. ✅ 更新 README.md
3. ✅ 提交到 GitHub

```bash
git add projects/<项目名>/
git commit -m "feat: 添加 <项目名> 源码"
git push origin main
```