@echo off

:start
REM Start time storage
set ST=%time%
echo Process started at %ST%
echo.
echo.

REM Your commands
REM Your commands
REM Your commands

:end
REM Start Time Definition
for /f "tokens=1-3 delims=:" %%a in ("%ST%") do set /a h1=%%a & set /a m1=%%b & set /a s1=%%c

REM End Time Definition
for /f "tokens=1-3 delims=:" %%a in ("%TIME%") do set /a h2=%%a & set /a m2=%%b & set /a s2=%%c

REM Difference
set /a h3=%h2%-%h1% & set /a m3=%m2%-%m1% & set /a s3=%s2%-%s1%

REM Time Adjustment
if %h3% LSS 0 set /a h3=%h3%+24
if %m3% LSS 0 set /a m3=%m3%+60 & set /a h3=%h3%-1
if %s3% LSS 0 set /a s3=%s3%+60 & set /a m3=%m3%-1

echo Start    :    %ST%
echo End    :    %time%
echo.
echo Total    :    %h3%:%m3%:%s3%
echo.
pause