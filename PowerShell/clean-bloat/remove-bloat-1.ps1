# Remove non-corporate apps
$AppsList = "Microsoft.3DBuilder",`
            "Microsoft.Advertising.Xaml",`
            "Microsoft.Messaging",`
            "Microsoft.Microsoft3DViewer",`
            "Microsoft.Messaging",`
            "Microsoft.MicrosoftOfficeHub",`
            "Microsoft.MicrosoftSolitaireCollection",`
            "Microsoft.Office.OneNote",`
            "Microsoft.OneConnect",`
            "Microsoft.People",`
            "Microsoft.SkypeApp",`
            "Microsoft.Wallet",`
            "Microsoft.XboxApp",`
            "Microsoft.XboxGameOverlay",`
            "Microsoft.XboxIdentityProvider",`
            "Microsoft.XboxSpeechToTextOverlay",`
            "Microsoft.ZuneMusic",`
            "Microsoft.ZuneVideo",`
            "microsoft.windowscommunicationsapps",`
            "Microsoft.WindowsPhone",`
            "Microsoft.Office.Sway",`
            "Microsoft.ConnectivityStore",`
            "Microsoft.CommsPhone",`
            "Microsoft.BingFinance"

            #"Microsoft.StorePurchaseApp",`
            #"Microsoft.WindowsStore",`

ForEach ($app in $AppsList){
	$variable = DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename
	$variable2 = $variable -replace "PackageName : ", ""
}

# $variable2| % {DISM /Online /Remove-ProvisionedAppxPackage /PackageName:$_}


To remove apps from current user:

ForEach ($app in $AppsList)
{
    Get-AppxPackage -Name $app | Remove-AppxPackage
}

# To remove apps from new users logging onto a system use, but not remove from existing users:

ForEach ($app in $AppsList)
{
	Get-AppXProvisionedPackage -Online | Where-Object { $_.DisplayName -eq  $app } | Remove-AppxProvisionedPackage -Online
}

