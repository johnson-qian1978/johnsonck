$base = "E:\工作目录\D\work\ITSS\2026\（完）ITSS二级完整资料"
Get-ChildItem $base -Directory | ForEach-Object {
    Write-Host "=== $($_.Name) ==="
    Get-ChildItem "$($_.FullName)" -Recurse -File | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.Length) bytes) [$($_.Directory.Name)]"
    }
    Write-Host ""
}
