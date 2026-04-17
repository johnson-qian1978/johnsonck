param()
$basePath = 'E:\宸ヤ綔鐩綍\D\work\椤圭洰璧勬枡\璐甸槼甯傚尰鐤椾簰鍔╀繚闅滅鐞嗙郴缁焅2025 骞碶缁煎悎缁欎粯'
$applyFile = Join-Path $basePath '缁煎悎缁欎粯鐢宠.xlsx'
$recordFile = Join-Path $basePath '缁煎悎缁欎粯璁板綍锛堝惈浣滃簾鍜岄噸澶嶆眹鎬昏褰曪級.xlsx'
$outputFile = Join-Path $basePath '缁煎悎缁欎粯鐢宠_鏈壘鍒版爣璁?xlsx'
Write-Host "Files:"
Write-Host "  Apply: $applyFile"
Write-Host "  Record: $recordFile"
Write-Host "  Output: $outputFile"
& python C:\Users\27151\.openclaw\workspace\compare_excel.py $applyFile $recordFile $outputFile
