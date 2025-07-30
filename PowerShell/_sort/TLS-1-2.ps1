
# Using TLS 1.2 solved this error.
# You can force your application using TLS 1.2 with this (make sure to execute it before calling your service):

ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12

# Another solution :
# Enable strong cryptography in your local machine or server in order to use TLS1.2 because by default it is disabled so only TLS1.0 is used.
# To enable strong cryptography , execute these commande in PowerShell with admin privileges :

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

# You need to reboot your computer for these changes to take effect.
