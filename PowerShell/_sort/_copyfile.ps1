Param(
	[string]$file,
	[string]$dest
)
# .\copyfile.ps1 -file "*SQL*" -ext "pdf" -dest ".\SQL"

function RenameMove {
	param( [string]$ext )

	$fname = $file +"."+ $ext

	"BEFORE"
	Get-ChildItem $fname -File

	# # copy first, ignore errors
	Get-ChildItem $fname -File | Move-Item -Destination $dest -ErrorAction SilentlyContinue #-whatif

	# "LEFT"
	Get-ChildItem $fname -File

	# # rename left
	Get-ChildItem $fname -File | Rename-Item -NewName { $_.Name -replace ".$($ext)","_1.$($ext)" } #-whatif

	# # try to move again
	Get-ChildItem $fname -File | Move-Item -Destination $dest #-whatif

	# "AFTER"
	Get-ChildItem $fname -File
}

function RenameMove0 {
	$src = "d:\temp"
	$dest = "d:\temp1"
	$filter = "*.txt"

	Get-ChildItem -Path $src -Filter $filter -Recurse | ForEach-Object {
		$num = 1
		$nextName = Join-Path -Path $dest -ChildPath $_.name

		while(Test-Path -Path $nextName)
		{
		   $nextName = Join-Path $dest ($_.BaseName + "_$num" + $_.Extension)
		   $num+=1
		}

		$_ | Move-Item -Destination $nextName
	}
}

function RenameMove1 {
	param( [string]$ext )

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
		#RenameMove -ext $e
		RenameMove1 -ext $e
	}
}