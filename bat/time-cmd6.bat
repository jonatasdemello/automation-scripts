::tiemeit.cmd
@echo off
Setlocal EnableDelayedExpansion

call :clock

::call your_command  or more > null to pipe this batch after your_command

call :clock

echo %timed%
pause
goto:eof

:clock
if not defined timed set timed=0
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
set /A timed = "(((1%%a - 100) * 60 + (1%%b - 100)) * 60 + (1%%c - 100))  * 100 + (1%%d - 100)- %timed%"
)
goto:eof
