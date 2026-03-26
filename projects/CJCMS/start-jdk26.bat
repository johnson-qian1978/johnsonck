@echo off
chcp 65001 >nul
echo ========================================
echo CJCMS 项目启动脚本 (JDK 26 + Oracle)
echo ========================================
echo.

REM 设置 JDK 26 路径
set JAVA_HOME=D:\Program Files\Java\jdk-26
set PATH=%JAVA_HOME%\bin;%PATH%

echo [1/4] 检查 Java 环境...
java -version
if %errorlevel% neq 0 (
    echo [错误] 未检测到 JDK 26！
    echo 请确认安装路径：D:\Program Files\Java\jdk-26
    pause
    exit /b 1
)
echo [成功] Java 环境正常
echo.

echo [2/4] 检查 Maven 环境...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到 Maven，将使用 Maven Wrapper
    if exist "mvnw.cmd" (
        set MVN_CMD=mvnw.cmd
        echo [成功] 使用 Maven Wrapper
    ) else (
        echo [信息] 将直接使用 java 命令运行
        set MVN_CMD=direct
    )
) else (
    set MVN_CMD=mvn
    echo [成功] Maven 环境正常
)
echo.

if "%MVN_CMD%"=="direct" (
    echo [3/4] 直接运行项目...
    echo ========================================
    echo 正在启动 CJMS...
    echo 访问地址：http://localhost:8080/login.html
    echo ========================================
    echo.
    
    cd /d %~dp0
    set CLASSPATH=target\classes;target\test-classes
    for %%i in ("%USERPROFILE%\.m2\repository\org\springframework\boot\spring-boot-starter-web\2.7.18\spring-boot-starter-web-2.7.18.jar") do set CLASSPATH=!CLASSPATH!;%%i
    
    java -cp "%CLASSPATH%" com.cjcms.CjcmsApplication
) else (
    echo [3/4] 编译项目...
    %MVN_CMD% clean compile
    if %errorlevel% neq 0 (
        echo [错误] 编译失败！
        pause
        exit /b 1
    )
    echo [成功] 编译完成
    echo.
    
    echo [4/4] 启动项目...
    echo ========================================
    echo 正在启动 CJCMS...
    echo 访问地址：http://localhost:8080/login.html
    echo ========================================
    echo.
    
    %MVN_CMD% spring-boot:run
)

pause
