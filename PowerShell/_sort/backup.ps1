# rem  OK

robocopy C:\work e:\work\ /E /NFL /NDL

robocopy C:\apps e:\apps\ /E /NFL /NDL

robocopy C:\workspace\ e:\workspace\ /E /NFL /NDL

robocopy C:\workspace\_code e:\_code\ /E /NFL /NDL
robocopy C:\workspace\_txt e:\workspace\_txt /E /NFL /NDL
robocopy C:\workspace\_download e:\workspace\_download /E /NFL /NDL


#-------------------------------------------------------------------------
# split big ones inside \work

robocopy C:\work\_eBooks.ok E:\_eBooks-code /E /NFL /NDL

robocopy C:\work\_code E:\_code /E /NFL /NDL

robocopy C:\work\Documents E:\work\Documents /E /NFL /NDL

robocopy C:\work\pwd E:\work\pwd /E /NFL /NDL


robocopy C:\work1 e:\work\ /E /NFL /NDL

#-------------------------------------------------------------------------
# code

robocopy d:\source e:\source\ /E /NFL /NDL

# /E :: copy subdirectories, including Empty ones.
# /NS :: No Size - don't log file sizes.
# /NC :: No Class - don't log file classes.
# /NFL :: No File List - don't log file names.
# /NDL :: No Directory List - don't log directory names.
