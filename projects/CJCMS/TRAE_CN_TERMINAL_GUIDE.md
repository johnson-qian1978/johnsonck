# Trae CN 命令行使用指南

## 📋 Trae CN 内置终端功能

Trae CN（基于 VS Code）自带强大的集成终端功能！

### ✅ 已确认的功能

#### 1. **内置终端** (Integrated Terminal)
- ✅ 完全支持命令行操作
- ✅ 支持 PowerShell、CMD、Git Bash
- ✅ 可以直接运行 Maven、Java 命令
- ✅ 支持多终端标签页

#### 2. **快速打开终端**
- 快捷键：`` Ctrl + ` `` (反引号)
- 菜单：查看 → 终端
- 命令面板：`Ctrl+Shift+P` → "View: Toggle Integrated Terminal"

---

## 🚀 使用 Trae CN 终端运行 CJCMS

### 方法一：使用内置终端（推荐）

#### 步骤：
1. **打开 Trae CN**
2. **打开项目文件夹**：`E:\CJCMS`
3. **打开终端**：按 `` Ctrl + ` ``
4. **执行命令**：

```bash
# 设置 JDK 26
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
$env:Path="$env:JAVA_HOME\bin;$env:Path"

# 验证 Java 版本
java -version

# 编译项目
mvn clean compile

# 运行项目
mvn spring-boot:run
```

### 方法二：使用启动脚本

在终端中执行：
```bash
cd E:\CJCMS
.\start-jdk26.bat
```

### 方法三：直接运行 Java

如果不想用 Maven：
```bash
# 在终端中
cd E:\CJCMS
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
java -cp "target/classes;target/dependency/*" com.cjcms.CjcmsApplication
```

---

## 🔧 Trae CN 扩展/技能

### 已安装的扩展（通常包括）

#### Java 相关：
- ✅ **Language Support for Java™ by Red Hat**
- ✅ **Debugger for Java**
- ✅ **Java Test Runner**
- ✅ **Maven for Java**
- ✅ **Spring Boot Extension Pack**

#### 数据库相关：
- 🔍 **SQLTools** - 数据库连接工具
- 🔍 **Oracle Developer Tools** - Oracle 专用工具

### 如何查看已安装的扩展

1. 按 `Ctrl+Shift+X` 打开扩展面板
2. 搜索 "Java" 或 "SQL"
3. 查看已安装的扩展

---

## 💡 推荐的扩展/技能

### 1. **SQLTools** (数据库管理)
可以在 Trae CN 中直接连接 Oracle 数据库！

**安装**：
- 扩展面板搜索 "SQLTools"
- 点击安装

**配置**：
```json
{
  "name": "CJCMS Oracle",
  "driver": "Oracle",
  "server": "localhost",
  "port": 1521,
  "service": "ORCL",
  "username": "CJCMS",
  "password": "1"
}
```

### 2. **Thunder Client** (API 测试)
类似 Postman，可以在 Trae CN 中直接测试 API！

**安装**：
- 扩展面板搜索 "Thunder Client"
- 点击安装

**使用**：
- 按 `Ctrl+Shift+P`
- 输入 "Thunder Client: New Request"
- 测试登录接口：`POST http://localhost:8080/api/auth/login`

### 3. **Code Runner** (快速运行代码)
可以快速运行 Java 文件！

---

## 🎯 实际操作示例

### 场景 1：在 Trae CN 中运行项目

```bash
# 1. 打开终端 (Ctrl + `)
# 2. 输入以下命令：

cd E:\CJCMS

# 设置环境变量
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
$env:PATH="$env:JAVA_HOME\bin;$env:PATH"

# 验证
java -version
javac -version

# 编译
mvn clean compile

# 运行
mvn spring-boot:run
```

### 场景 2：连接数据库查询

```bash
# 在终端中使用 SQL*Plus
sqlplus CJCMS/1@ORCL

# 执行 SQL 查询
SQL> SELECT USERNAME, REAL_NAME FROM CJ_ADM_ADMINISTRATOR;
SQL> EXIT;
```

### 场景 3：测试 API

```bash
# 使用 curl 测试登录接口
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"admin\",\"password\":\"admin123\"}"
```

---

## 📊 Trae CN 终端快捷操作

| 快捷键 | 功能 |
|--------|------|
| `` Ctrl + ` `` | 打开/关闭终端 |
| `Ctrl+Shift+` ` | 新建终端 |
| `Ctrl+Shift+C` | 复制选中内容 |
| `Ctrl+Shift+V` | 粘贴到终端 |
| `Ctrl+W` | 关闭当前终端 |
| `Alt+←/→` | 切换终端标签页 |

---

## 🔍 查找更多技能/扩展

### 方法 1：扩展市场
1. 按 `Ctrl+Shift+X`
2. 搜索关键词：
   - "Java"
   - "Spring Boot"
   - "Oracle"
   - "SQL"
   - "Maven"
   - "Terminal"

### 方法 2：命令面板
1. 按 `Ctrl+Shift+P`
2. 输入：
   - "Extensions: Install Extensions"
   - "Terminal: Create New Terminal"
   - "Java: Start Language Server"

---

## ✅ 立即行动

### 现在可以做的：

1. **打开 Trae CN**
2. **打开文件夹** `E:\CJCMS`
3. **打开终端** (`` Ctrl + ` ``)
4. **运行项目**：
   ```bash
   .\start-jdk26.bat
   ```

或者手动执行：
```bash
$env:JAVA_HOME="D:\Program Files\Java\jdk-26"
mvn clean spring-boot:run
```

### 访问应用

项目启动后，浏览器访问：
- **登录页面**: http://localhost:8080/login.html
- **API 测试**: http://localhost:8080/api/articles

---

## 📞 需要帮助？

如果在终端操作中遇到问题：
1. 截图错误信息
2. 告诉我具体的错误
3. 我会帮你解决！

**准备好了吗？现在就可以在 Trae CN 中打开终端运行项目了！** 🚀
