Set-Location C:\Users
$U = Get-ChildItem * -Directory
foreach ($item in $U) {
    $p = $item.fullName +"\AppData\Local\Temp"

    if ( Test-Path -Path $p -PathType Container ) {
        write-host "removing: $p"
        Get-ChildItem -Path $p -Include *.* -Recurse | `
            Remove-Item -Recurse -Force | Out-Null
            #-WhatIf
    }
}
