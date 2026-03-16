# OpenClaw Workspace Auto-Push Script
# Runs daily at 17:15 to sync learnings to GitHub

$ErrorActionPreference = "Stop"
$WorkspacePath = "$env:USERPROFILE\.openclaw\workspace"

Write-Host "=== OpenClaw Auto-Push ===" -ForegroundColor Cyan
Write-Host "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "Path: $WorkspacePath"
Write-Host ""

try {
    Set-Location $WorkspacePath
    
    # Check for changes
    $status = git status --porcelain
    if ($status) {
        Write-Host "Changes detected, committing..." -ForegroundColor Yellow
        git add .
        git commit -m "Auto-push: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
        
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
        git push origin main
        
        Write-Host "✅ Auto-push completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "No changes to push." -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Auto-push failed: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
