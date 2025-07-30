Powershell
-------------------------------------------------------------------------------------------------------------------------------
Merge files:

cd C:\Workspace\CMS\Database\StoredProcedures
Get-Content .\dataset*.sql | Out-File C:\temp\Combined1.sql

-------------------------------------------------------------------------------------------------------------------------------
Environment Variables:

    linux & mac: export NODE_ENV=production
    windows: $env:NODE_ENV = 'production'

-------------------------------------------------------------------------------------------------------------------------------

nbtstat -a 192.168.1.50
ping -a 209.85.229.106
nslookup 192.168.1.50

FOR /F "tokens=2 delims= " %A in ('2^>NUL NSLOOKUP "%IP_ADDRESS%" ^| FINDSTR /C:":    "') do ECHO %A

Within a script:

FOR /F "tokens=2 delims= " %%A in ('2^>NUL NSLOOKUP "%IP_ADDRESS%" ^| FINDSTR /C:":    "') do ECHO %%A


psexec \192.168.0.65 hostname
merge files:
C:\Workspace\_tmp_txt\merge-files.ps1

Get-History
Clear-History

ALT+F7

# show path
$env:PSModulePath -split ";"

# show var
$Env:<variable-name>
$Env:windir

# set var
$Env:<variable-name> = "<new-value>"
$Env:Foo = 'An example'
$Env:JAVA_HOME="C:\Progra~1\Java\jdk1.8.0_XX"
$Env:JRE_HOME="C:\Progra~2\Java\jre1.8.0_333"

Because an environment variable cant be an empty string, setting one to $null or an empty string removes it. For example:

$Env:Foo = ''
$Env:Foo | Get-Member -MemberType Properties

[Environment]::SetEnvironmentVariable('Foo','')
[Environment]::SetEnvironmentVariable('Foo','Bar')
[Environment]::GetEnvironmentVariable('Foo')

# get vars
Get-ChildItem -Path Env:


# powershell

$Env:JAVA_HOME="C:\Progra~1\Java\jdk-18.0.1.1"
$Env:JRE_HOME="C:\Progra~2\Java\jre1.8.0_333"

# cmd
setx -m JAVA_HOME "C:\Progra~1\Java\jdk1.8.0_XX"
echo %JAVA_HOME%



cd C:\Workspace\CMS\Database\StoredProcedures
Get-Content .\dataset*.sql | Out-File C:\temp\dataset-sprocs.sql

cd C:\Workspace\CMS\Database\Tables
Get-Content .\dataset*.sql | Out-File C:\temp\dataset-tables.sql

# Here is a solution that will generate a combined file with a blank line separating the contents of each file.
# If you'd prefer you can include any character you want within the "" in the foreach-object loop.

Get-ChildItem d:\scripts -include *.txt -rec | ForEach-Object {Get-Content $_; ""} | Out-File d:\scripts\test.txt


what is Program Files\Intel\SUR\QUEENCREEK\Updater\bin
USER_ESRV_SVC_QUEENCREEK

Eclipse Temurin JRE with Hotspot 8u302-b08 (x86) version 8.0.302.8

C:\Program Files\Intel\SUR\QUEENCREEK\Updater\bin
C:\Program Files\Intel\SUR\QUEENCREEK\Updater\bin

grpconv -o


shutdown.exe /s /t 0

To restart, use this command-line or shortcut:

shutdown.exe /r /t 0


GlobalProtect
Gateway External Gateway
The network connection is unreliable and GlobalProtect reconnected using an alternate method.
You may experience slowness when accessing the internet or business applications.

	http://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA14u0000001Uh1CAE&lang=en_US%E2%80%A9



Powershell

$HOME/.azuredatastudio/extensions/ms-vscode.PowerShell-<version>/examples

PS C:\Users\jonatas\.azuredatastudio\extensions\microsoft.powershell-2021.12.0\examples>

---------------------------------------------------------------------------------------------------
Powershell environment variable:

$env:Path = "SomeRandomPath";             (replaces existing path)
$env:Path += ";SomeRandomPath"            (appends to existing path)

$env:Path
$env:Path -split(";")

PS> Get-ChildItem -Path Env:\
PS> Set-Location -Path Env:\

    linux & mac: export NODE_ENV=production
    windows: $env:NODE_ENV = 'production'

-------------------------------------------------------------------------------------------------------------------------------
In find box then:
\n\n

In replace box:
\n

This should make two consecutive end of line signs into one.
If you need to replace more empty lines (more than two) at once, you can use following regular expression in find box:

\n+

If you need to replace also empty lines with whitespaces, then you need to use following regular expression in find box:

\n+\s*\n

empty line:
	^(\s)*$\n
	^\s*$\n

-------------------------------------------------------------------------------------------------------------------------------
netstat -aon | findstr ":80"
netstat -aon | findstr ":443"


Skype:
get-appxpackage -AllUsers Microsoft.SkypeApp | foreach { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }

uninstall-package 'Microsoft Skype for Business MUI (English) 2016'

Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage

Get-ChildItem -Path "C:\Program Files\Microsoft Office\root\Office16\*lync*" -Recurse | Remove-Item

C:\Program Files\Microsoft Office\root\Office16


Notepad session:
C:\Users\jonatas\AppData\Roaming\Notepad++\session.xml


-------------------------------------------------------------------------------------------------------------------------------

write-host " ----------------------------"
$work = "$env:WORKSPACE"
$source = "$work\content\translations\*"
$dest = "\\source\folder\"

write-output "workspace: $work"
write-output "source: $source"
write-output "dest: $dest"

Copy-Item -Filter *.json -Path $source -Destination $dest -Force -verbose

-------------------------------------------------------------------------------------------------------------------------------

/* PowerShell:

Get-Content .\School_UG_*.sql | Out-File C:\temp\Combined.sql

Get-Content .\School_UG*.sql | Out-File C:\temp\Combined.sql

Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "SQLCopTests" -Query "EXEC tsqlt.NewTestClass @ClassName = N'SQLCop'"

$FolderPath = Get-Location
foreach ($filename in Get-ChildItem -Path $FolderPath -Filter "*.sql") { Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "SQLCopTests" -InputFile $filename}

*/

-------------------------------------------------------------------------------------------------------------------------------

Update, if you have npm v5, use npx:

npx rimraf ./**/node_modules

Otherwise install RimRaf:

npm install rimraf -g

And in the project folder delete the node_modules folder with:

rimraf node_modules

If you want to recursively delete:

rimraf .\**\node_modules


RMDIR /Q/S node_modules

DELETE only by using DOS command without any installation:

Create an empty folder "test" on C or D drive and use following DOS command

robocopy /MIR c:\test D:\UserData\FolderToDelete > NUL

After completing above command, your folder will be empty, now you can delete the folder.


I used GitBash to remove de folder!

rm -r node_modules

RD node_modules

For deleting all node_modules folders in a folder with multiple projects use :

rm -r ./**/node_modules

-------------------------------------------------------------------------------------------------------------------------------

remove tag:
sed -i '/<b>/,/<\/b>/d' foo.xml


Try this (assuming xml is in a file named foo.xml):

sed -i '/<b>/,/<\/b>/d' foo.xml

-i will write the change into the original file (use -i.bak to keep a backup copy of the original)

This sed command will perform an action d (delete) on all of the lines specified by the range

# all of the lines between a line that matches <b>
# and the next line that matches <\/b>, inclusive
/<b>/,/<\/b>/

So, in plain English, this command will delete all of the lines between and including the line with <b> and the line with </b>

If you''d rather comment out the lines, try one of these:

# block comment
sed -i 's/<b>/<!-- <b>/; s/<\/b>/<\/b> -->/' foo.xml

# comment out every line in the range
sed -i '/<b>/,/<\/b>/s/.*/<!-- & -->/' foo.xml


-------------------------------------------------------------------------------------------------------------------------------

chkdsk D: /f /r /x

Fix USB Drive tools
	http://rmprepusb.com/

-------------------------------------------------------------------------------------------------------------------------------

Windows Update:
Since the issue is related to Windows Update service, you could try the following steps to have a test:

1. Stop the Automatic Updates service (net stop wuauserv)
2. Rename/delete the \SoftwareDistribution folder (%windir%\SoftwareDistribution) on the Server
3. Start the Automatic Updates service (net start wuauserv)
4. Run "wuauclt /detectnow"

DISM.exe /Online /Cleanup-image /Restorehealth
DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess

sfc /scannow


Git Rebuild:
	git commit --allow-empty
	git commit --allow-empty -m "trigger build"


Remove empty lines:

Visual Studio
	^\s*$\n

VsCode empty line:
	^(\s)*$\n


Replace GrepWin
	\[School\]\.\[(.+)\]
	School.$1

use shortcut


    Open Tools > Options or press Alt + T + O
    Under Environment tab > Keyboard
    Search for "DeleteBlank" and select Edit.DeleteBlankLines
    Add a new shortcut for example Ctrl+D,Ctrl+E
    Assign > OK

-------------------------------------------------------------------------------------------------------------------------------

net time

w32TM /config /syncfromflags:manual /manualpeerlist:ntp.indiana.edu

w32tm /config /update

w32tm /resync

To synchronize the time on your Windows computer with the Indiana University Active Directory domain controllers,
run the following command as an administrator at a command prompt:

net time \\ads.iu.edu /set /y

net time \\domain.local /set /y


http://woshub.com/managing-open-files-windows-server-share/


Shares and Open Files:

Computer Management (compmgmt.msc) graphic snap-in.

openfiles /Query /fo csv |more
openfiles /Query /s lon-fs01 /fo csv
openfiles /Query /s lon-fs01 /fo csv | find /i "filename.docx"
openfiles /Query /s lon-fs01 /fo csv | find /i "sale_report"| find /i "xlsx"

openfiles /Query /s lon-fs01 /fo csv | find /i "farm"| find /i ".xlsx"
openfiles /Disconnect /s lon-fs01 /ID 617909089
Disconnect the user from file using the received SMB session ID:
openfiles /Disconnect /s lon-fs01 /ID 617909089
Openfiles - Disconnect user by session id
You can forcefully reset all sessions and unlock all files opened by a specific user:
openfiles /disconnect /s lon-fs01/u corp\mjenny /id *

Get-SMBOpenFile

You can display a list of open files with user and computer names (IP addresses):

Get-SmbOpenFile|select ClientUserName,ClientComputerName,Path,SessionID

powershell: list smb open files with usernames

You can list all files opened by a specific user:

Get-SMBOpenFile –ClientUserName "corp\mjenny"|select ClientComputerName,Path

or from a specific computer/server:

Get-SMBOpenFile –ClientComputerName 192.168.1.190| select ClientUserName,Path

You can display a list of open files by pattern. For example, to list all exe files opened from the shared folder:

Get-SmbOpenFile | Where-Object {$_.Path -Like "*.exe*"}

or open files with a specific name:

Get-SmbOpenFile | Where-Object {$_.Path -Like "*reports*"}

The Close-SmbOpenFile cmdlet is used to close the open file handler. You can close the file by ID:

Close-SmbOpenFile -FileId 4123426323239

But it is usually more convenient to close the file by name:

Get-SmbOpenFile | where {$_.Path –like "*annual2020.xlsx"} | Close-SmbOpenFile -Force

With the Out-GridView cmdlet, you can make a simple GUI form for finding and closing open files. The following script will list open files. You should use the built-in filters in the Out-GridView table to find open files for which you want to reset the SMB sessions. Then you need to select the required files and click OK. As a result, the selected files will be forcibly closed.

Get-SmbOpenFile|select ClientUserName,ClientComputerName,Path,SessionID| Out-GridView -PassThru –title “Select Open Files”|Close-SmbOpenFile -Confirm:$false -Verbose

powershell gui script to close open files using out-gridview
How to Close Open Files on Remote Computer Using PowerShell?

The Get-SMBOpenFile and Close-SmbOpenFile cmdlets can be used to remotely find and close open (locked) files. First, you need to connect to a remote Windows SMB server via a CIM session:

$sessn = New-CIMSession –Computername lon-fs01
You can also connect to a remote server to run PowerShell commands using the PSRemoting cmdlets: Enter-PSSession or Invoke-Command.

The following command will find the SMB session for the open file pubs.docx and close the file session.

Get-SMBOpenFile -CIMSession $sessn | where {$_.Path –like "*pubs.docx"} | Close-SMBOpenFile -CIMSession $sessn

Confirm closing of the file by pressing Y. As a result, you have unlocked the file. Now other users can open it.

PowerShell Get-SMBOpenFile - Close-SMBOpenFile
To remove the confirmation of force closing a file on a SMB server, use the -Force key.

With PowerShell, you can close SMB sessions and unlock all files that a specific user has opened (a user went home and didn’t release the open files). For example, to reset all file sessions of the user mjenny, run this command:

Get-SMBOpenFile -CIMSession $sessn | where {$_.ClientUserName –like "*mjenny*"}|Close-SMBOpenFile -CIMSession $sessn


