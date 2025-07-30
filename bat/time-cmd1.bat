@echo off
for /f %%t in ('powershell "(get-date).tofiletime()"') do set mst=%%t

rem some commands

powershell ((get-date).tofiletime() - %mst%)
