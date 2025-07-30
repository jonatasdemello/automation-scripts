#-------------------------------------------------------------------------------------------------------------------------------
# helper function
Function InstallIISFeature([string]$name)
{
    & Enable-WindowsOptionalFeature -Online -FeatureName $name
}

InstallIISFeature "IIS-WebServerRole"

# this installs:
#IIS-ApplicationDevelopment
#IIS-CommonHttpFeatures
#IIS-DefaultDocument
#IIS-DirectoryBrowsing
#IIS-HealthAndDiagnostics
#IIS-HttpCompressionStatic
#IIS-HttpErrors
#IIS-HttpLogging
#IIS-ManagementConsole
#IIS-Performance
#IIS-RequestFiltering
#IIS-RequestMonitor
#IIS-Security
#IIS-StaticContent
#IIS-WebServer
#IIS-WebServerManagementTools
#IIS-WebServerRole


# AspNetPrerequisites()
InstallIISFeature "IIS-ISAPIFilter"
InstallIISFeature "IIS-ISAPIExtensions"

# ASP.NET
InstallIISFeature "NetFx4Extended-ASPNET45"
InstallIISFeature "IIS-NetFxExtensibility45"
InstallIISFeature "IIS-ASPNET45"
InstallIISFeature "IIS-NetFxExtensibility"
InstallIISFeature "IIS-ASPNET"

# Classic ASP
InstallIISFeature "IIS-ASP"

# more optional features
InstallIISFeature "IIS-FTPServer"
InstallIISFeature "IIS-FTPSvc"
InstallIISFeature "IIS-ManagementScriptingTools"
InstallIISFeature "IIS-HttpCompressionDynamic"
InstallIISFeature "IIS-IISCertificateMappingAuthentication"
InstallIISFeature "IIS-HttpTracing"
InstallIISFeature "IIS-HttpRedirect"
InstallIISFeature "IIS-WindowsAuthentication"
InstallIISFeature "IIS-IPSecurity"
InstallIISFeature "IIS-WebSockets"
InstallIISFeature "IIS-LoggingLibraries"
InstallIISFeature "IIS-RequestMonitor"
InstallIISFeature "IIS-ManagementService"

# show installed features
Get-WindowsOptionalFeature –Online | Where {$_.FeatureName -match "^IIS-" -and $_.State -eq "Enabled"} | Sort FeatureName | Select FeatureName

