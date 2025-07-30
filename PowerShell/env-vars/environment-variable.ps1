# Powershell environment variable:

# show all
gci env:* | sort-object name

gci Env:*
ls Env:


$env:Path = "SomeRandomPath";             (replaces existing path)
$env:Path += ";SomeRandomPath"            (appends to existing path)

$env:Path

$env:Path -split(";")


PS> Get-PSProvider -PSProvider Environment
PS> Get-ChildItem -Path Env:\
PS> Set-Location -Path Env:\
PS> Get-ChildItem -Path COMPUTERNAME
PS> [System.Environment]::GetEnvironmentVariable('PATH','machine')
PS> [System.Environment]::SetEnvironmentVariable('FOO', 'bar',[System.EnvironmentVariableTarget]::Machine)

# Unlike Windows, environment variable names on macOS and Linux are case-sensitive.
# For example, $env:Path and $env:PATH are different environment variables on non-Windows platforms.

dir env:
$env:path -split ";"

$env:Path                             # shows the actual content
$env:Path = 'C:\foo;' + $env:Path     # attach to the beginning
$env:Path += ';C:\foo'                # attach to the end

$env:PATH = "SomeRandomPath";             (replaces existing path)
$env:PATH += ";SomeRandomPath"            (appends to existing path)
