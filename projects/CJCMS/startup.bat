@echo off
chcp 65001 >nul
set LOGFILE=E:\CJCMS\startup.log
echo ======================================== > %LOGFILE%
echo CJCMS Startup Log - %date% %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%
echo. >> %LOGFILE%

cd /d E:\CJCMS

echo [%time%] Stopping existing Java processes... >> %LOGFILE%
taskkill /F /IM java.exe >nul 2>&1
timeout /t 3 /nobreak >nul

echo [%time%] Starting Maven build... >> %LOGFILE%
call "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" clean package -DskipTests >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [%time%] [ERROR] Maven build failed! >> %LOGFILE%
    call "D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd" clean package -DskipTests 2>&1 | findstr /C:"ERROR" >> %LOGFILE%
    echo.
    echo ❌ Build failed! Check %LOGFILE% for details.
    pause
    exit /b 1
)

echo [%time%] [SUCCESS] Maven build completed >> %LOGFILE%
echo. >> %LOGFILE%
echo [%time%] Starting Spring Boot application... >> %LOGFILE%

start "CJCMS Server" cmd /k "cd /d E:\CJCMS && call D:\Program Files\apache-maven-3.9.14\bin\mvn.cmd spring-boot:run 2>&1 | tee -a %LOGFILE%"

echo [%time%] Waiting for application to start (30 seconds)... >> %LOGFILE%
timeout /t 30 /nobreak >nul

echo [%time%] Testing if application is running... >> %LOGFILE%
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8080/admin-list.html' -TimeoutSec 5 -UseBasicParsing; if ($response.StatusCode -eq 200) { Write-Host '[SUCCESS] Application is running!' -ForegroundColor Green; Add-Content '%LOGFILE%' '[SUCCESS] Application started successfully' } else { Write-Host '[WARNING] Application returned status code: ' + $response.StatusCode -ForegroundColor Yellow; Add-Content '%LOGFILE%' '[WARNING] Status code: ' + $response.StatusCode } } catch { Write-Host '[ERROR] Application is not accessible: ' + $_.Exception.Message -ForegroundColor Red; Add-Content '%LOGFILE%' '[ERROR] ' + $_.Exception.Message }"

echo.
echo ========================================
echo CJCMS Startup Complete
echo ========================================
echo Log file: %LOGFILE%
echo.
echo Opening log file in Notepad...
notepad %LOGFILE%
