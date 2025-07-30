@rem echo off
cd .\data

rem FOR /D /r %%G in ("Project.*") DO Echo We found %%~nxG

FOR /D /r %%G in ("Project.*") DO rmdir /S /Q %%~nxG\bin
FOR /D /r %%G in ("Project.*") DO rmdir /S /Q %%~nxG\obj

cd ..
pause