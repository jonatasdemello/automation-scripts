
winget install nilesoft.shell

DISM.exe /Online /Cleanup-image /Restorehealth
sfc /scannow

# -------------------------------------------------------------------------------------------------------------------------------

Invoke-WebRequest -useb https://git.io/debloat|iex

# -------------------------------------------------------------------------------------------------------------------------------


Get-AppxPackage | Select-Object Name, PackageFullName
Get-AppXPackage -User Lavin38 | Select Name, PackageFullName
Get-AppXPackage -User Lavin38

Get-AppxPackage -AllUsers | Select Name, PackageFullName

Remove-AppxPackage <PackageFullName>
Get-AppxPackage <App_Name> | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage *Xbox* | Remove-AppxPackage

Get-AppxPackage -user <UserName> <AppName> | Remove-AppxPackage

# Remove All Pre-Installed Apps

Get-AppxPackage | Remove-AppxPackage
Get-AppxPackage -allusers | Remove-AppxPackage
Get-AppxPackage -user <Username> | Remove-AppxPackage

Get-AppxPackage | where-object {$_.name –notlike “*Paint*”} | Remove-AppxPackage
Get-AppxPackage | where-object {$_.name –notlike “*Paint*”} | where-object {$_.name –notlike “*store*”} | where-object {$_.name –notlike “*Office*”} | Remove-AppxPackage

# Remove an App From New User Accounts

Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "*AppName*"} | Remove-AppxProvisionedPackage –online

Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Windows.CBSPreview"} | Remove-AppxProvisionedPackage –online

Get-AppXProvisionedPackage -Online | Select PackageName

Remove-AppXProvisionedPackage -Online -PackageName <PackageName>

Remove-AppXProvisionedPackage -Online -PackageName Microsoft.MicrosoftSolitaireCollection_4.15.11210.0_neutral_~_8wekyb3d8bbwe

Get-AppXProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online


# Reinstall/Restore System Apps in Windows 11

Get-AppxPackage -allusers | Select Name, PackageFullName

Add-AppxPackage -register "C:\Program Files\WindowsApps\PackageFullName\appxmanifest.xml" -DisableDevelopmentMode

Add-AppxPackage -register "C:\Program Files\WindowsApps\Microsoft.BingNews_4.55.43072.0_x64__8wekyb3d8bbwe\appxmanifest.xml" -DisableDevelopmentMode

# To reinstall or restore all the built-in apps in Windows 11,

Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}



DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename

DISM /Online /Remove-ProvisionedAppxPackage /PackageName:PACKAGENAME

DISM /Online /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingNews_4.11.3002.0_neutral_~_8wekyb3d8bbwe



winget list

winget uninstall

Winget uninstall News

winget uninstall "Microsoft People"
winget uninstall "Microsoft.Skype"

winget list xbox
winget uninstall --name "Xbox Game Bar" -e

winget uninstall --id=Microsoft.MicrosoftEdge.Stable_8wekyb3d8bbwe

# To clear all the saved data and settings of the app

winget uninstall "Windows Maps" --purge

# To remove an app but keep all the files and folders created by the application

winget uninstall "Windows Maps" --preserve

winget uninstall Office -e --interactive

# silent mode

winget uninstall Office -e -h


# Microsoft.BingSearch_8wekyb3d8bbwe
# Microsoft.GetHelp_8wekyb3d8bbwe
# Microsoft.Getstarted_8wekyb3d8bbwe
# Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe
# Microsoft.Office.OneNote_8wekyb3d8bbwe

# Microsoft.Ink.Handwriting.Main.en-US.1.0.1_8wekyb3d8bbwe
# Microsoft.Ink.Handwriting.en-US.1.0_8wekyb3d8bbwe
