$ErrorActionPreference = "Stop"

function Resolve-OctopusVariablesInTemplate{
<#
.SYNOPSIS
	Resolves Octopus variables in files with their values from a OctopusParameters

.DESCRIPTION
	Looks for files using Get-ChildItem and in each of the files replaces ${Variable} with the value from $OctopusParameters.
	Files are written back using UTF-8.
	Requires PowerShell 3.0 or higher.

.PARAMETER Path
	Passed to Get-ChildItem to find the files you want to process

.PARAMETER Include
	Passed to Get-ChildItem to find the files you want to process
#>
	Param(
		[string]$Path,
		[string[]]$Include,
		[string[]]$Exclude
	)

	if (-not $OctopusParameters) { throw "No OctopusParameters found" }


	Write-Output "Getting target files on $env:computername in $Path..."
    Write-Output "Get-ChildItem -File -Path $Path -Include $Include -Exclude $Exclude -Recurse | Select-String -pattern '#{.*?}' | Group Path | Select Name"

	$TargetFiles = Get-ChildItem -File -Path $Path -Include $Include -Exclude $Exclude -Recurse | Select-String -pattern "#{.*?}" -List | Select Path | Get-ChildItem


	if ($TargetFiles.Count -eq 0) {
		Write-Warning "`tDid not find any files to process!"
	} else {
		Write-Output "`tFound $($TargetFiles.Count) file(s)"
	}

	#Write-Verbose ($OctopusParameters | Out-String)


	if (($env:TentacleVersion) -and ([version]$env:TentacleVersion -ge [version]"3.0.0.0")){
		# This is a new version (>3.0) - use Octostache
		Write-Output "Will use Octostache.dll (TentacleVersion $env:TentacleVersion)"
		Write-Output "Processing"
		foreach($File in $TargetFiles){
			Resolve-VariablesUsingOctostashe $File.FullName
		}
	} else {
		# If $env:TentacleVersion is not present we assume the Tentacle is an old version (<3.0).
		Write-Output "Will use Octopus.Platform.dll (TentacleVersion $env:TentacleVersion)"
		foreach($File in $TargetFiles){
			Resolve-VariablesUsingOctopusPlatformDll ($File.FullName) ($File.FullName)
		}
	}
}

#Export-ModuleMember -Function Resolve-OctopusVariablesInTemplate

function Resolve-VariablesUsingOctostashe{
	Param(
		[string]$TemplateFile
	)

	Write-Verbose "Looking for Octostache.dll..."
	# Hack-around until $OctopusParameters['Octopus.Tentacle.Agent.ProgramDirectoryPath'] is fixed
	$CalamariPath = $OctopusParameters['env:TentacleHome'] + "\Calamari"

	Write-Verbose "looking for local Octostache"

	$StachePath = "$CalamariPath"

	if(Test-Path -Path "$StachePath\local"){
	    Write-Verbose "didnt find local octostache...looking else where"
	    $StachePath = "$StachePath\local"
	}

	$LatestInstalledCalamari = (Get-ChildItem $StachePath -Directory | ? { $_.Name -match '\d+.\d+.\d+' } | % { [System.Version]$_.Name } | Sort -Descending)[0].ToString()

	Write-Verbose "Loading from $CalamariPath\$LatestInstalledCalamari\Octostache.dll"
	Add-Type -Path "$CalamariPath\$LatestInstalledCalamari\Octostache.dll"

	Write-Output "$TemplateFile"
	$TemplateContent = Get-Content -Raw $TemplateFile -Encoding UTF8
	Write-Verbose "`tRead $($TemplateContent.Length) bytes"

	$Dictionary = New-Object -TypeName Octostache.VariableDictionary

	# Load the hastable into the dictionary
	Write-Verbose "Loading `$OctopusParameters..."

	foreach ($Variable in $OctopusParameters.GetEnumerator()) {
		#Write-Verbose "#{$($Variable.Key)} = $($Variable.Value)"
		$Dictionary.Set($Variable.Key, $Variable.Value)
	}

	Write-Verbose "Resolving variables..."
	$EvaluatedTemplate = $Dictionary.Evaluate($TemplateContent)

	Write-Verbose "Writing the resolved template to $($TemplateFile)"
	$EvaluatedTemplate | Out-File $TemplateFile -Force	-Encoding UTF8
	Write-Verbose "Done!"
}



function Resolve-VariablesUsingOctopusPlatformDll{
	Param(
		[string]$templateFile,
		[string]$outputFile
	)
	Add-Type -Path ($OctopusParameters['Octopus.Tentacle.Agent.ProgramDirectoryPath'] + "\Octopus.Platform.dll")

	Write-Output "Loading template file $templateFile..."

    $contents = [System.IO.File]::ReadAllText($templateFile)

	$template = $null
    $parseErr = $null

    if (-not [Octopus.Platform.Variables.Templates.Parser.TemplateParser]::TryParseTemplate($contents, [ref] $template, [ref] $parseErr))
    {
        throw "The file contents could not be parsed as a valid Octopus template: $parseErr"
    }

    Write-Output "Binding variables..."

    $binding = [Octopus.Platform.Variables.Templates.Binder.PropertyListBinder]::CreateFrom($OctopusParameters)

    $newContents = New-Object System.Text.StringBuilder
    $writer = New-Object System.IO.StringWriter $newContents

    Write-Output "Evaluating template..."

    [Octopus.Platform.Variables.Templates.Evaluator.TemplateEvaluator]::Evaluate($template, $binding, $writer)

    $writer.Dispose()

    Write-Output "Writing result to $outputFile..."

    [System.IO.File]::WriteAllText($outputFile, $newContents.ToString())
}

#---- Auto generated bootstrap by OctopusStepGenerator
$FunctionParameters = @{}
if($OctopusParameters['Path'] -ne $null){$FunctionParameters.Add('Path', $OctopusParameters['Path'])}
if($OctopusParameters['Include'] -ne $null){$FunctionParameters.Add('Include', $($OctopusParameters['Include'] -split "`n"))}
if($OctopusParameters['Exclude'] -ne $null){$FunctionParameters.Add('Exclude', $($OctopusParameters['Exclude'] -split "`n"))}
Resolve-OctopusVariablesInTemplate @FunctionParameters
