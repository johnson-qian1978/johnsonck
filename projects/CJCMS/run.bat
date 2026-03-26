@echo off
chcp 65001 >nul
echo ========================================
echo CJCMS 项目启动脚本 (Oracle 版本)
echo ========================================
echo.

echo 检查 Java 环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Java 环境，请先安装 JDK 11+
    pause
    exit /b 1
)
echo [成功] Java 环境正常
echo.

echo 检查 Maven 环境...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到 Maven 环境
    echo 请确保已安装 Maven 或使用 IDE 运行项目
    echo.
) else (
    echo [成功] Maven 环境正常
    echo.
)

echo 检查 Oracle 连接配置...
findstr "oracle" src\main\resources\application.properties >nul
if %errorlevel% equ 0 (
    echo [成功] 已配置 Oracle 数据库连接
) else (
    echo [警告] 未找到 Oracle 配置，请检查 application.properties
)
echo.

echo 项目文件结构：
echo ========================================
dir /b /s *.java *.xml *.properties *.sql
echo ========================================
echo.

echo 重要提示：
echo ========================================
echo 1. 确保 Oracle 数据库已安装并启动
echo 2. 确保已创建用户 cjcms 并执行 database\init_oracle.sql
echo 3. 修改 src\main\resources\application.properties 中的：
echo    - spring.datasource.url (Oracle 服务名)
echo    - spring.datasource.username (用户名)
echo    - spring.datasource.password (密码)
echo.
echo 启动命令:
echo    mvn spring-boot:run
echo.
echo 或使用 IDE (IntelliJ IDEA / Eclipse) 直接运行 CjcmsApplication.java
echo.
echo API 地址：http://localhost:8080/api/articles
echo ========================================
echo.

pause
