# -------------------------------------------------------------------------------------------------------------------------------
# Powershell
# -------------------------------------------------------------------------------------------------------------------------------


Set-ExecutionPolicy Bypass -scope Process -Force
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass


# Environment Variables Powershell

Get-ChildItem -Path Env:
$Env:PSModulePath -split ';'

$Env:PSModulePath -split (';')

# New file

New-Item -Name EmptyFile.txt -ItemType File

Out-File -FilePath EmptyFile2.txt

# Delete

Get-ChildItem .\node_modules\ -Recurse | Remove-Item -Recurse -Force

Get-ChildItem .\.git -Recurse -Attributes H | Remove-Item -Recurse -Force

# Move files

Move-Item -path *game* -destination .\Dest1\ -whatif

# Rename

Get-ChildItem -Path *-books -Attributes D | Rename-Item -NewName {$_.name -replace "-books", ""} -whatif


-------------------------------------------------------------------------------------------------------------------------------
# Remove Apps

Get-AppxPackage * | Remove-AppxPackage
Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

# installed apps

Get-WmiObject -Class Win32_Product | Select-Object -Property Name

$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Some App"}
$MyApp.Uninstall()

-------------------------------------------------------------------------------------------------------------------------------
Compress-Archive -Path C:\path\to\file\* -DestinationPath C:\path\to\archive.zip

$today = Get-Date -Format "yyyy-MM-dd-"
Compress-Archive -Path .\schools\*.json -DestinationPath .\schools\backup\$todayg-schools.zip
Get-ChildItem -Path .\schools\*.json | Remove-Item




$compress = @{
  Path = "C:\Reference\Draftdoc.docx", "C:\Reference\Images\*.vsd"
  CompressionLevel = "Optimal"
  DestinationPath = "C:\Archives\Draft.Zip"
}
Compress-Archive @compress


Get-ChildItem notes-*.txt -R | Rename-Item -NewName { $_.Name -replace 'notes-','1o1-notes-' }


 Get-ChildItem . | Unblock-File

