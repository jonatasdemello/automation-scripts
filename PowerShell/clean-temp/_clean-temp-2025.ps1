#---------------------------------------------------------------------------------------------------
# Remove bin & obj folders (11:19 AM Wednesday, June 11, 2025)
#---------------------------------------------------------------------------------------------------

# show all files
# Get-ChildItem -path .\ -Include bin,obj -Directory -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}
# Get-ChildItem -path .\ -Include ".vs" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

$path = ".\"
$include = @("node_modules","bin","obj","Debug","Octo","Release","packages")

Get-ChildItem -path .\ -Include $include -Directory -Recurse | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

Get-ChildItem -path .\ -Include @("node_modules","bin","obj","Debug","Octo","Release","packages") -Directory -Recurse | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

Get-ChildItem -path $path -Include bin,obj -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include Debug -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include node_modules -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include packages -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
