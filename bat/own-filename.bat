Echo Off
REM  Show own filename
REM 	Use the special %0 variable to get the path to the current file.
REM 	Write %~n0 to get just the filename without the extension.
REM 	Write %~n0%~x0 to get the filename and extension.
REM 	Also possible to write %~nx0 to get the filename and extension

echo %0
echo %~n0
echo %~n0%~x0
echo %~nx0
