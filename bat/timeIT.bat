:: --- TimeIt.cmd ----
    @echo off
    setlocal enabledelayedexpansion

    call :ShowHelp

    :: Set pipeline initialization time
    set t1=%time%

    :: Wait for stdin
    more

    :: Set time at which stdin was ready
    set t2=!time!


    :: Calculate difference
    Call :GetMSeconds Tms1 t1
    Call :GetMSeconds Tms2 t2

    set /a deltaMSecs=%Tms2%-%Tms1%
    echo Execution took ~ %deltaMSecs% milliseconds.

    endlocal
goto :eof

:GetMSeconds
    Call :Parse        TimeAsArgs %2
    Call :CalcMSeconds %1 %TimeAsArgs%

goto :eof

:CalcMSeconds
    set /a %1= (%2 * 3600*1000) + (%3 * 60*1000) + (%4 * 1000) + (%5)
goto :eof

:Parse

    :: Mask time like " 0:23:29,12"
    set %1=!%2: 0=0!

    :: Replace time separators with " "
    set %1=!%1::= !
    set %1=!%1:.= !
    set %1=!%1:,= !

    :: Delete leading zero - so it'll not parsed as octal later
    set %1=!%1: 0= !
goto :eof

:ShowHelp
    echo %~n0 V1.0 [Dez 2015]
    echo.
    echo Usage: ^<Command^> ^| %~nx0
    echo.
    echo Wait for pipe getting ready... :)
    echo  (Press Ctrl+Z ^<Enter^> to Cancel)
goto :eof
