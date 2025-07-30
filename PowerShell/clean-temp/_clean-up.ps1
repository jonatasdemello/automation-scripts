# remove bin & obj folders
#Get-ChildItem .\ -Include bin,obj -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}

Get-ChildItem -path .\ -Include bin,obj -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path .\ -Include node_modules -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path .\ -Include Debug -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path .\ -Include packages -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

#clean-up VS folders

gci bin -directory -recurse | remove-item -recurse -force
gci obj -directory -recurse | remove-item -recurse -force
