# CJCMS - JDK 26 配置指南

## 📋 项目规范

**本项目使用 JDK 26 作为标准开发环境**

- ✅ Java 版本：26
- ✅ 编译器级别：26
- ✅ Maven 配置：已更新
- ✅ 数据库：Oracle (ORCL)

---

## 📥 JDK 26 下载与安装

### 下载地址（三选一）

#### 1. OpenJDK 26 (Temurin) - 推荐 ⭐
```
https://adoptium.net/temurin/releases/?version=26
```
或直链：
```
https://github.com/adoptium/temurin26-binaries/releases/latest/download/OpenJDK26U-jdk_x64_windows_hotspot_26_GA.msi
```

#### 2. Oracle JDK 26
```
https://www.oracle.com/java/technologies/downloads/#jdk26-windows
```

#### 3. Amazon Corretto 26
```
https://docs.aws.amazon.com/corretto/latest/corretto-26-ug/downloads-list.html
```

### 安装步骤

1. **下载安装包**（约 300MB）
2. **双击运行** `.msi` 文件
3. **选择安装路径**（推荐）：
   ```
   C:\Program Files\Eclipse Adoptium\jdk-26.x.x-hotspot
   ```
   或自定义到：
   ```
   D:\Program Files\Java\jdk-26
   ```
4. **完成安装**

---

## ⚙️ 环境变量配置

### 方法一：自动配置（推荐）

安装完成后，运行项目启动脚本会自动检测。

### 方法二：手动配置

#### 1. 设置 JAVA_HOME

右键"此电脑" → "属性" → "高级系统设置" → "环境变量"：

```
系统变量 → 新建
变量名：JAVA_HOME
变量值：C:\Program Files\Eclipse Adoptium\jdk-26.x.x-hotspot
```

#### 2. 编辑 Path

找到 `Path` 变量，添加：
```
%JAVA_HOME%\bin
```

#### 3. 验证安装

打开新的命令行窗口：
```bash
java -version
javac -version
```

应该显示：
```
openjdk version "26.x.x"
javac 26.x.x
```

---

## 🚀 运行项目

### 方式一：使用启动脚本（推荐）

```bash
cd E:\CJCMS
start-jdk26.bat
```

脚本会自动：
- ✅ 检测 JDK 26
- ✅ 编译项目
- ✅ 启动 Spring Boot

### 方式二：Maven 命令

```bash
cd E:\CJCMS

# 编译
mvn clean compile

# 运行
mvn spring-boot:run
```

### 方式三：IDE 中运行

#### Trae CN / VS Code
1. 打开 `E:\CJCMS` 文件夹
2. 右键 `CjcmsApplication.java`
3. 选择 "Run" 或按 `F5`

#### IntelliJ IDEA
1. File → Open → 选择 `E:\CJCMS`
2. 等待 Maven 导入完成
3. 运行 `CjcmsApplication.java`

#### Eclipse
1. File → Import → Existing Maven Projects
2. 选择 `E:\CJCMS` 目录
3. 运行 `CjcmsApplication.java`

---

## 🔧 Trae CN 配置

### 配置 JDK 26

1. 按 `Ctrl+,` 打开设置
2. 搜索 `java.configuration.runtimes`
3. 点击 "Edit settings.json"
4. 添加配置：

```json
{
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-26",
            "path": "C:\\Program Files\\Eclipse Adoptium\\jdk-26.x.x-hotspot",
            "default": true
        }
    ]
}
```

### 创建工作区设置

在项目根目录创建 `.vscode/settings.json`：

```json
{
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-26",
            "path": "C:\\Program Files\\Eclipse Adoptium\\jdk-26.x.x-hotspot",
            "default": true
        }
    ],
    "java.project.sourcePaths": ["src/main/java"],
    "java.project.testSourcePaths": ["src/test/java"]
}
```

---

## 📊 项目结构说明

```
E:\CJCMS\
├── pom.xml                          # Maven 配置（JDK 26）
├── start-jdk26.bat                  # JDK 26 启动脚本
├── src/main/
│   ├── java/com/cjcms/
│   │   ├── CjcmsApplication.java    # 主启动类
│   │   ├── controller/
│   │   │   ├── ArticleController.java
│   │   │   └── AuthController.java
│   │   ├── dto/
│   │   │   ├── LoginRequest.java
│   │   │   └── LoginResponse.java
│   │   ├── model/
│   │   │   ├── Article.java
│   │   │   └── Administrator.java
│   │   ├── repository/
│   │   │   ├── ArticleRepository.java
│   │   │   └── AdministratorRepository.java
│   │   └── service/
│   │       ├── ArticleService.java
│   │       └── AuthService.java
│   └── resources/
│       ├── application.properties   # 配置文件
│       └── static/
│           ├── login.html           # 登录页面
│           └── dashboard.html       # 仪表盘
└── database/
    ├── init_login.sql               # 登录功能初始化
    ├── init_oracle.sql              # Oracle 完整初始化
    └── test_connection.sql          # 数据库连接测试
```

---

## 🔍 常见问题

### Q1: Maven 编译错误 "不支持的语言级别"
**解决**: 确保 `pom.xml` 中配置了正确的版本：
```xml
<java.version>26</java.version>
<maven.compiler.source>26</maven.compiler.source>
<maven.compiler.target>26</maven.compiler.target>
```

### Q2: IDE 提示找不到 JDK
**解决**: 
1. 在 IDE 中重新配置 JDK 路径
2. 重启 IDE
3. 检查环境变量是否正确

### Q3: 运行时出现版本冲突
**解决**: 
```bash
# 清除旧的编译文件
mvn clean

# 重新编译
mvn clean compile
```

### Q4: Oracle 驱动不兼容
**解决**: JDK 26 完全兼容 ojdbc8，如果还有问题可以升级到 ojdbc11

---

## ✅ 检查清单

安装完成后，请确认：

- [ ] JDK 26 已安装
- [ ] `java -version` 显示版本 26
- [ ] 环境变量 JAVA_HOME 已设置
- [ ] Trae CN 已配置 JDK 26 路径
- [ ] 数据库脚本已执行
- [ ] 项目可以成功编译
- [ ] 项目可以正常启动

---

## 📞 需要帮助？

如果在配置过程中遇到问题，请告诉我具体的错误信息！

**下一步**：
1. 下载并安装 JDK 26
2. 告诉我安装路径
3. 我会帮你完成剩余配置
4. 测试登录功能
