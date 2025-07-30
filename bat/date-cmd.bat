set dt=%date:~10,4%%date:~4,2%%date:~7,2%

REM It should look more like this...

set mydate=%date:~10,4%%date:~6,2%/%date:~4,2%
echo %mydate%

REM If the date was Tue 12/02/2013 then it would display it as 2013/02/12.

REM To remove the slashes, the code would look more like

set mydate=%date:~10,4%%date:~7,2%%date:~4,2%
echo %mydate%

REM which would output 20130212

for /F "usebackq tokens=1,2,3 delims=-" %%I IN (`echo %date%`) do echo "%%I" "%%J" "%%K"

for /F "usebackq tokens=1,2,3 delims=-" %%I IN (`echo %date%`) do set dt=%%I-%%J-%%K
