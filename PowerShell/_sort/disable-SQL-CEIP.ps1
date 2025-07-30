##################################################
#  Deactivate CEIP registry keys #
##################################################
# Set all CustomerFeedback & EnableErrorReporting in the key directory HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server to 0
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\***\CustomerFeedback=0
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\***\EnableErrorReporting=0
# *** --> Version of SQL Server (100,110,120,130,140,...)
# For the Engine
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSSQL**.<instance>\CPE\CustomerFeedback=0
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSSQL**.<instance>\CPE\EnableErrorReporting=0
# For SQL Server Analysis Server (SSAS)
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSAS**.<instance>\CPE\CustomerFeedback=0
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSAS**.<instance>\CPE\EnableErrorReporting=0
# For Server Reporting Server (SSRS)
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSRS**.<instance>\CPE\CustomerFeedback=0
# Set HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\MSRS**.<instance>\CPE\EnableErrorReporting=0
# ** --> Version of SQL Server (10,11,12,13,14,...)
##################################################
$Key = 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server'
$FoundKeys = Get-ChildItem $Key -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'
foreach ($Sqlfoundkey in $FoundKeys)
{
$SqlFoundkey | Set-ItemProperty -Name EnableErrorReporting -Value 0
$SqlFoundkey | Set-ItemProperty -Name CustomerFeedback -Value 0
}
##################################################
# Set HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Microsoft SQL Server\***\CustomerFeedback=0
# Set HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Microsoft SQL Server\***\EnableErrorReporting=0
# *** --> Version of SQL Server(100,110,120,130,140,...)
##################################################
$WowKey = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server"
$FoundWowKeys = Get-ChildItem $WowKey | Where-Object -Property Property -eq 'EnableErrorReporting'
foreach ($SqlFoundWowKey in $FoundWowKeys)
{
$SqlFoundWowKey | Set-ItemProperty -Name EnableErrorReporting -Value 0
$SqlFoundWowKey | Set-ItemProperty -Name CustomerFeedback -Value 0
}
