Get-Item -ErrorAction SilentlyContinue -path  "Microsoft.PowerShell.Core\Registry::HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" |
foreach {
    Get-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::$_" |
    foreach {
        $CurrentUserShellFoldersPath = $_.PSPath
        $SID = $CurrentUserShellFoldersPath.Split('\')[2]
        $_.PSObject.Properties |
        foreach {
            if ($_.Value -like "*DeadServer*") {
                write-host "Path:`t`t"$CurrentUserShellFoldersPath
                write-host "SID:`t`t"$SID
                write-host "Name:`t`t"$_.Name
                write-host "Old Value:`t"$_.Value
                $newValue = $_.Value
                $newValue = $newValue -replace '\\\\DeadServer\\RedirectedFolders', "C:\Users"
                $newValue = $newValue -replace "My Documents\\", ""
                $newValue = $newValue -replace "My ", ""
                Write-Host "New Value:`t"$newValue
                Set-ItemProperty -Path $CurrentUserShellFoldersPath -Name $_.Name -Value $newValue

                Write-host "================================================================"
            }
        }
    }
}