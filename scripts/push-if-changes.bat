@echo off
cd /d "%USERPROFILE%\.openclaw\workspace"
git add .
git status --porcelain > nul 2>&1
if %errorlevel% equ 0 (
    git commit -m "Auto-push: %date% %time%" > nul 2>&1
    git push origin main
) else (
    echo No changes to push
)
