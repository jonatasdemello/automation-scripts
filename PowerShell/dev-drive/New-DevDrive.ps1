 <#

.SYNOPSIS
    Script to create a new Dev Drive

.DESCRIPTION
    This script will create a new Dev Drive on a Windows system. By default, it will create a 100GB dynamically sized VHDX file located in C:\ProgramData\Custom Dev Drive\drive.vhdx that will be mounted to the V: letter drive. For more information about Dev Drives, please see https://learn.microsoft.com/en-us/windows/dev-drive/

.EXAMPLE
    .\New-DevDrive.ps1
  or
    .\New-DevDrive.ps1 -DrivePath "C:\Temp\testing" -DriveSize 200GB -DriveLetter "T"

.PARAMETER Drive Path
    This optional parameter specifies the path that the VHDX file will be saved to. A default path of 'C:\ProgramData\Custom Dev Drive' is provided.

.PARAMETER Drive Letter
    This optional parameter defines the drive letter that the Dev Drive will be mounted to. A default letter of 'V' is provided.

.PARAMETER Drive Size
    This optional parameter defines the maximum size of the Dev Drive's dynamically sized volume. A default size of '100GB' is provided.

#>

# Define parameters and their defaults
param([string]$DrivePath = "C:\ProgramData\Custom Dev Drive",
      [string]$DriveSize = "100GB",
      [string]$DriveLetter = "V"
)

# Parse drive size
function Convert-ToMegabytes {
    param (
        [string]$sizeString
    )
    # Extract the numeric part of the size string
    $number = [double]($sizeString -replace '[^\d.]+')
    # Determine the unit (GB, TB, MB) and convert accordingly
    switch -Regex ($sizeString) {
        'MB' {
            $numberInMB = $number
            break
        }
        'GB' {
            $numberInMB = $number * 1024
            break
        }
        'TB' {
            $numberInMB = $number * 1024 * 1024
            break
        }
        default {
            throw "Unsupported unit. Please use MB, GB, or TB."
        }
    }
    return $numberInMB
}
$SizeInMB = Convert-ToMegabytes -sizeString $DriveSize

# Test to make sure we don't already have a Dev Drive overlapping with the provided configuration
if (Test-Path "$DrivePath\drive.vhdx") {
  Write-Warning "ERROR: $DrivePath\drive.vhdx already exists! Aborting..."
  exit 1
}
if (Test-Path "${DriveLetter}:") {
  Write-Warning "ERROR: Drive letter ${DrivePath}: is already in use! Aborting..."
  exit 1
}

# Set up diskpart script with the provided parameters or defaults
Write-Output "[*] Setting disk configuration settings..."
Write-Output "create vdisk file='${DrivePath}\drive.vhdx' maximum=$SizeInMB type=expandable" | Out-File -Encoding ascii -FilePath C:\Temp\diskpart_devdrive.txt
Write-Output "select vdisk file='${DrivePath}\drive.vhdx'" | Out-File -Encoding ascii -Append -FilePath C:\Temp\diskpart_devdrive.txt
Write-Output "attach vdisk" | Out-File -Encoding ascii -Append -FilePath C:\Temp\diskpart_devdrive.txt
Write-Output "create partition primary" | Out-File -Encoding ascii -Append -FilePath C:\Temp\diskpart_devdrive.txt
Write-Output "format fs=refs label='Dev Drive' quick" | Out-File -Encoding ascii -Append -FilePath C:\Temp\diskpart_devdrive.txt
Write-Output "assign letter=${DriveLetter}" | Out-File -Encoding ascii -Append -FilePath C:\Temp\diskpart_devdrive.txt

# Create the Dev Drive
Write-Output "[*] Creating Dev Drive..."
if (!(Test-Path "$DrivePath")) {
  mkdir $DrivePath
}
diskpart /s C:\Temp\diskpart_devdrive.txt
Format-Volume -DriveLetter $DriveLetter -DevDrive

# Make sure disk was created successfully
if (!(Test-Path "${DriveLetter}:")) {
  Write-Warning "ERROR: Failed to create ReFS vdisk for Dev Drive..."
  exit 1
}

# Output Dev Drive trusted status (should be trusted by default)
Write-Output "[*] Verifying Dev Drive trust..."
fsutil devdrv query ${DriveLetter}:

# Label Dev Drive
cd ${DriveLetter}:
label Dev Drive

# Setup scheduled task to re-mount dev drive after reboots
$Script = "diskpart.exe /s '$DrivePath\devdrivetask.txt' > '$DrivePath\tasklog.txt'"
Write-Output "select vdisk file='$DrivePath\drive.vhdx'" | Out-File -Encoding ascii -FilePath $DrivePath\devdrivetask.txt
Write-Output "attach vdisk" | Out-File -Encoding ascii -Append -FilePath $DrivePath\devdrivetask.txt

Write-Output $Script | Out-File -Encoding ascii -FilePath $DrivePath\devdrivetask.ps1
Write-Output "cd ${DriveLetter}:" | Out-File -Encoding ascii -Append -FilePath $DrivePath\devdrivetask.ps1
Write-Output "label Dev Drive" | Out-File -Encoding ascii -Append -FilePath $DrivePath\devdrivetask.ps1

$taskname = "Mount Dev Drive"
$taskdescription = "Make sure Dev Drive is mounted after reboots"
$taskTrigger = New-ScheduledTaskTrigger -AtStartup
$taskAction = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass .\devdrivetask.ps1" -WorkingDirectory $DrivePath
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName $taskname -Description $taskdescription -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings -User "System"

# Cleanup
Write-Output "[*] Cleaning up..."
Remove-Item C:\Temp\diskpart_devdrive.txt


Write-Output "[*] Done."
