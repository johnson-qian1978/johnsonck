#!/usr/bin/env pwsh
# OpenClaw Windows Dev Environment Checker

Write-Host "🔍 Checking OpenClaw Windows development environment..." -ForegroundColor Cyan
Write-Host ""

$checks = @{
    "Node.js" = @{ command = "node"; args = @("-v"); minVersion = "18.0.0" }
    "npm" = @{ command = "npm"; args = @("-v"); minVersion = "9.0.0" }
    "Rust" = @{ command = "rustc"; args = @("--version"); minVersion = $null }
    "Cargo" = @{ command = "cargo"; args = @("--version"); minVersion = $null }
}

$allPassed = $true

foreach ($tool in $checks.Keys) {
    $config = $checks[$tool]
    Write-Host "Checking $tool..." -NoNewline
    
    try {
        $result = & $config.command $config.args 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " ✅ $result" -ForegroundColor Green
        } else {
            Write-Host " ❌ Failed to execute" -ForegroundColor Red
            $allPassed = $false
        }
    } catch {
        Write-Host " ❌ Not installed" -ForegroundColor Red
        $allPassed = $false
    }
}

Write-Host ""
Write-Host "Checking WebView2..." -NoNewline
$webView2Path = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
if (Test-Path $webView2Path) {
    $version = (Get-ItemProperty $webView2Path).pv
    Write-Host " ✅ Installed (Version: $version)" -ForegroundColor Green
} else {
    Write-Host " ❌ Not found" -ForegroundColor Red
    Write-Host "   Download: https://developer.microsoft.com/en-us/microsoft-edge/webview2/" -ForegroundColor Yellow
    $allPassed = $false
}

Write-Host ""
if ($allPassed) {
    Write-Host "🎉 All required tools are installed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Run: npm create tauri-app@latest openclaw-windows -- --template react-ts"
    Write-Host "  2. Run: cd openclaw-windows"
    Write-Host "  3. Run: npm install"
    Write-Host "  4. Run: npm run tauri dev"
} else {
    Write-Host "⚠️  Some tools are missing. Please install them first." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Installation commands:" -ForegroundColor Cyan
    Write-Host "  Node.js: winget install OpenJS.NodeJS.LTS"
    Write-Host "  Rust: winget install Rustlang.Rustup"
    Write-Host "  VS Build Tools: winget install Microsoft.VisualStudio.2022.BuildTools"
    Write-Host "  WebView2: winget install Microsoft.WebView2"
}

Write-Host ""
