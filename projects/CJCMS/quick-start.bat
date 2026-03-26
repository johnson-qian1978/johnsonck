@echo off
chcp 65001 >nul
echo ========================================
echo   长江 CMS - 快速启动指南
echo ========================================
echo.

REM 检查 Java 是否安装
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Java 环境！
    echo.
    echo 请先安装 JDK 17 或更高版本：
    echo 下载地址：https://adoptium.net/
    echo.
    pause
    exit /b 1
)

echo [√] Java 环境已安装
java -version
echo.

REM 检查 Maven 是否安装
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到 Maven！
    echo.
    echo 请选择以下任一方式启动：
    echo.
    echo 方法 1: 安装 Maven (推荐)
    echo   下载地址：https://maven.apache.org/download.cgi
    echo   安装后配置环境变量 MAVEN_HOME
    echo.
    echo 方法 2: 使用 IDE 启动
    echo   1. 打开 IntelliJ IDEA 或 Eclipse
    echo   2. 导入项目：E:\CJCMS
    echo   3. 运行 CJCmsApplication.java
    echo.
    echo 方法 3: 手动下载依赖并编译
    echo   需要下载 Spring Boot 和 MyBatis Plus 的 JAR 文件
    echo.
    pause
    exit /b 1
)

echo [√] Maven 环境已安装
mvn -version | findstr Apache
echo.

cd /d %~dp0

echo ========================================
echo   正在启动长江 CMS...
echo ========================================
echo.

mvn clean spring-boot:run

pause
