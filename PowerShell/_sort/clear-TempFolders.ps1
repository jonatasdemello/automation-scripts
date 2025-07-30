
# try this first:
$U = Get-ChildItem C:\Users\* -Directory
foreach ($item in $U) {
    $p = $item.fullName +"\AppData\Local\Temp"

    if ( Test-Path -Path $p -PathType Container ) {
        write-host "removing: $p"
        Get-ChildItem -Path $p -Include *.* -Recurse | `
            Remove-Item -Recurse -Force | Out-Null
            #-WhatIf
    }
}

# -------------------------------------------------------------------------------------------------------------------------------
# remove from Windows\temp first

Get-ChildItem -Path "C:\Windows\Temp" *.* -Recurse | Remove-Item -Force -Recurse

$tempfolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")

# try to remove:
Remove-Item $tempfolders -force -recurse

foreach ($item in $tempfolders) {

    if ( Test-Path -Path $item -PathType Container ) {
        write-host "removing: $p"
        Get-ChildItem -Path $item -Include *.* -Recurse | `
			Remove-Item -Recurse -Force # -WhatIf
    }
}

# -------------------------------------------------------------------------------------------------------------------------------
# Clen Recycle.bin

Clear-RecycleBin
Get-ChildItem "C:\`$Recycle.bin\" -Force | Remove-Item -Recurse -force

