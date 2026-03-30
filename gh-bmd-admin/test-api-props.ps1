$r = Invoke-RestMethod -Uri 'http://localhost:3000/api/menus/list'
Write-Host "Total items:" $r.data.Count
Write-Host "First item properties:"
$r.data[0] | Get-Member -MemberType NoteProperty | Select-Object Name
