$username = "admin@domain.com"
$password = ConvertTo-SecureString "mypassword" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

Import-Module MSOnline
Connect-MSolService -Credential $psCred
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber -DisableNameChecking


$Username = 'domain\username'
$Password = 'password'
$pass = ConvertTo-SecureString -AsPlainText $Password -Force

$SecureString = $pass
# Users you password securly
$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$SecureString

gwmi win32_service –credential $MySecureCreds –computer PC#

