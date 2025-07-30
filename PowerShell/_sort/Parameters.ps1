# Verbose
$VerbosePreference
$verbose = $VerbosePreference -ne 'SilentlyContinue'
$verbose
if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) { Write-Host "isVerbose" }


$PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent

$verbose = $VerbosePreference -ne 'SilentlyContinue'

$Verbose = $false
if ($PSBoundParameters.ContainsKey('Verbose')) { # Command line specifies -Verbose[:$false]
    $Verbose = $PsBoundParameters.Get_Item('Verbose')
}

if ( $PSBoundParameters['Verbose'] -or $VerbosePreference -eq 'Continue' ) {
   # do something
}

Check the parameter '$VerbosePreference'.
If it is set to 'SilentlyContinue' then $Verbose was not given at the command line.
If it is set to '$Continue' then you can assume it was set.

Also applies to the following other common parameters:

Name                           Value
----                           -----
DebugPreference                SilentlyContinue
VerbosePreference              SilentlyContinue
ProgressPreference             Continue
ErrorActionPreference          Continue
WhatIfPreference               0
WarningPreference              Continue
ConfirmPreference              High

-------------------------------------------------------------------------------------------------------------------------------

# Hashtable

foreach ($Key in $uploads.Keys) {
	"The value of '$Key' is: $($uploads[$Key])"
}


Write-Verbose "Hashtable : `$uploads"
$uploads
# $uploads.Keys
# $uploads.Values

-------------------------------------------------------------------------------------------------------------------------------

# $PSCommandPath is always available

(Get-Command -Name $PSCommandPath).Parameters | Format-Table -AutoSize @{ Label = "Key"; Expression={$_.Key}; }, @{ Label = "Value"; Expression={(Get-Variable -Name $_.Key -EA SilentlyContinue).Value}; }


#(Get-Command -Name $PSCommandPath).Parameters | Format-Table -AutoSize @{ Label = "Key"; Expression={$_.Key}; }, @{ Label = "Value"; Expression={(Get-Variable -Name $_.Key -EA SilentlyContinue).Value}; }


-------------------------------------------------------------------------------------------------------------------------------
function test {
    param (
          [string] $Bar = 'test'
        , [string] $Baz
        , [string] $Asdf
    )
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters;
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($var)
        {
            write-host "$($var.name) > $($var.value)"
        }
    }
}

test -asdf blah;

-------------------------------------------------------------------------------------------------------------------------------
# Check this solution out.
# This uses the CmdletBinding() attribute,
# which provides some additional metadata through the use of
# the $PSCmdlet built-in variable. You can:
    # Dynamically retrieve the command's name, using $PSCmdlet
    # Get a list of the parameter for the command, using Get-Command
    # Examine the value of each parameter, using the Get-Variable cmdlet

function test {
    [CmdletBinding()]
    param (
          [string] $Bar = 'test'
        , [string] $Baz
        , [string] $Asdf
    )
    # Get the command name
    $CommandName = $PSCmdlet.MyInvocation.InvocationName;
    # Get the list of parameters for the command
    $ParameterList = (Get-Command -Name $CommandName).Parameters;

    # Grab each parameter value, using Get-Variable
    foreach ($Parameter in $ParameterList) {
        Get-Variable -Name $Parameter.Values.Name -ErrorAction SilentlyContinue;
        #Get-Variable -Name $ParameterList;
    }
}

test -asdf blah;
-------------------------------------------------------------------------------------------------------------------------------


To read the value dynamically use the get-variable function / cmdlet

write-host (get-variable "foo")

To print out all of the parameters do the following

foreach ($key in $MyInvocation.BoundParameters.keys)
{
    $value = (get-variable $key).Value
    write-host "$key -> $value"
}

-------------------------------------------------------------------------------------------------------------------------------
function test()
{
    Param(
        [string]$foo,
        [string]$bar,
        [string]$baz = "baz"
    )

    $MyInvocation.MyCommand.Parameters | Format-Table -AutoSize @{ Label = "Key"; Expression={$_.Key}; }, @{ Label = "Value"; Expression={(Get-Variable -Name $_.Key -EA SilentlyContinue).Value}; }
}
test -foo "foo!"

-------------------------------------------------------------------------------------------------------------------------------
$cmdName = $MyInvocation.InvocationName
$paramList = (Get-Command -Name $cmdName).Parameters
foreach ( $key in $paramList.Keys ) {
    $value = (Get-Variable $key -ErrorAction SilentlyContinue).Value
    if ( $value -or $value -eq 0 ) {
        Write-Host "$key -> $value"
    }
}
