# PowerShell

# https://massgrave.dev/
# https://github.com/massgravel/Microsoft-Activation-Scripts


irm https://get.activated.win | iex
irm https://massgrave.dev/get | iex

get-alias iex	# Invoke-Expression
get-alias irm	# Invoke-RestMethod
get-alias iwr	# Invoke-WebRequest

# download file:
Invoke-WebRequest $url -OutFile c:\file.ext
Invoke-RestMethod $url -OutFile $path_to_file
(New-Object System.Net.WebClient).DownloadFile($url, $path_to_file)

# Unlocl files
Get-ChildItem -Recurse | Unblock-File


Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# add to Path
$env:PSModulePath = "$(Get-Location)$([IO.Path]::PathSeparator)${env:PSModulePath}"

# ---------------------------------------------------------------------------------------------------

Get-Verb
Get-Command
Get-Help
Get-Member

Get-Command -Noun alias*
Get-Command -Verb Get -Noun alias*

Get-Command -Noun File*
Get-Command -Verb Get -Noun File*

gcm

dir | Out-File dir.txt
dir | Out-File dir.txt -append
dir | Out-Gridview

Get-Service | Export-Csv Service.Csv
Get-Service | ConvertTo-Html | Out-File Services.Html

Get-Module -ListAvailable
Import-Module ActiveDirectory
Get-Command -Module ActiveDirectory

Help get-AdDomanin
Help Get-Process -Full

Get-Service | Get-Member

Get-ChildItem | Get-Member
Get-ChildItem 'D:\Temp' | Sort-Object LastWriteTime
Get-ChildItem | Sort-Object LastAccessTime -Descending
dir | Sort-Object LastAccessTime
dir | Sort-Object LastAccessTime -Descending

# ComputerName is a new created property
Get-AdComputer -filter * | select *,@{name='ComputerName';expression={$_.name}} | Get-Process


Get-WmiObject -class win32_operatingSystem | fl *
Get-WmiObject -class win32_operatingSystem | gm
Get-WmiObject -class win32_operatingSystem  | select -Property Caption,BuildNumber,__Server,@{name='LastBoot';expression={$_.ConvertToDateTime($_.LastBootUpTime)}}


Get-ChildItem * | select *,@{name='ComputerName';expression={$_.name}}
Get-ChildItem * | select @{name='FileName';expression={$_.name}}

Get-WmiObject -class win32_bios -ComputerName (Get-AdComputer -filter * | select -expand name)


Import-Csv users.csv
Import-Csv users.csv | select Name,Department,City,@{name='Title';expression={$_.'Job Title'}}

gci | format-list -property name,length

gci | format-table -property length,name



Get-Service | where-object { $_.Status -eq 'Running' }
get-Service | where-object { $_.Status -eq 'Running' -and $_.name -like '*host*' }
get-Service | where-object { $_.Status -ne 'Running' -and $_.name -like '*host*' }

Get-Service | Sort Name | where { $_.Status -eq 'Running' }
Get-Service | where { $_.Status -eq 'Running' }
Get-Service -name c*

Get-Process | where-object { $_.Name -eq 'svchost' }
Get-Process -name svchost


help about_comp*
5 -gt 10

'start' -eq 'START'
'start' -ceq 'START'

10 + 20
1kb
1gb
12345 / 1mb

# Remoting

Enable-PSRemoting
Invoke-Command -computer localhost -scriptblock { dir }

Invoke-Command -scriptblock { Get-Service } -computer server1,server2

Enter-PSSession -ComputerName server1
Exit-PSSession



Get-WmiObject -class win32_bios
Get-WmiObject -class win32_process

# to discover the new property names.
Get-CIMClass
Get-CIMInstance -class win32_bios
Get-CIMInstance -class win32_logicaldisk -filter "deviceId='C:'"
Get-CIMInstance -class win32_logicaldisk -filter "deviceId LIKE 'C%'"

# Primaltools.com

#jobs

Invoke-Command -scriptblock { Get-WmiObject -class win32_process } -computer server1, server2 -AsJob

Get-Job
Get-job -id 3 | select -ExpandProperty ChildJobs
Receive-Job -id 4

help Start-Job

Start-Job -Command { Get-EventLog -Logname security -newest 200 }
Get-Job
Receive-Job -id 1
Get-Job

Receive-Job -id 1 -keep
Remove-Job -id 2

Invoke-Command -scriptblock { Get-EventLog -Logname security -newest 200 } -computer server1,server2 -AsJob -JobName SecurityLog

Get-job

# slow
Get-WmiObject -class win32_process -computer server1,server2
# faset
Invoke-Command -scriptblock { Get-WmiObject -class win32_process } -computer server1,server2 -AsJob -JobName SecurityLog

Get-Service -name w3p* | Stop-Service

# certificates
cd cert:
cd .\\Currentuser\
cd .\My\


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


# Variables

get-Command -noum variable
dir Variable:
cd Variable:

dir function:
dir variable:

# --- Debug variables ---
Get-Variable -Scope 0
Get-Variable -Include *Path,test*,stude*,J*,*fol*


Get-PSDrive

# Get Properties
Get-Service -Name w32time | Get-Member
Get-Service -Name w32time | Select-Object -Property *



5 | Get-Member
5.5 | Get-Member

"hello" | Get-Member
"hello".replace('lo','p')

# outer " that matters
$a = 'World'
$b = "select * from table where col = '$a'"

help *escape*

# declare type
[int]$c = 5


# arrays
$svc = get-Service
$svc[0]
$svc[0].name


$a = 1,2,3,4,5
$a[0]

$a = @(1,2,3,4,5)

$a.GetType()
$a[0].GetType()

# output
Write-Output # pipeline, input for next command
Write-Host # console/screen only - result text, colors

Write-Output "Hello","World","Don","PowerShell" | where { $_.length -gt 6 }
PowerShell

Write-Host "Hello","World","Don","PowerShell" | where { $_.length -gt 6 }
Hello World Don PowerShell

# screen
Write-Host
Read-Host "enter name"


# to show debug (begining of the script)
$DebugPreference = "Continue"
Write-Debug "debug $var"

#---------------------------------------------------------------------------------------------------
# https://go.microsoft.com/fwlink/?LinkID=225750
# prompt
gc function:prompt

Get-Command Prompt
(Get-Command Prompt).ScriptBlock
(Get-Item function:prompt).ScriptBlock

function prompt {$null}
PS>

# PowerShell includes a built-in Prompt function.
function prompt {
  "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
  # .Link
  # https://go.microsoft.com/fwlink/?LinkID=225750
  # .ExternalHelp System.Management.Automation.dll-help.xml
}

function prompt { }
function prompt {"PS [$env:COMPUTERNAME]> "}
function prompt {"$(Get-Date)> "}

# operators

1234.123 -as [int]
123 -is [int]
123.09 -is [int]

"Hello" -replace "lo","p"
Help


$host.privatedata.ErrorForegroundColor = 'Green'


# jobs

# Below are two different ways to do a WMI Query as a job:

Get-WMIObject Win32_OperatingSystem -AsJob

Start-Job {Get-WMIObject Win32_OperatingSystem}

# After the job has been kicked off, you can check on the status of the job by running the Get-Job command, noting the State and HasMoreData values. The State will change to Completed when the job has finished and the  HasMoreData value will indicate if there is output.

Get-Job

# Once the job has completed, you can use the Receive-Job cmdLet to get the data from the command.

Receive-Job -Id 3       # NOTE, you could also do -Name Job3 here, either will work

# The important thing to remember here is that you have one chance to get the information from the job so make sure that you capture it in a variable if the output needs to be evaluated.

$JobOutput = Receive-Job -Id 1

# Once you are done getting the job’s output, the job will basically hang out there until you remove it by running the Remove-Job Cmdlet.

Remove-Job -Id 1


#---------------------------------------------------------------------------------------------------
# -ReadCount <Int64>
# Specifies how many lines of content are sent through the pipeline at a time. The default value is 1. A value of 0 (zero) sends all of the content at one time.
# This parameter does not change the content displayed, but it does affect the time it takes to display the content. As the value of ReadCount increases, the time it takes to return the first line increases, but the total time for the operation decreases. This can make a perceptible difference in very large items.

get-content myfile.txt -ReadCount 1000 |  foreach { $_ -match "my_string" }

gc myfile.txt | % { if($_ -match "my_string") {write-host $_}}

gc .\Tokens-stage-XELPERF-00001_01000-stage-out.csv | % { if($_ -match "unauthorized") {write-host $_}}

gci *-out.csv | gc | % { if($_ -match "unauthorized") {write-host $_}}


# Open all files

gci index.html -recurse | % { start $_.fullname }


#---------------------------------------------------------------------------------------------------
# Rename files

gci *.pdf | rename-item -newname { $_.Name -replace " \(.\)","" }

gci *.sql | select Name | % { $_.Name -replace "_FKs.sql","" } | clip

---------------------------------------------------------------------------------------------------
# Test RDP
Test-NetConnection -Port 3389 godzilla.local

