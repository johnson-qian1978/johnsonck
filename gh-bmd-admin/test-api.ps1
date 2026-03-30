$r = Invoke-RestMethod -Uri 'http://localhost:3000/api/menus/list'
$r.data | Where-Object {$_.MENU_TITLE -like '*互助办*'} | Select-Object MENU_TITLE, UNIQUE_KEY, COMPONENT, PATH
