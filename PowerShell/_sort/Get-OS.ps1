# Get OS

# Step 2. To check operating system name.
(Get-WMIObject win32_operatingsystem).name
# Step 3. To check if the operating system is 32-bit or 64-bit.
(Get-WmiObject Win32_OperatingSystem).OSArchitecture
# Step 4. To check machine name.
(Get-WmiObject Win32_OperatingSystem).CSName

Get-ChildItem -Path Env:
Get-ChildItem -Path Env:OS	# Windows_NT

$isLinux = $PSVersionTable.Platform -match '^(Linux|Unix)'
$isWin = $PSVersionTable.Platform -match '^(Windows)'

$separator = If ($isWin) {"\"} Else {"/"}

#linux
$PSVersionTable.Platform
OS                             Linux 5.11.0-34-generic #36-Ubuntu SMP Thu Aug 26 19:22:09 UTC 2021
Platform                       Unix

#windows
$PSVersionTable.Platform
""

[IO.Path]::DirectorySeparatorChar

$IsMacOS
$IsLinux
$IsWindows

	if ($IsWindows) {
		write-host "Eh windows!"
	}
	if ($IsLinux -eq $True) {
		write-host "Eh linux!"
	}
	return

function Get-OS {
	if $PSVersionTable.Platform -match '^(Linux|Unix)' -or $PSVersionTable.OS -match '^(Linux|Unix)'
		return "Linux"
	else
		return "Windows"
}
function isOSLinux {
	return $PSVersionTable.Platform -match '^(Linux|Unix)' -or $PSVersionTable.OS -match '^(Linux|Unix)'
}
function isOSWindows {
	return $PSVersionTable.OS -match '^(Windows)'
}

function get-OS {
	$isWin = $PSVersionTable.Platform -match '^($|(Microsoft )?Win)'
	$separator = If ($isWin) {"\"} Else {"/"}
	return $separator
}

function Get-OS{
	if (isLinux -eq $True)
		return "Linux"
}
function Get-OsSep {
	$isWin = $PSVersionTable.Platform -match '^($|(Microsoft )?Win)'
	$separator = If ($isWin) {"\"} Else {"/"}

	return $separator
}
function Get-Sep {
	return [IO.Path]::DirectorySeparatorChar
}
function Get-DbaPathSep {
    <#
    Gets the instance path separator, if exists, or return the default one
    #>
    [CmdletBinding()]
    param (
        [object]$Server
    )

    $pathSep = $Server.PathSeparator
    if ($pathSep.Length -eq 0) {
        $pathSep = '\'
    }
    return $pathSep
}
function Test-HostOSLinux {
    param (
        [object]$SqlInstance,
        [object]$SqlCredential
    )

    $server = Connect-SqlInstance -SqlInstance $SqlInstance -SqlCredential $SqlCredential
    $server.ConnectionContext.ExecuteScalar("SELECT @@VERSION") -match "Linux"
}
