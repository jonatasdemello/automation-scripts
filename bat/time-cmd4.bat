@echo off & setlocal

set start=%time%

REM Do stuff to be timed here.
REM Alternatively, uncomment the line below to be able to
REM pass in the command to be timed when running this script.
REM cmd /c %*

set end=%time%

REM Calculate time taken in seconds, to the hundredth of a second.
REM Assumes start time and end time will be on the same day.

set options="tokens=1-4 delims=:."

for /f %options% %%a in ("%start%") do (
    set /a start_s="(100%%a %% 100)*3600 + (100%%b %% 100)*60 + (100%%c %% 100)"
    set /a start_hs=100%%d %% 100
)

for /f %options% %%a in ("%end%") do (
    set /a end_s="(100%%a %% 100)*3600 + (100%%b %% 100)*60 + (100%%c %% 100)"
    set /a end_hs=100%%d %% 100
)

set /a s=%end_s%-%start_s%
set /a hs=%end_hs%-%start_hs%

if %hs% lss 0 (
    set /a s=%s%-1
    set /a hs=100%hs%
)
if 1%hs% lss 100 set hs=0%hs%

echo.
echo  Time taken: %s%.%hs% secs
echo.
