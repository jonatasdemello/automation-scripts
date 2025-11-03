rem remove directory

for /d /r "C:\Start_Path" %%d in ("Folder_Name_to_Delete") do (
    if exist "%%d" (
        rmdir /s /q "%%d"
    )
)

rem for one liner:

for /d /r "." %d in ("*") do rd /s /q "%d"
