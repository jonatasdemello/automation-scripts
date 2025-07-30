
npm cache clean --force
npm cache verify

dotnet nuget locals -h|--help
dotnet nuget locals all -l
dotnet nuget locals all --clear

# Clears all files in local global-packages cache directory:

dotnet nuget locals global-packages -c

# Clears all files in local temporary cache directory:

dotnet nuget locals temp -c

# slack cache

cacls "driveletter:\System Volume Information" /E /G username:F

cacls "c:\System Volume Information" /E /G jonatas:F

# This command adds the specified user to the folder with Full Control permissions.
# To remove the permission, execute:

cacls "driveletter:\System Volume Information" /E /R username

# Running the following command will show you what is stored in this directory:

vssadmin list shadowstorage

# Run the Disk Cleanup Wizard by pressing the Win + R keys and entering the command cleanmgr.exe;

cleanmgr.exe

C:\Windows\System32\DriverStore

# 1. Export the list of drivers in the table form to a text file using the command:

dism /online /get-drivers /format:table > c:\drivers.txt

# 2. Now you can delete all unnecessary drivers with the help of command

pnputil.exe /d oemNN.inf (NN — is a number of drivers file package from drivers.txt, as example oem02.inf).

# In case the driver is in use, you will see an error while trying delete it.

# 3. If there are a lot of drivers in the system, you can use the following script for automatic drivers removal. Create a text file cleanup.bat with the following code and run it as an administrator. This script will sequentially loop all inf files with an index from 1 to 600 and delete the corresponding driver files. If the driver is used or doesn’t exist, it will be skipped:

@echo off
for /L %%N in (1,1,600) do (
  echo Deleting driver OEM%%N.INF
  pnputil /d OEM%%N.INF
)

for /L %N in (1,1,600) do ( pnputil /d OEM%N.INF )

# To clear an event log by using a command line
	wevtutil cl <LogName> [/bu: <backup_file_name>
	wevtutil cl -?

# To Clear All Event Viewer Logs in Command Prompt
	for /F "tokens=*" %1 in ('wevtutil.exe el') DO wevtutil.exe cl "%1"

# To Clear All Event Viewer Logs in PowerShell
	Get-WinEvent -ListLog * | where {$_.RecordCount} | ForEach-Object -Process { [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($_.LogName) }
# OR
	Get-EventLog -LogName * | ForEach { Clear-EventLog $_.Log }
# OR
	wevtutil el | Foreach-Object {wevtutil cl "$_"}

# %SystemRoot%\System32\Winevt\Logs\System.evtx
c:\Windows\System32\Winevt\Logs\System.evtx

C:\Users\jonatas\AppData\Roaming\Code\Cache

C:\Users\Windows 10 Pro\AppData\Roaming\Code\

    # Cache
    # CachedDate
    # CachedExtensions
    # Code Cache

C:\Users\jonatas\AppData\Local\Packages

# https://www.homedev.com.au/Free/PatchCleaner#tabs-4

