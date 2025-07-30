
Disable-ComputerRestore "C:\", "D:\"

on are:

    C:\ProgramData\Microsoft\Windows\WER\ReportQueue
    C:\Users\%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportQueue
	C:\Windows\Logs
	C:\Windows\Logs\CBS

	C:\Windows\Temp
    C:\Users\%USERPROFILE%\AppData\Local\Temp

	C:\Windows\System32\Logfiles\HTTPErr
	C:\inetpub\mailroot\Badmail



dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

Using the /ResetBase switch with the /StartComponentCleanup parameter of dism.exe, all superseded versions of every component in the component store is removed.


the Dism.exe /Online /Cleanup-Image has a few extra parameters (or switches):

    /AnalyzeComponentStore
    /StartComponentCleanup
    /ResetBase with /StartComponentCleanup
    /SPSuperseded


schtasks.exe /Run /TN "\Microsoft\Windows\Servicing\StartComponentCleanup"


SFC /scannow

“disk cleanup” or cleanmgr.exe
cleanmgr.exe

cleanmgr.exe [/d driveletter] [/SAGESET:n | /SAGERUN:n | TUNEUP:n | /LOWDISK | /VERYLOWDISK | /SETUP | /AUTOCLEAN]

The /AUTOCLEAN parameter is used to delete old files left after upgrading a Windows build.
The /SETUP option allows you to delete files left from a previous version of Windows (if you performed an in-place upgrade).

The /LOWDISK command runs the Disk Cleanup GUI with the already selected cleaning options.
The /VERYLOWDISK command performs automatic drive cleanup (without showing GUI),
and after the end it displays information about the actions performed and available free space.



Using the /sageset:xx and /sagerun:xx options, you can create and run a customized set of cleanup options.

For example, run the command: cleanmgr /sageset: 11. In the window that opens, select the components and files that you want to automatically cleanup (I selected all the options).

These settings are saved to the registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches. This registry section lists all the Windows components that can be cleaned using the Disk Cleanup tool. For each option you select, a DWORD parameter is created with the name StateFlags0011 (0011 is the number you specified in the sageset parameter).

To start the drive cleanup task with the selected parameters, run the command:

cleanmgr /sagerun:11

If you need to configure automatic disk cleanup task on computers (or servers) in an Active Directory domain, you just need to export this registry key and deploy it on computers through the GPO.

To automatically cleanup the system drive on workstations with Windows 10, you can create a simple scheduled task with the following PowerShell code:

Start-Process -FilePath CleanMgr.exe -ArgumentList '/sagerun:11' -WindowStyle Hidden -Wait



You need to clean Component Store using command line tool called DISM. first, you need to analyze the store and then perform the cleanup

1. dism.exe /online /Cleanup-Image /AnalyzeComponentStore

2. dism.exe /online /Cleanup-Image /StartComponentCleanup

3. dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

4. dism.exe /online /Cleanup-Image /SPSuperseded

Before doing cleanup make sure you have a good backup of host machine along with virtual machines or you can take fresh backup for a safer side.

