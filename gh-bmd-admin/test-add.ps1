$body = @{id='TEST001';name='测试单位';type=1;bak='测试数据'} | ConvertTo-Json
Invoke-RestMethod -Uri 'http://localhost:3000/api/bmd' -Method Post -Body $body -ContentType 'application/json'
