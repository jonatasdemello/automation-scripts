
Write-Host "App Pool Recycling Started...." -ForegroundColor Green

& $env:windir\system32\inetsrv\appcmd.exe list apppools /state:Started /xml | `
	& $env:windir\system32\inetsrv\appcmd.exe recycle apppools /in

Write-Host "App Pool Recycling Completed" -ForegroundColor Green

# --------------------------------------------------------------------------------------------------------------

Import-Module WebAdministration
Get-Item iis:\\apppools\* | % {Restart-WebAppPool $_.Name}

