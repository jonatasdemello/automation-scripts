
Get-Item Path1\* | Move-Item -Destination Path2

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.pdf','1.pdf' } | Move-Item -Destination Path2

Get-ChildItem | rename-item -NewName { $_.Name -replace '_1','' }


"Hello World" | Get-Member

Measure-Object

To get the summary information about a specific command, specify the command name
as an argument:
Get-Command CommandName
To get the detailed information about a specific command, pipe the output of Get-
Command to the Format-List cmdlet:
Get-Command CommandName | Format-List

Get-Command *text*
To search for all commands that use the Get verb, supply Get to the -Verb parameter:
Get-Command -Verb Get
To search for all commands that act on a service, use Service as the value of the -Noun
parameter:
Get-Command -Noun Service


Get-Help CommandName
or:
CommandName -?
-Detailed
-Full
-Examples
-Online
-ShowWindow


Get-History
Invoke-History ID
Clear-History



Get-Process | Where-Object WorkingSet -gt 500kb | Sort-Object -Descending Name

lee@trinity:~$ ps -F | awk '{ if($5 > 500) print }' | sort -r -k 64,70


Get-Process | Where-Object { $_.Name -like "*Search*" }

1..10 | Foreach-Object { $_ * 2 }

To run a program on each file in a directory, use the $_ (or $PSItem) variable as a
parameter to the program in the script block parameter:

Get-ChildItem *.txt | Foreach-Object { attrib -r $_ }


$myArray = 1,2,3,4,5
$sum = 0
$myArray | Foreach-Object { $sum += $_ }
$sum
You can simplify this to:
$myArray | Foreach-Object -Begin { $sum = 0 } -Process { $sum += $_ } -End { $sum }

can simplify even further to:
$myArray | Foreach-Object { $sum = 0 } { $sum += $_ } { $sum }



Get-Process | Foreach-Object { $_.Name }

In PowerShell version 3, the Foreach-Object cmdlet (and by extension its % alias) was
extended to simplify property and method access dramatically:

Get-Process | Foreach-Object Name
Get-Process | % Name | % ToUpper


-------------------------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------------------------
Write-Host Colors

-BackgroundColor
-ForegroundColor

Black   , DarkBlue   , DarkGreen , DarkCyan,
DarkRed , DarkMagenta, DarkYellow, Gray    ,
DarkGray, Blue       , Green     , Cyan    ,
Red     , Magenta    , Yellow    , White


$colors = [enum]::GetValues([System.ConsoleColor])
Foreach ($bgcolor in $colors){
    Foreach ($fgcolor in $colors) {
		Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine
	}
    #Write-Host " on $bgcolor"
}
# -------------------------------------------------------------------------------------------------------------------------------

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }

# Powershell Unlock all files
get-childitem | unblock-file
get-childitem "C:\Users\winaero\Downloads" | unblock-file


# Powershell Strings:
	One way is:  	Write-Host "$($assoc.Id)  -  $($assoc.Name)  -  $($assoc.Owner)"
	Another one is:	Write-Host  ("{0}  -  {1}  -  {2}" -f $assoc.Id,$assoc.Name,$assoc.Owner )
	Or just :		Write-Host $assoc.Id  "  -  "   $assoc.Name  "  -  "  $assoc.Owner


Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "SQLCopTests" -Query "EXEC tsqlt.NewTestClass @ClassName = N'SQLCop'"

# -- To make this easier, I will execute each .sql file in my database with this short PoSh script

foreach ($filename in Get-ChildItem -Path $FolderPath -Filter "*.sql") { Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "SQLCopTests" -InputFile $filename}

# -- This doesn’t report any results on the screen, though errors would be shown.

Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "SQLCopTests" -Query "EXEC tSQLt.RunAll"

foreach ($filename in Get-ChildItem -Path $FolderPath -Filter "*.sql") { Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "DB_test" -InputFile $filename}



az vmss nic list --resource-group "prod-rg"  --vmss-name "machine" -o json --query "[].ipConfigurations[].privateIpAddress"



join multiple files in one add text powershell


C:\Windows\explorer.exe shell:::{2559a1f2-21d7-11d4-bdaf-00c04f60b9f0}

VbScript:
************************************
Set objShell = CreateObject(“Shell.Application”)
objShell.WindowsSecurity
***********************************
ALTGR-END
In case you have a keyboard with the ALTGR-key, you may also use ALTGR+END to simulate CTRL-ALT-DELETE. I believe German keyboards in particuar have this key.


Net user
Assuming it’s a local user (so NOT a domain user account), you can use net user to change a users’ password. To do so:

Click Start -> Run (or press Win+R)
Type something like “net user $username $password”. I.e. if the user account is named Peter, you could reset its password by typing: net user Peter P@55w0rd.


Powershell: Set-ADAccountPassword
In case of a domain user account, you may use the Set-ADAccountPassword cmdlet in Powershell. Note that the Active Directory module must be loaded.

Set-ADAccountPassword -Identity Peter -NewPassword (Read-Host -Prompt “Provide New Password” -AsSecureString) -Reset


Set-ADAccountPassword -Identity elisada -OldPassword (ConvertTo-SecureString -AsPlainText "<password>" -Force) -NewPassword (ConvertTo-SecureString -AsPlainText "<password>" -Force)

Set-ADAccountPassword -Server 51.77.120.248 -Identity <user> -OldPassword (ConvertTo-SecureString -AsPlainText "<pass>" -Force) -NewPassword (ConvertTo-SecureString -AsPlainText "<password>" -Force)

Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)


Import-module ActiveDirectory


Powershell: Set-LocalUser
In case of a local user, you may use the Set-LocalUser cmdlet in Powershell to reset a local users’ password

Get-LocalUser ‘Peter’ | Set-LocalUser -Password (Read-Host -Prompt “Provide New Password” -AsSecureString)




az cli commands to find solr instance number and restart the service
	az vmss list-instances -n machine-solr1-ss -g machine-solr1-rg
	az vmss run-command invoke -g machine-solr1-rg -n machine-solr1-ss --scripts "Restart-Service -Name solr" --instance-id 5 --command-id RunPowerShellScript -o json

az cli command to restart all solr instances sequentially
	az vmss list-instances -n machine-solr1-ss -g machine-solr1-rg | select-string machine | %{$_.tostring().split()[0]} | %{az vmss run-command invoke -g machine-solr1-rg -n machine-solr1-ss --scripts "Restart-Service -Name solr" --instance-id $_ --command-id RunPowerShellScript -o json}


az vmss list-instances -g qalt-eastus-rg -n qalt-eastus-ss | %{
az vmss run-command invoke -g qalt-eastus-rg -n qalt-eastus-ss --scripts "Set-ExecutionPolicy Unrestricted; cd /workspace/loadtests;.\RunSingle.ps1 -currentEnv 'stage' -studentlogintokenscsvpath 'Stage-US_tokens.csv'; Write-Host 'done!!'" --instance-id $_.split()[0] --command-id RunPowerShellScript
}

.\RunSingle.ps1 -currentEnv 'stage' -studentlogintokenscsvpath 'Stage-US_tokens.csv'



Install-Module -Name PowerShellGet -Force


# PowerShell 7 installs to a new directory, enabling side-by-side execution with Windows PowerShell 5.1.

# Install locations by version:

    # Windows PowerShell 5.1: $env:WINDIR\System32\WindowsPowerShell\v1.0
    # PowerShell Core 6.x: $env:ProgramFiles\PowerShell\6
    # PowerShell 7: $env:ProgramFiles\PowerShell\7

# The new location is added to your PATH allowing you to run both Windows PowerShell 5.1 and PowerShell 7. If you're migrating from PowerShell Core 6.x to PowerShell 7, PowerShell 6 is removed and the PATH replaced.

# In Windows PowerShell, the PowerShell executable is named powershell.exe. In version 6 and above, the executable is named pwsh.exe. The new name makes it easy to support side-by-side execution of both versions.

# Separate PSModulePath

# By default, Windows PowerShell and PowerShell 7 store modules in different locations. PowerShell 7 combines those locations in the $Env:PSModulePath environment variable. When importing a module by name, PowerShell checks the location specified by $Env:PSModulePath. This allows PowerShell 7 to load both Core and Desktop modules.

# Separate PSModulePath

# Install Scope 	Windows PowerShell 5.1 	PowerShell 7.0

	PowerShell modules 	$env:WINDIR\system32\WindowsPowerShell\v1.0\Modules 	$PSHOME\Modules

	User installed
	AllUsers scope 		$env:ProgramFiles\WindowsPowerShell\Modules 			$env:ProgramFiles\PowerShell\Modules

	User installed
	CurrentUser scope 	$HOME\Documents\WindowsPowerShell\Modules 				$HOME\Documents\PowerShell\Modules

$Env:PSModulePath -split (';')

-------------------------------------------------------------------------------------------------------------------------------

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '0' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '0' -Type DWord


-------------------------------------------------------------------------------------------------------------------------------
To check your PowerShell version, run the command:

$PSVersionTable.PSVersion

Make sure you have the latest version of PowerShellGet

Install-Module -Name PowerShellGet -Force
Install-Module -Name PowerShellGet -Force -SkipPublisherCheck

Remove-Module PackageManagement -Force


# WARNING: The version '1.4.7' of module 'PackageManagement' is currently in use. Retry the operation after closing the applications.


	# Close PowerShell.
	# Really, close PowerShell. Open up Task Manager and find any background instances of PowerShell, as in either or both powershell.exe / pwsh.exe.
	# Delete the unwanted module folders from C:\Users\${USER}\Documents\PowerShell\Modules


# This is a dumb as hell issue to even have in the first place. My solution was:

	# Close all PowerShell sessions
	# Move the "PackageManagment" folder from $ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\PackageManagemnt to my desktop
	# Start a new PowerShell session
	# Make sure there isn't a PackageManagement version loaded from somewhere else with Get-Module
	# Manually import the PackageManagement module from my desktop: Import-Module .\PackageManagement.psd1
	# Then perform the operation I was looking for, in my case this was Install-Module PowershellGet -Force

# This operation now succeeds. Finally:

# Restore PackageManagement v1.4.7 to your user folder $ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\PackageManagemnt


#Install the Azure PowerShell module

if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}


https://www.thomasmaurer.ch/2019/02/update-powershellget-and-packagemanagement/

Update-Module
Get-Module
Get-Module -ListAvailable PackageManagement, PowerShellGet

Install-Module –Name PowerShellGet –Force
Exit

Set-ExecutionPolicy RemoteSigned

Update-Module -Name PowerShellGet
Exit

Install-Module –Name PowerShellGet –Force -AllowClobber



Get-Item Path1\* | Move-Item -Destination Path2

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.pdf','1.pdf' } | Move-Item -Destination Path2

Get-ChildItem | rename-item -NewName { $_.Name -replace '_1','' }


"Hello World" | Get-Member

Measure-Object

To get the summary information about a specific command, specify the command name
as an argument:
Get-Command CommandName
To get the detailed information about a specific command, pipe the output of Get-
Command to the Format-List cmdlet:
Get-Command CommandName | Format-List

Get-Command *text*
To search for all commands that use the Get verb, supply Get to the -Verb parameter:
Get-Command -Verb Get
To search for all commands that act on a service, use Service as the value of the -Noun
parameter:
Get-Command -Noun Service


Get-Help CommandName
or:
CommandName -?
-Detailed
-Full
-Examples
-Online
-ShowWindow


Get-History
Invoke-History ID
Clear-History



Get-Process | Where-Object WorkingSet -gt 500kb | Sort-Object -Descending Name

lee@trinity:~$ ps -F | awk '{ if($5 > 500) print }' | sort -r -k 64,70


Get-Process | Where-Object { $_.Name -like "*Search*" }

1..10 | Foreach-Object { $_ * 2 }

To run a program on each file in a directory, use the $_ (or $PSItem) variable as a
parameter to the program in the script block parameter:

Get-ChildItem *.txt | Foreach-Object { attrib -r $_ }


$myArray = 1,2,3,4,5
$sum = 0
$myArray | Foreach-Object { $sum += $_ }
$sum
You can simplify this to:
$myArray | Foreach-Object -Begin { $sum = 0 } -Process { $sum += $_ } -End { $sum }

can simplify even further to:
$myArray | Foreach-Object { $sum = 0 } { $sum += $_ } { $sum }



Get-Process | Foreach-Object { $_.Name }

In PowerShell version 3, the Foreach-Object cmdlet (and by extension its % alias) was
extended to simplify property and method access dramatically:

Get-Process | Foreach-Object Name
Get-Process | % Name | % ToUpper


$Env:PSModulePath -split (';')


Start-Process -FilePath notepad.exe -WorkingDirectory c:\temp


https://4sysops.com/archives/use-powershell-to-execute-an-exe/



Write-Host "App Pool Recycling Started...." -ForegroundColor Green
& $env:windir\system32\inetsrv\appcmd list apppools /state:Started /xml | & $env:windir\system32\inetsrv\appcmd recycle apppools /in
Write-Host "App Pool Recycling Completed" -ForegroundColor Green

Write-Host "App Pool Recycling Started...." -ForegroundColor Green
& $env:windir\system32\inetsrv\appcmd list apppools /state:Started /xml | & $env:windir\system32\inetsrv\appcmd recycle apppools /in
Write-Host "App Pool Recycling Completed" -ForegroundColor Green


cd C:\Windows\System32\inetsrv\
.\appcmd.exe list apppools /state:Started /xml | & .\appcmd.exe recycle apppools /in


& $psexec $serveraddr -u $remoteuser -p $remotepass -accepteula C:\Windows\System32\inetsrv\appcmd.exe list apppool /xml | C:\Windows\System32\inetsrv\appcmd.exe recycle apppool /in


#So the second part of the command is executed locally. I've changed the script to recycle every each pool by single commands:

& $psexec $server -u $remoteuser -p $remotepass -accepteula C:\Windows\System32\inetsrv\appcmd.exe recycle apppool /apppool.name:Core1

IIS:\>Get-WebAppPoolState DefaultAppPool
IIS:\>Restart-WebAppPool DefaultAppPool


# recycle iis
Import-Module WebAdministration
Get-Item iis:\\apppools\* | % {Restart-WebAppPool $_.Name}

Dump:
Powershell -c rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump {ID-of-the-process} $Env:TEMP\my_dump_file.bin full

show  Wifi

netsh wlan show interfaces

(netsh wlan show interfaces) -Match '^\s+Signal' -Replace '^\s+Signal\s+:\s+',''


[object]$paramObj=Get-Content "C:\workspace\LoadTesting\environments.json" | ConvertFrom-Json





$server = "10.1.1.1"
$user = "jason"
$winpath = "X:\data\tables\"

# replace backslashes with slashes, colons with nothing,
# convert to lower case and trim last /
$nixPath = (($winpath -replace "\\","/") -replace ":","").ToLower().Trim("/")

"$user@$server/$nixpath"


$myPath -replace '\\','/'


Step 1. Open PowerShell with elevated privileges.

Step 2. To check operating system name.

(Get-WMIObject win32_operatingsystem).name

Step 3. To check if the operating system is 32-bit or 64-bit.

(Get-WmiObject Win32_OperatingSystem).OSArchitecture

Step 4. To check machine name.

(Get-WmiObject Win32_OperatingSystem).CSName




#Aren't there environment variables you can view on the other platforms for the OS?

Get-ChildItem -Path Env:

#Particularly, on Windows at least, there's an OS environment variable, so you should be able to accomplish this by using $Env:OS.
#Since some time has passed and the PowerShell Core (v6) product is GA now (the Core branding has been dropped as of v7), you can more accurately determine your platform based on the following automatic boolean variables:

$IsMacOS
$IsLinux
$IsWindows

$PSVersionTable

Platform Win32NT OS Microsoft Windows 10.0.15063

PS C:\Users\LotPings> $PSVersionTable

OS                             Microsoft Windows 10.0.17134
Platform                       Win32NT

Platform Unix OS Linux (ubuntu)

PS /home/LotPings> $PSVersionTable

OS                             Linux 4.15.0-34-generic #37-Ubuntu SMP Mon Aug 27 15:21:48 UTC 2018
Platform                       Unix

Platform Unix OS Darwin

PS /Users/LotPings> $PSVersionTable

OS                             Darwin 17.7.0 Darwin Kernel Version 17.7.0: Thu Jun 21 22:53:14 PDT 2018; root:xnu-4570.71.2~1/RE...
Platform                       Unix

-------------------------------------------------------------------------------------------------------------------------------


az vm list-ip-addresses | select-string redis

az vm list-ip-addresses

az vm list-ip-addresses -g MyResourceGroup -n MyVm
az vm list-ip-addresses --ids $(az vm list -g MyResourceGroup --query "[].id" -o tsv)

az vm list-ip-addresses --ids $(az vm list -g *redis* --query "[].id" -o tsv)


az vm list-ip-addresses |  ConvertFrom-Json | Select $_.virtualMachine.network.privateIpAddresses


$x = az vm list-ip-addresses
$json.virtualMachine.network.privateIpAddresses

-------------------------------------------------------------------------------------------------------------------------------

{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountName": {
      "value": "sa01"
    },
    "virtualNetworkName": {
      "value": "nvn01"
    }
  }
}

<#
# Read in JSON from file on disk
$TemplateParametersFile = "C:\Temp\deploy-Project-Platform.parameters.json"
$content = Get-Content $TemplateParametersFile -Raw
#>

#Retrieve JSON file from Azure storage account.
$TemplateParametersFile = "https://{storageAccountName}.blob.core.windows.net/{SomeContainer}/deploy-Project-Platform.parameters.json"
$oWc = New-Object System.Net.WebClient
$webpage = $oWc.DownloadData($TemplateParametersFile)
$content = [System.Text.Encoding]::ASCII.GetString($webpage)

#Convert JSON file to an object (IMHO- Sort of!)
$JsonParameters = ConvertFrom-Json -InputObject $content

#Build hashtable - easier to add new items - the whole purpose of this script
$oDataHash = @{}
$JsonParameters.parameters | Get-Member -MemberType NoteProperty | ForEach-Object{
    $oDataHash += @{
        $_.name = $JsonParameters.parameters."$($_.name)" | Select -ExpandProperty Value
    }
}

#Example: adding a single item to the hashtable
$oDataHash.Add("VirtualMachineName","aDemoAdd")

#Convert hashtable to pscustomobject
$oData = New-Object -TypeName PSCustomObject

$oData | Add-Member -MemberType ScriptMethod -Name AddNote -Value {
    Add-Member -InputObject $this -MemberType NoteProperty -Name $args[0] -Value $args[1]
}

$oDataHash.Keys | Sort-Object | ForEach-Object{

    $oData.AddNote($_,$oDataHash.$_)
}

$oData
-------------------------------------------------------------------------------------------------------------------------------


Get-ChildItem -Path C:\Temp -Include *.* -File -Recurse | foreach { $_.Delete()}

# If you may have files without an extension, use instead.

Get-ChildItem -Path C:\Temp -Include * -File -Recurse | foreach { $_.Delete()}

# It appears the -File parameter may have been added after PowerShell v2. If that's the case, then

Get-ChildItem -Path C:\Temp -Include *.* -Recurse | foreach { $_.Delete()}

Remove-Item c:\Tmp\* -Recurse -Force


#Using PowerShell:

Get-ChildItem -Path c:\temp -Include * | Remove-Item -recurse

Get-ChildItem '.\FOLDERNAME' -include *.class -recurse | foreach ($_) {remove-item $_.FullName}


forfiles -p "c:\path\to\files" -d -60 -c "cmd /c del /f /q @path"

if ( Test-Path -Path 'C:\Windows' -PathType Container ) { "It's a container/folder/directory" }
#It's a container/folder/directory

if ( -not (Test-Path -LiteralPath 'C:\Windows' -PathType Leaf) ) { "It's not a leaf/file" }
#It's not a leaf/file

Clear-RecycleBin -Force


-------------------------------------------------------------------------------------------------------------------------------
# Foreach vs Foreach-Object

# ForEach (loop statement)
# ------------------------

# Use the ForEach statement when the collection of objects is small enough that it can be loaded into memory.
# Use the ForEach-Object cmdlet when you want to pass only one object at a time through the pipeline, minimising memory usage.
# In most cases ForEach will run faster than ForEach-Object, there are exceptions, such as starting multiple background jobs.
# If in doubt test both options with Measure-Command.

# The foreach statement does not use pipelining
# Loop through a set of input objects and perform an operation (execute a block of statements) against each.

	# ForEach [-Parallel] (item In collection) {ScriptBlock}

# Loop through an array of strings:

$trees = @("Alder","Ash","Birch","Cedar","Chestnut","Elm")
foreach ($tree in $trees) {
   "$tree = " + $tree.length
}

# Loop through a collection of the numbers, echo each number unless the number is 2:

foreach ($num in 1,2,3,4,5) {
  if ($num -eq 2) { continue } ; $num
}

# Loop through a collection of .txt files:

foreach ($file in get-ChildItem *.txt) {
    Echo $file.name
}

# ForEach-Object
# --------------

# Perform an operation (execute a block of statements) against each item in a collection of input objects,
# typically passed through the pipeline.

#    ForEach-Object [-process] ScriptBlock[] [-inputObject psobject]
#       [-begin scriptblock] [-end scriptblock] [-Parallel] [-ThrottleLimit n] [CommonParameters]

# Retrieve the files (and folders) from the C: drive and display the size of each:

PS C:> get-childitem C:\ | foreach-object -process { $_.length / 1024 }

# (The $_ variable holds a reference to the current item being processed.)

# Retrieve the 1000 most recent events from the system event log and store them in the $events variable:

PS C:> $events = get-eventlog -logname system -newest 1000

# Then pipe the $events variable into the ForEach-Object cmdlet.

PS C:> $events | foreach-object -begin {Get-Date} `
      -process {out-file -filepath event_log.txt -append -inputobject $_.message} `
      -end {get-date}

# -------------------------------------------------------------------------------------------------------------------------------
# PowerShell Pipeline

# A common scripting requirement is to loop through a collection of items (files, registry entries etc.)
# Pipelines provide an easy way to achieve this, for example consider the following script:

$a = Get-ChildItem *.txt
foreach ($file in $a) {
  if ($file.length -gt 100) {
	Write-Host $file.name
  }
}

# Rewriting this with a pipeline it becomes a one liner:

Get-ChildItem *.txt | where {$_.length -gt 100} | Format-Table name

# The commands will pass the necessary objects down the pipeline as part of a single operation.
# It is important to emphasise that these are full rich data objects not simple items of text as they would be in a unix shell.

# The $_ is a variable created automatically by PowerShell to store the current pipeline object.
# All properties of the pipeline object can be accecced via this variable.

-------------------------------------------------------------------------------------------------------------------------------

# Powershell
# https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/04-pipelines?view=powershell-7.3



Get-Service |
  Where-Object CanPauseAndContinue -eq $true |
    Select-Object -Property *



