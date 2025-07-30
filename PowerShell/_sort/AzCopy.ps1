-------------------------------------------------------------------------------------------------------------------------------

$sasKey = $OctopusParameters["CDN:cdnSasKeyQuerystring"]
$cdnUrl = $OctopusParameters["CDN:Storage:cdnStorageAbsoluteUrl"]
$blobBasePath = $OctopusParameters["BlobBasePath"]
# the remote folder is specified here
# to have access to the deployed package version if needed
$cdndeploy_pkg = $OctopusParameters["Octopus.Action.Package[CDN.Deploy].ExtractedPath"]
$azcopy_v10 = "$cdndeploy_pkg\modules\Azcopy_v10\azcopy.exe"
#$version = $OctopusParameters["Octopus.Action[Unpack].Package.PackageVersion"]
$localFolder = $OctopusParameters["Octopus.Action[Unpack].Output.Package.InstallationDirectoryPath"]
$remoteFolder = "${cdnUrl}${blobBasePath}"

#clear destination folder
$cmd = "$azcopy_v10 remove --recursive `"$remoteFolder${sasKey}`""
$cmd
Invoke-Expression $cmd

#push files to destination folder
$cmd = "$azcopy_v10 cp --recursive `"$localFolder\*`" --exclude `"*.nuspec`" `"$remoteFolder${sasKey}`""
$cmd
Invoke-Expression $cmd

-------------------------------------------------------------------------------------------------------------------------------

$sasKey = $OctopusParameters["CDN:cdnSasKeyQuerystring"]
$cdnUrl = $OctopusParameters["CDN:Storage:cdnStorageAbsoluteUrl"]
$betaBlobBasePath = $OctopusParameters["BetaBlobBasePath"]
# the remote folder is specified here
# to have access to the deployed package version if needed
$cdndeploy_pkg = $OctopusParameters["Octopus.Action.Package[CDN.Deploy].ExtractedPath"]
$azcopy_v10 = "$cdndeploy_pkg\modules\Azcopy_v10\azcopy.exe"
#$version = $OctopusParameters["Octopus.Action[Unpack].Package.PackageVersion"]
$localFolder = $OctopusParameters["Octopus.Action[Unpack].Output.Package.InstallationDirectoryPath"]
$remoteFolder = "${cdnUrl}${betaBlobBasePath}"
#clear destination folder
$cmd = "$azcopy_v10 remove --recursive `"$remoteFolder${sasKey}`""
$cmd
Invoke-Expression $cmd
#push files to destination folder
$cmd = "$azcopy_v10 cp --recursive `"$localFolder\*`" --exclude `"*.nuspec`" `"$remoteFolder${sasKey}`""
$cmd
Invoke-Expression $cmd
