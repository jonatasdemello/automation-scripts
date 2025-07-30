# remove bin & obj folders
#Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { $_.fullname }
#Get-ChildItem .\ -Include bin,obj -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}

$include = @("node_modules","bin","obj","Debug","Octo","Release","packages")

$path = ".\"

Get-ChildItem -path $path -Include "node_modules" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

Get-ChildItem -path $path -Include "bin","obj" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "Debug" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "packages" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

Get-ChildItem -path $path -Include "aspnet_client" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

