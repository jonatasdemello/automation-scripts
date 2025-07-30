<#
Google Chrome
Firefox

# Dev
VisualStudio
VSCode
Azure Data Studio
SSMS - SQL Server Management Studio

Docker/Podman
WSL / Ubuntu

Git
Notepad++ 32 (TextFX plugin)
Renamer (den4b)
SumatraPDF
Greenshot
Winmerge
grepWin

#>
# Powershell profile
test-path $profile
New-Item -Path $profile -Type File -Force

Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned

ise $profile


# install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression


# sudo
winget install gerardog.gsudo
PowerShell -Command "Set-ExecutionPolicy RemoteSigned -scope Process; [Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex"

# DevHome
winget upgrade Microsoft.DevHome

# Java
winget search Microsoft.OpenJDK
winget install -e --source winget --id Microsoft.OpenJDK.11
winget install -e --source winget --id Microsoft.OpenJDK.16
winget install -e --source winget --id Microsoft.OpenJDK.17
winget install -e --source winget --id Microsoft.OpenJDK.21

# Tools
winget install -e --source winget --id SumatraPDF.SumatraPDF
winget install -e --source winget --id Greenshot.Greenshot
winget install -e --source winget --id WinMerge.WinMerge
winget install -e --source winget --id StefansTools.grepWin
winget install -e --source winget --id den4b.ReNamer
winget install -e --source winget --id Notepad++.Notepad++

# Dev
winget install -e --source winget --id Microsoft.VisualStudioCode
winget install -e --source winget --id Microsoft.SQLServerManagementStudio
winget install -e --source winget --id Microsoft.AzureDataStudio

# Powershell SqlServer
Get-Module SqlServer -ListAvailable
(Get-Module SqlServer).Version

Install-Module -Name SqlServer
Install-Module -Name SQLServer -Scope CurrentUser


# Git
winget install -e --id Git.Git
winget install -e --id GitHub.cli
winget install -e --id TortoiseGit.TortoiseGit

Winget install -e --id Microsoft.PowerShell
winget install -e --id Microsoft.PowerShell.Preview


# NodeJS:
winget install -e --source winget --id OpenJS.NodeJS.LTS
# 	OpenJS.NodeJS 22.7.0
# 	OpenJS.NodeJS.LTS  20.17.0

#-----------------------------------------------------------------------
# PowerShell
Install-Module posh-git -Scope CurrentUser -Force
Update-Module posh-git
Import-Module posh-git



#-----------------------------------------------------------------------
# install SQL SSMS
# You can also pass /Passive instead of /Quiet to see the setup UI.
# SSMS is installed at %systemdrive%\SSMSto\Common7\IDE\Ssms.exe
# If something went wrong, the error code returned and review the log file in %TEMP%\SSMSSetup.

$media_path = "C:\Installers\SSMS-Setup-ENU.exe"
$install_path = "$env:SystemDrive\SSMSto"
$params = "/Install /Quiet SSMSInstallRoot=`"$install_path`""
Start-Process -FilePath $media_path -ArgumentList $params -Wait

#-----------------------------------------------------------------------
# hybernate

powercfg /hibernate on
powercfg /hibernate /type full

#-----------------------------------------------------------------------
# WSL

# Enable the Windows Subsystem for Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart


systeminfo | find "System Type"

# update kernel
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

wsl.exe --install
wsl.exe --update

wsl --set-default-version 2


# Dev Drive
fsutil devdrv query
fsutil devdrv enable
fsutil devdrv disable

#-----------------------------------------------------------------------
