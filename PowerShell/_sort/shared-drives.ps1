# shared drives

start \\192.168.50.14\share\Users

start \\192.168.50.14\share\Shared


net use s: /delete
net use u: /delete

net use s: \\192.168.50.14\share\Shared /persistent:no
net use u: \\192.168.50.14\share\Users /persistent:no


net use J: \\WIN-5E6EO1A1UJU\JenkinsLogs
net use T: \\WIN-5E6EO1A1UJU\Wordpress



http://xoitfileshare.file.core.windows.net/

\\xoitfileshare.file.core.windows.net

\\xoitfileshare.file.core.windows.net\engineering\


\\storageaccountname.file.core.windows.net\myfileshare


# Use the cmdkey command to add the credentials into Credential Manager.
# Perform this action from a command line under the service account context,
# either through an interactive login or by using runas.

cmdkey /add:StorageAccountName.file.core.windows.net /user:localhost\StorageAccountName /pass:StorageAccountKey

cmdkey /add:<storage-account-name>.file.core.windows.net /user:AZURE\<storage-account-name> /pass:<storage-account-key>

# Map the share directly without using a mapped drive letter.
# Some applications might not reconnect to the drive letter properly,
# so using the full UNC path might be more reliable:

net use * \\storage-account-name.file.core.windows.net\share

New-SmbMapping -LocalPath y: -RemotePath \\server\share -UserName accountName -Password "password can contain / and \ etc"



\\engineering\SQL\SQL2019-SSEI-Dev.exe

WR24N-C6RDR-TC9GD-HYQ72-DDFB8 is the 2022 VS Key


SMB protocol port 445

Test-NetConnection -Port 445

netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80

New-NetFirewallRule -DisplayName 'some-port' `
                    -LocalPort 1234 -Action Allow `
                    -Profile 'Public' `
                    -Protocol TCP `
                    -Direction Inbound

-----------------------------------------------------------------------
# .\OpenPort.ps1 -port 5000

param (
    [int]$port = 3777
)

$ruleName = "Allow Port $port"

# Check if the rule already exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

if ($existingRule) {
    Write-Host "Firewall rule '$ruleName' already exists."
} else {
    # Create a new inbound rule for the specified port
    New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort $port
    Write-Host "Firewall rule '$ruleName' created."
}

-----------------------------------------------------------------------

$resourceGroupName = "<your-resource-group-name>"
$storageAccountName = "<your-storage-account-name>"

# This command requires you to be logged into your Azure account and set the subscription your storage account is under, run:
# Connect-AzAccount -SubscriptionId 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
# if you haven't already logged in.
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

# The ComputerName, or host, is <storage-account>.file.core.windows.net for Azure Public Regions.
# $storageAccount.Context.FileEndpoint is used because non-Public Azure regions, such as sovereign clouds
# or Azure Stack deployments, will have different hosts for Azure file shares (and other storage resources).
Test-NetConnection -ComputerName ([System.Uri]::new($storageAccount.Context.FileEndPoint).Host) -Port 445

