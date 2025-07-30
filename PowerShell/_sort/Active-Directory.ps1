
net localgroup administrators AzureAD\JohnDoe /add

net localgroup "Remote Desktop Users" /add "AzureAD\the-UPN-attribute-of-your-user"


# Value		Universal Well-Known SID	Identifies
# S-1-0-0		Null SID	A group with no member objects. This SID is often used when a SID value is null or unknown.
# S-1-1-0		World	A group that includes everyone or all users.
# S-1-2-0		Local	Users who log on to local (physically connected)
# S-1-2-1		Console Logon	A group includes users logged on the physical console.
# S-1-3-0		Creator Owner ID	A SID to be replaced by the user’s security identifier who created a new object. This SID is used in inheritable ACEs.
# S-1-3-1		Creator Group ID	A SID is replaced by the primary-group SID of the user who created a new object. Use this SID in inheritable ACEs.
# S-1-3-2		Creator Owner Server
# S-1-3-3		Creator Group Server
# S-1-3-4		Owner Rights	A SID that represents the current owner of the object. When an ACE that carries this SID is applied to an object, the system ignores the object owner’s implicit READ_CONTROL and WRITE_DAC permissions for the object owner.
# S-1-4		Non-unique Authority	A Security Identifier that represents an identifier authority.
# S-1-5		NT Authority	A Security Identifier that represents an identifier authority.
# S-1-5-80-0	All Services	A group includes all service processes configured on the system. The operating system controls membership.


Install-Module -Name dockeraccesshelper
Import-Module dockeraccesshelper
Add-AccountToDockerAccess "FUM-GLOBAL\TFENSTER"


# Get Current Active Directory User SID in PowerShell

Get-LocalUser -Name $env:USERNAME | Select-Object  sid

Get-LocalUser -Name 'johndoe' | Select-Object  sid


# Get Active Directory User SID in PowerShell

Import-Module ActiveDirectory
Get-AdUser -Identity toms | Select Name, SID, UserPrincipalName

# Get Active Directory Computer SID in PowerShell

Get-ADComputer -Filter * | Select-Object Name, SID

# Get Active Directory Group SID in PowerShell

Get-ADGroup -Identity SalesLeader | Select-Object Name, SID

# Get a SID of All Domains in PowerShell
(Get-ADForest).Domains| %{Get-ADDomain -Server $_} | Select-Object name, domainsid


# Install

Add-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -Online

Install-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature

Get-Module -Name ActiveDirectory -ListAvailable


#List the currently installed RSAT tools:

Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property Name, State

# https://ss64.com/links/windows.html#kits


#Get the Windows capabilities for an image specified by -name:

Get-WindowsCapability -Path "C:\offline" -Name "Language.TextToSpeech~~~fr-FR~0.0.1.0"

# Get the Windows capabilities for the local Operating System:

Get-WindowsCapability -Online

#Install all the available RSAT tools:

Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability –Online



Get-WindowsOptionalFeature –Online
Get-WindowsOptionalFeature –Online | Select-Object -Property FeatureName, State
Get-WindowsOptionalFeature –Online | Where {$_.state -eq 'Enabled'} | Select-Object FeatureName, State

