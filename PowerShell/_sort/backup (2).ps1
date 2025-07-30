# robocopy

function CopyFiles {
	param( [string] $src, [string] $dest )
	$cmd = "robocopy "
	$params = "/E /Z /XD node_modules /XD packages /XD TestResults /XD bin /XD obj /NS /NC /NP "
	$filter = "*.*"
	$run = "$cmd $src $dest $filter $params"
	$sep = ("-") * 50
	write-host $sep
	write-host $run
		Invoke-Expression $run
	write-host $sep
}
#-------------------------------------------------------------------------------------------------------------------------------
$dest="D:"

 CopyFiles "C:\work\_Leadership" "$dest\work\_Leadership"
 CopyFiles "C:\work\docs" "$dest\work\docs"


#-------------------------------------------------------------------------------------------------------------------------------
# /S :: copy Subdirectories, but not empty ones.
# /E :: copy subdirectories, including Empty ones.
# /Z :: copy files in restartable mode.
# /B :: copy files in Backup mode.
#
# /XF file [file]... :: eXclude Files matching given names/paths/wildcards.
# /XD dirs [dirs]... :: eXclude Directories matching given names/paths.
#
# /XC :: eXclude Changed files.
# /XN :: eXclude Newer files.
# /XO :: eXclude Older files.
# /XX :: eXclude eXtra files and directories.
# /XL :: eXclude Lonely files and directories.
# /IS :: Include Same files.
# /IT :: Include Tweaked files.
#
# /NS :: No Size - don't log file sizes.
# /NC :: No Class - don't log file classes.
# /NFL :: No File List - don't log file names.
# /NDL :: No Directory List - don't log directory names.
# /NP :: No Progress - don't display percentage copied.
#
#   /L :: List only - dont copy, timestamp or delete any files.
#   /X :: report all eXtra files, not just those selected.
#   /V :: produce Verbose output, showing skipped files.
#
#  /TS :: include source file Time Stamps in the output.
#  /FP :: include Full Pathname of files in the output.
#
# /TEE :: output to console window, as well as the log file.
# /NJH :: No Job Header.
# /NJS :: No Job Summary.
#
# /PURGE :: delete dest files/dirs that no longer exist in source.
# /MIR :: MIRror a directory tree (equivalent to /E plus /PURGE).
# /MOV :: MOVe files (delete from source after copying).
# /MOVE :: MOVE files AND dirs (delete from source after copying).
#-------------------------------------------------------------------------------------------------------------------------------
