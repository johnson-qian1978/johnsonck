# CJCMS 开发环境配置指南

## 🔍 当前环境状态

### ✅ 已安装
- **JDK 19**: `D:\Program Files\Java\jdk-19`
- **Oracle 数据库**: 已连接 (CJCMS@ORCL)
- **PL/SQL Developer**: 已安装并使用中

### ❌ 需要配置
- Trae CN 的 JDK 路径未设置
- Maven 可能需要安装

## 🚀 立即配置步骤

### 方法一：在 Trae CN 中自动配置（推荐）

1. **点击提示框中的"自动下载 JDK 并进行设置"按钮**
   - Trae CN 会自动下载并配置 Oracle JDK
   - 等待下载完成

2. **或者手动指定 JDK 路径**：
   - 打开 Trae CN 设置
   - 找到 Java 配置
   - 设置 JDK 路径为：`D:\Program Files\Java\jdk-19`

### 方法二：手动配置环境变量

#### 1. 设置 JAVA_HOME

右键"此电脑" → "属性" → "高级系统设置" → "环境变量"：

```
系统变量 → 新建
变量名：JAVA_HOME
变量值：D:\Program Files\Java\jdk-19
```

#### 2. 添加 Path

编辑 Path 变量，添加：
```
%JAVA_HOME%\bin
```

#### 3. 验证配置

打开新的命令行窗口，执行：
```bash
java -version
javac -version
```

应该显示：
```
java version "19.x.x"
javac 19.x.x
```

## 📦 Maven 安装（如果需要）

### 检查是否已安装
```bash
mvn -version
```

### 如果未安装 Maven：

#### 方式一：使用 Chocolatey（推荐）
```bash
choco install maven
```

#### 方式二：手动安装
1. 访问 https://maven.apache.org/download.cgi
2. 下载 `apache-maven-3.9.x-bin.zip`
3. 解压到 `D:\Program Files\Maven`
4. 添加环境变量：
   ```
   MAVEN_HOME = D:\Program Files\Maven
   Path 中添加 %MAVEN_HOME%\bin
   ```

## ⚙️ Trae CN 配置

### 配置 JDK 路径

1. 打开 Trae CN
2. 按 `Ctrl+,` 打开设置
3. 搜索 "java.configuration.runtimes"
4. 添加 JDK 配置：
   ```json
   {
     "name": "JavaSE-19",
     "path": "D:\\Program Files\\Java\\jdk-19",
     "default": true
   }
   ```

### 配置项目 JDK

在项目根目录创建 `.vscode/settings.json`：
```json
{
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-19",
            "path": "D:\\Program Files\\Java\\jdk-19",
            "default": true
        }
    ],
    "java.project.referencedLibraries": [
        "lib/**/*.jar"
    ]
}
```

## 🔧 运行项目

### 方式一：使用 Maven 命令

```bash
cd E:\CJCMS
mvn clean compile
mvn spring-boot:run
```

### 方式二：在 Trae CN 中运行

1. 打开 `E:\CJCMS` 文件夹
2. 右键 `CjcmsApplication.java`
3. 选择 "Run" 或按 `F5`

### 方式三：使用 IDEA/Eclipse

1. 用 IDEA 或 Eclipse 打开 `E:\CJCMS`
2. 等待 Maven 依赖下载完成
3. 运行 `CjcmsApplication.java`

## 🎯 快速测试清单

- [ ] JDK 已安装 (`java -version`)
- [ ] Maven 已安装 (`mvn -version`)
- [ ] Trae CN 已配置 JDK 路径
- [ ] 数据库脚本已执行 (`init_login.sql`)
- [ ] 项目可以编译成功
- [ ] 项目可以启动成功
- [ ] 登录页面可以访问 (`http://localhost:8080/login.html`)

## 💡 常见问题

### Q1: Trae CN 仍然提示找不到 JDK
**解决**: 
1. 完全关闭 Trae CN
2. 重新打开
3. 如果还不行，重启电脑

### Q2: Maven 下载依赖很慢
**解决**: 配置阿里云镜像
编辑 `settings.xml` (通常在 `用户目录\.m2\`):
```xml
<mirror>
    <id>aliyun</id>
    <mirrorOf>central</mirrorOf>
    <name>Aliyun Maven</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

### Q3: 端口 8080 被占用
**解决**: 
1. 修改 `application.properties`:
   ```properties
   server.port=8081
   ```
2. 或者关闭占用 8080 端口的程序

### Q4: Oracle 驱动下载失败
**解决**: 
Maven 会自动从中央仓库下载，如果失败可以手动下载 ojdbc8.jar 放到本地仓库

## 📞 需要帮助？

如果还有问题，请告诉我具体的错误信息！
