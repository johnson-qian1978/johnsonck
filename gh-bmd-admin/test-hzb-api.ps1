$r = Invoke-RestMethod -Uri 'http://localhost:3000/api/menus/list'
$item = $r.data | Where-Object {$_.UNIQUE_KEY -eq 'hzb_home'}
Write-Host "MENU_ID:" $item.MENU_ID
Write-Host "MENU_TITLE:" $item.MENU_TITLE
Write-Host "UNIQUE_KEY:" $item.UNIQUE_KEY
Write-Host "COMPONENT:" $item.COMPONENT
Write-Host "PARENT_ID:" $item.PARENT_ID
