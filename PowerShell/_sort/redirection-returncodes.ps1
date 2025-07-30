
Powershell
https://adamtheautomator.com/powershell-start-process/

Redirection
https://ss64.com/nt/syntax-redirection.html
https://ss64.com/ps/syntax-redirection.html

https://ss64.com/nt/errorlevel.html

-------------------------------------------------------------------------------------------------------------------------------

	Start-Process -FilePath $bcp -ArgumentList $bcp_args `
		-Wait -NoNewWindow `
		-RedirectStandardOutput "temp\$inputFile.out.txt" `
		-RedirectStandardError "temp\$inputFile.err.txt" #`	| Out-Null


-------------------------------------------------------------------------------------------------------------------------------

STDIN  = 0  Keyboard input
STDOUT = 1  Text output
STDERR = 2  Error text output
UNDEFINED = 3-9 (In PowerShell 3.0+ these are defined)

When redirection is performed without specifying a numeric handle, the default is 1, i.e. '>' will not redirect error messages.

   command 2> filename       Redirect any error message into a file
   command 2>> filename      Append any error message into a file
  (command)2> filename       Redirect any CMD.exe error into a file
   command > file 2>&1       Redirect errors and output to one file
   command > fileA 2> fileB  Redirect output and errors to separate files

   command 2>&1 >filename    This will fail!

Redirect to NUL (hide errors)

   command 2> nul            Redirect error messages to NUL
   command >nul 2>&1         Redirect error and output to NUL
   command >filename 2> nul  Redirect output to file but suppress error
  (command)>filename 2> nul  Redirect output to file but suppress CMD.exe errors

Powershell
  command >  filename     # Redirect command output to a file (overwrite)
  command >> filename     # APPEND into a file
  command 2> filename     # Redirect Errors from operation to a file(overwrite)
  command 2>> filename    # APPEND errors to a file
  command 2>&1            # Add errors to results
  command 1>&2            # Add results to errors
  command | command       # This is the basic form of a PowerShell Pipeline

In PowerShell 3.0+
  command 3> warning.txt  # Write warning output to warning.txt
  command 4>> verbose.txt # Append verbose.txt with the verbose output
  command 5>&1            # Writes debug output to the output stream
  command *> out.txt      # Redirect all streams (output, error, warning, verbose, and debug) to out.txt

Numeric handles:

STDIN  = 0  Keyboard input
STDOUT = 1  Text output
STDERR = 2  Error text output
WARNING = 3 Warning output
VERBOSE = 4 Verbose output
DEBUG  = 5 Debug output
INFO   = 6 Information output (PowerShell 5.0+)

Discarding output that you don't need:

PS C:\> get-childitem | out-null

An alternative method, which runs much faster is to use the $null automatic variable:

PS C:\> get-childitem > $null
or
PS C:\> $null = get-childitem

Another alternative, which also runs much faster is to use the [void] cast:

PS C:\> [void] (get-childitem)



PowerShell

    In PowerShell $? contains True if last operation succeeded and False otherwise.

	The exit code of the last Win32 executable execution is stored in the automatic variable $LASTEXITCODE

To read exit codes (other than 0 or 1) launch the PowerShell script and return the $LASTEXITCODE in a single line like this:

powershell.exe -noprofile C:\scripts\script.ps1; exit $LASTEXITCODE

PS> $LastExitCode
0
PS> $?
True

PS> ping googllll.com > output.msg 2> output.err
PS> Get-Content .\output.err
PS> Get-Content .\output.msg

If you’d like to go the “new school” way you could use Start-Process and use the -RedirectStandardError and -RedirectStandardOutput parameters, but they’d still just go to files.

