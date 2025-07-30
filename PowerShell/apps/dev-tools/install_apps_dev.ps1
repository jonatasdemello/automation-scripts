
function install_apps_dev {
	Param( [String] $vsKey = "none" )

	# .\install_chocolatey.ps1

	chocolatey feature enable -n allowGlobalConfirmation

	cinst azure-cli
	cinst diffmerge
	cinst fiddler
	cinst Firefox
	cinst google-chrome-x64
	cinst mRemoteNG
	cinst git
	cinst greenshot
	cinst nodejs.install
	cinst notepadplusplus.install
	cinst nuget.commandline
	cinst python2
	cinst skype
	cinst slack
	cinst sourcetree
	cinst vscode
	cinst webpi
	cinst webpicmd
	cinst 7zip.install

	if($vsKey -ne "none")
	{
		if($vsKey -eq "express"){
			cinst VisualStudioExpress2013WindowsDesktop
			write-host "express"
		}
		else{
			#cinst VisualStudio2013Premium -InstallArguments "/Features:'Blend LightSwitch VC_MFC_Libraries OfficeDeveloperTools SQL WebTools Win8SDK SilverLight_Developer_Kit WindowsPhone80' /ProductKey:$vsKey"
			write-host "not express - Please install the latest version of Visual Studio"
		}
	}
}
