If(!(Test-Path HKU:)){New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS}
$registrySearchPath = "HKU:\*\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
$pathToReplace = [regex]::Escape("C:\Users")
$newPath = '%USERPROFILE%'
Get-Item -path $registrySearchPath -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Name |
        Where-Object{$_ -match "^HKEY_USERS\\S-1-5-21"} |
        ForEach-Object{
    $key = $_ -replace "^HKEY_USERS","HKU:"
    (Get-ItemProperty $key).psobject.Properties | Where-Object{$_.Value -match $pathToReplace} |
            Select-Object Name,Value | ForEach-Object{
        Set-ItemProperty -Path $key -Name $_.Name -Value ($_.Value -replace $pathToReplace,$newPath) -WhatIf
    }
}
