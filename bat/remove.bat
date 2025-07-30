@ECHO OFF
@IF "%~1"=="" ( GOTO InvalidParameters )

ECHO .
ECHO . Removing folder [%1]
ECHO .

del /f/s/q %1 > nul
rmdir /s/q %1

GOTO Done

:InvalidParameters

ECHO Usage: remove.bat [folder]

:Done

ECHO . done