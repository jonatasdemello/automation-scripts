# robocopy \\source\folder \\dest\folder
#	*.json /R:0 /W:0 /Z /NP /NC /NFL /NDL /XX /E /MOV
# 	param: /E /ZB /XD node_modules /XD .git /NS /NC /NP /NFL

function CopyFiles {
	param( [string]$src, [string]$dest )

	$cmd = "robocopy "
	$params = "/E /Z /XD node_modules /XD packages /XD TestResults /XD bin /XD obj /NS /NC /NP /NFL /NDL"
	# $params = "/E /Z /XD node_modules /XD .git /NS /NC /NP /NFL /NDL"
	# "/Z /NS /NC /NP /NDL /XX /E /XF *-GB.json /XD node_modules"
	$filter = "*.*"

	$run = "$cmd $src $dest $filter $params"

	write-host $run
	Invoke-Expression $run
}


#CopyFiles "C:\Workspace" "D:\Workspace\"

CopyFiles "D:\Workspace" "C:\Workspace\"
