# Administrator Group
# The output will show True when you're a member of the built-in Administrators group.

(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)



Disable and Enable Search Indexing:

Launch Command Prompt as an administrator

Execute the following command to disable Search Indexing.

sc stop "wsearch" && sc config "wsearch" start=disabled

Execute the following command to enable Search Indexing

sc config "wsearch" start=delayed-auto && sc start "wsearch"



Rebuild Search index:

Search out "Indexing Options" from the Start Menu.

Click Advanced.

Now, click Rebuild. You will be asked to confirm your action, so, click Ok.





Run the commands:

DISM /Online /Cleanup-Image /RestoreHealth

DISM /online /cleanup-image /startcomponentcleanup /resetbase

DISM /online /cleanup-image /startcomponentcleanup

Chkdsk c: /f /r /x

sfc /scannow


-------------------------------------------------------------------------------------------------------------------------------
@ECHO OFF
ECHO Delete Folder: %CD%?
PAUSE
SET FOLDER=%CD%
CD /
DEL /F/Q/S "%FOLDER%" > NUL
RMDIR /Q/S "%FOLDER%"
EXIT

-------------------------------------------------------------------------------------------------------------------------------
del /f/q/s *.* > nul
cd ..
rmdir /q/s FOLDER-NAME


rd /s <folder>
RD /S /Q drive:\ Folder path

-------------------------------------------------------------------------------------------------------------------------------

Remove-Item -force -recurse -Verbose

Get-ChildItem -Path . -Recurse | Remove-Item -force -recurse -Verbose



