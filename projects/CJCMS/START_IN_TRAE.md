# CJCMS 在 Trae CN 终端中启动指南

## 🚀 一键启动脚本

### 方法一：使用 PowerShell 脚本（推荐）

在 Trae CN 终端中执行以下命令：

```powershell
# 1. 打开 Trae CN 终端 (Ctrl + `)
# 2. 复制粘贴以下所有命令，然后回车

cd E:\CJCMS

# 设置环境变量
$env:JAVA_HOME = "D:\Program Files\Java\jdk-26"
$env:M2_HOME = "D:\Program Files\apache-maven-3.9.14"
$env:PATH = "$env:JAVA_HOME\bin;$env:M2_HOME\bin;$env:PATH"

# 验证环境
Write-Host "`n=== 环境检查 ===" -ForegroundColor Cyan
java -version
mvn -version

# 编译项目
Write-Host "`n=== 编译项目 ===" -ForegroundColor Cyan
mvn clean compile -DskipTests

# 构建 classpath
Write-Host "`n=== 准备启动 ===" -ForegroundColor Cyan
$cp = "target/classes"
$mavenRepo = "$env:USERPROFILE\.m2\repository"

# 获取所有依赖 JAR
Get-ChildItem -Path $mavenRepo -Recurse -Filter "*.jar" | ForEach-Object {
    $cp += ";" + $_.FullName
}

# 启动应用
Write-Host "`n=== 启动 CJCMS ===" -ForegroundColor Green
Write-Host "访问地址：http://localhost:8080/login.html" -ForegroundColor Yellow
Write-Host "按 Ctrl+C 停止服务`n" -ForegroundColor Yellow

java -cp "$cp" com.cjcms.CjcmsApplication
```

---

### 方法二：使用简化版（更快速）

如果上面的命令太慢，可以用这个简化版：

```powershell
cd E:\CJCMS
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
$env:PATH="$env:JAVA_HOME\bin;$env:PATH"

# 直接使用 Maven 的 exec 插件运行
mvn exec:java -Dexec.mainClass="com.cjcms.CjcmsApplication"
```

---

### 方法三：创建永久启动脚本

创建一个 `.ps1` 文件，以后直接运行：

1. **创建文件** `E:\CJCMS\start.ps1`：

```powershell
# start.ps1
param(
    [switch]$Clean
)

$JAVA_HOME = "D:\Program Files\Java\jdk-26"
$M2_HOME = "D:\Program Files\apache-maven-3.9.14"
$env:PATH = "$JAVA_HOME\bin;$M2_HOME\bin;$env:PATH"

cd $PSScriptRoot

if ($Clean) {
    mvn clean compile -DskipTests
}

$cp = "target/classes"
$mavenRepo = "$env:USERPROFILE\.m2\repository"

Write-Host "Loading dependencies..." -ForegroundColor Cyan
Get-ChildItem -Path $mavenRepo -Recurse -Filter "*.jar" -ErrorAction SilentlyContinue | 
    ForEach-Object { $cp += ";" + $_.FullName }

Write-Host "Starting CJCMS..." -ForegroundColor Green
Write-Host "URL: http://localhost:8080/login.html" -ForegroundColor Yellow

java -cp "$cp" com.cjcms.CjcmsApplication
```

2. **以后只需运行**：
   ```powershell
   .\start.ps1
   ```
   
   或者清理后启动：
   ```powershell
   .\start.ps1 -Clean
   ```

---

## ⚡ 立即行动

### 现在就在 Trae CN 中启动：

1. **打开 Trae CN**
2. **打开文件夹** `E:\CJMS`
3. **打开终端**：按 `` Ctrl + ` ``
4. **复制粘贴**下面的命令：

```powershell
cd E:\CJCMS; $env:JAVA_HOME="D:\Program Files\Java\jdk-26"; $env:PATH="$env:JAVA_HOME\bin;$env:PATH"; mvn exec:java -Dexec.mainClass="com.cjcms.CjcmsApplication"
```

5. **等待启动**
6. **访问** http://localhost:8080/login.html

---

## 🔧 可能的问题

### 问题 1: exec 插件未安装

如果提示 `Could not find goal 'java'`，需要添加插件到 `pom.xml`：

```xml
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>exec-maven-plugin</artifactId>
    <version>3.1.1</version>
    <configuration>
        <mainClass>com.cjcms.CjcmsApplication</mainClass>
    </configuration>
</plugin>
```

### 问题 2: 类找不到

确保已经编译：
```powershell
mvn clean compile -DskipTests
```

### 问题 3: 端口被占用

修改 `application.properties`：
```properties
server.port=8081
```

---

## 💡 提示

- **停止服务**: 在终端按 `Ctrl+C`
- **查看日志**: 终端会显示所有启动日志
- **后台运行**: 可以使用 `Start-Job` 或 `nohup`

---

## 🎯 最简单的命令

**就这一行**：
```powershell
cd E:\CJCMS && $env:JAVA_HOME="D:\Program Files\Java\jdk-26" && mvn exec:java -Dexec.mainClass="com.cjcms.CjcmsApplication"
```

**现在试试吧！** 😊
