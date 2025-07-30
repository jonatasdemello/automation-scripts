write-host " ----- Using PowerShell Profle -----"

write-host '$psVersionTable'
$psVersionTable
write-host " "

write-host "---------- dotnet ----------"
write-host "dotnet --info"
dotnet --info
write-host " "

write-host "---------- node ----------"
write-host "node -v"
node -v
write-host " "

write-host "---------- npm ----------"
write-host "npm -v"
npm -v
write-host " "

write-host "SCM ENVIRONMENT -------------------------------------------------------------"
write-host "git --version"
git --version
write-host " "

write-host "JENKINS GLOBAL ENVIRONMENT --------------------------------------------------"
write-host "env:Path -Split ';'"
$env:Path -Split ';'
write-host " "

write-host "JENKINS JOB ENVIRONMENT -----------------------------------------------------"
write-host "ENV:WORKSPACE: $ENV:WORKSPACE"
write-host "ENV:BUILD_NUMBER: $ENV:BUILD_NUMBER"
write-host " "


write-host "JENKINS GLOBAL ENVIRONMENT --------------------------------------------------"
write-host "env:Path -Split ';'"
$env:Path -Split ';'
write-host ""

write-host "JENKINS JOB ENVIRONMENT -----------------------------------------------------"
write-host "ENV:WORKSPACE: $ENV:WORKSPACE"
write-host "ENV:BUILD_NUMBER: $ENV:BUILD_NUMBER"
write-host ""

write-host "SCM ENVIRONMENT -------------------------------------------------------------"
write-host "git --version"
git --version

write-host "POWERSHELL ENVIRONMENT ------------------------------------------------------"
write-host "global:errorActionPreference: $global:errorActionPreference"
write-host "script:errorActionPreference: $script:errorActionPreference"
write-host "PSVersionTable"
$PSVersionTable
write-host ""
write-host "env:PSModulePath: $env:PSModulePath"
write-host ""
write-host "Get-Module -ListAvailable"
# this is too verbose...
# Get-Module -ListAvailable



write-host ""
write-host "NODEJS ENVIRONMENT -------------------------------------------------------------"
write-host "node --version"
node --version

write-host "npm --version"
npm --version

write-host "npm cache verify"
npm cache verify

write-host "ENV:NPM_CONFIG_LOGLEVEL: $ENV:NPM_CONFIG_LOGLEVEL"
write-host "ENV:DISABLE_OPENCOLLECTIVE: $ENV:DISABLE_OPENCOLLECTIVE"

write-host "- DOTNET ----------------------------------------------------------------------"
write-host "dotnet --info"
dotnet --info

write-host "dotnet build -ver"
dotnet build -ver

write-host "dotnet publish -ver"
dotnet publish -ver

