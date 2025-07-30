Param(
	[string]$file,
	[string]$dest
)
# .\copyfile.ps1 -file "*SQL*" -ext "pdf" -dest ".\SQL"

function RenameMove {
	Param( [string]$ext )

	#$src = "d:\temp"
	#$dest = "d:\temp1"

	$fname = $file +"."+ $ext
	Write-host "fname: " $fname

	Get-ChildItem $fname -File | ForEach-Object {
		$num = 1
		$nextName = Join-Path -Path $dest -ChildPath $_.name

		Write-host "cur name: " $_.name
		Write-host "dest name: " $nextName

		while(Test-Path -Path $nextName)
		{
		   $nextName = Join-Path $dest ($_.BaseName + "_$num" + $_.Extension)
		   $num+=1
		}

		Write-host "new name: " $nextName
		$_ | Move-Item -Destination $nextName
	}
}

$ext = "pdf", "epub", "txt"

if ( -not $file  -or -not $dest ) {
	write-host "Error: missing parameter: -file and -dest"
	break
}
else {
	# create dest directory if not exists
	if ( -Not (Test-Path -Path $dest) ){
		New-Item -ItemType Directory -Path $dest
	}
	foreach ($e in $ext) {
		write-host "running " $e
		RenameMove -ext $e
	}
}