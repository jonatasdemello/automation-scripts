# Setup the TrustedHosts

# From the Source PC, open a Command Prompt with administrative
# priviledges and then go to PowerShell by typing powershell : once there,
# insert the following command – replacing the TARGET-HOST sample
# hostname with the hostname or IP Address of the Target PC.

	winrm set winrm/config/client '@{TrustedHosts="TARGET-HOST"}'

# Do the same thing on your Target PC, replacing again the SOURCE-HOST
# sample hostname with the hostname or IP Address of the source PC:

	winrm set winrm/config/client '@{TrustedHosts="SOURCE-HOST"}'

# As soon as you do that, you can run any PowerShell command between the
# two nodes which will be delivered via TCP. If you don’t do that,
# you’ll most likely incur in the following error message:

# Connecting to remote server <TARGET-HOST> failed with the following
# error message : The WinRM client cannot process the request.


#-------------------------------------------------------------------------------------------------------------------------------

# List of PowerShell Commands

# Here are the relevant PowerShell command to issue, respectively, STOP, START and RESTART on the IIS instance installed on the target PC:

invoke-command -computername "TARGET-HOST" -scriptblock {iisreset /STOP}
invoke-command -computername "TARGET-HOST" -scriptblock {iisreset /START}
invoke-command -computername "TARGET-HOST" -scriptblock {iisreset /RESTART}

# You can execute these command either from a PowerShell console or, if
# you prefer, from an elevated Command Prompt by adding a powershell at
# the start of each line. Again, remember to replace the TARGET-HOST
# sample hostname with the hostname or IP Address of the target PC.


sc help
sc \\RemoteServer stop iisadmin
sc \\RemoteServer start w3svc
sc \\RemoteServer stop [iis-service-name]



# SysInternals' psexec. The PsTools suite is useful for these scenarios.

psexec \\RemoteServer iisreset


invoke-command -computername yourremoteservername -scriptblock {iisreset}


Yes, with the help of PowerShell. Run the following to do an iisreset on a number of servers.

	Invoke-Command –ComputerName server1,server2, server3 –ScriptBlock { iisreset /noforce }

If you want to use another account which has admin rights, run

	$cred = Get-Credential
	Invoke-Command –ComputerName server1,server2, server3 –ScriptBlock { iisreset /noforce } –Credential $cred

You can also use iisreset.exe /restart in the script block. If you have a list of server names in a text file, you can use that with the invoke-command. Run

	Invoke-Command –ComputerName (Get-Content C:\servers.txt) –ScriptBlock { iisreset /noforce }

$Server = "EXAMPLE.example.com"
$Scriptblock = {IISRESET}
$Credetial = Get-Credential

Invoke-Command -ComputerName $Server -Scriptblock $Scriptblock -Credential $Credential


The following POSH script will allow you to asynchronously reset a set of machines remotely (very handy when working with a large set):

$a = Get-Content "c:\OneMachineNamePerLine.txt"

foreach($line in $a)
{

    Start-Job -ScriptBlock {
        iisreset $line
    }
}



-------------------------------------------------------------------------------------------------------------------------------
winrm help config

Windows Remote Management Command Line Tool

Configuration for WinRM is managed using the winrm command line or through GPO.
Configuration includes global configuration for both the client and service.

The WinRM service requires at least one listener to indicate the IP address(es)
on which to accept WS-Management requests.  For example, if the machine has
multiple network cards, WinRM can be configured to only accept requests from
one of the network cards.

Global configuration
  winrm get winrm/config
  winrm get winrm/config/client
  winrm get winrm/config/service
  winrm enumerate winrm/config/resource
  winrm enumerate winrm/config/listener
  winrm enumerate winrm/config/plugin
  winrm enumerate winrm/config/service/certmapping

Network listening requires one or more listeners.
Listeners are identified by two selectors: Address and Transport.

Address must be one of:
  *           - Listen on all IPs on the machine
  IP:1.2.3.4  - Listen only on the specified IP address
  MAC:...     - Listen only on IP address for the specified MAC

Note: All listening is subject to the IPv4Filter and IPv6Filter under
config/service.
Note: IP may be an IPv4 or IPv6 address.


Transport must be one of:
  HTTP  - Listen for requests on HTTP  (default port is 5985)
  HTTPS - Listen for requests on HTTPS (default port is 5986)

Note: HTTP traffic by default only allows messages encrypted with
the Negotiate or Kerberos SSP.


When configuring HTTPS, the following properties are used:
  Hostname - Name of this machine; must match CN in certificate.
  CertificateThumbprint - hexadecimal thumbprint of certificate appropriate for
    Server Authentication.
Note: If only Hostname is supplied, WinRM will try to find an appropriate
certificate.

Example: To listen for requests on HTTP on all IPs on the machine:
  winrm create winrm/config/listener?Address=*+Transport=HTTP

Example: To disable a given listener
  winrm set winrm/config/listener?Address=IP:1.2.3.4+Transport=HTTP @{Enabled="false"}

Example: To enable basic authentication on the client but not the service:
  winrm set winrm/config/client/auth @{Basic="true"}

Example: To enable Negotiate for all workgroup machines.
  winrm set winrm/config/client @{TrustedHosts="<local>"}

See also:
  winrm help uris
  winrm help aliases
  winrm help certmapping
  winrm help input
  winrm help switches

-------------------------------------------------------------------------------------------------------------------------------

Param(
    [ValidateSet('web1', 'web2', 'web7', 'web8', 'web9', 'web10')]
    $VirtualServer = "web1"
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
$servers = @{
    web1 = "172.16.10.86";
    web2 = "172.16.10.87";
    web7 = "172.16.10.94";
    web8 = "172.16.10.95";
    web9 = "172.16.10.97";
    web10 = "172.16.10.98";
}


$rs = $servers[$VirtualServer]

Write-Output "Killing dotnet.exe..."

./Kill-WmiProcesses.ps1 -ComputerName $rs -ProcessName dotnet.exe


Write-Output "IIS restarting..."

$res = Invoke-Command -ComputerName $rs { Stop-Service W3SVC} -Credential domain\user

Write-Output "Result is: " $res

-------------------------------------------------------------------------------------------------------------------------------

$Env:PSModulePath -split (';')

Get-InstalledModule -Name Az -AllVersions


Uninstall-AzureRm

Install-Module -Name Az -AllowClobber -Scope CurrentUser

if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope AllUsers
}


-------------------------------------------------------------------------------------------------------------------------------


https://docs.microsoft.com/en-us/powershell/module/az.compute/invoke-azvmruncommand?view=azps-5.4.0

Invoke-AzVMRunCommand

Invoke-AzVMRunCommand -ResourceGroupName 'rgname' -VMName 'vmname' -CommandId 'RunPowerShellScript' -ScriptPath 'sample.ps1' -Parameter @{param1 = "var1"; param2 = "var2"}
