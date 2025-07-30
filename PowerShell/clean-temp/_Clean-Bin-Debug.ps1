# remove bin & obj folders
#Get-ChildItem .\ -include bin,obj,artifacts -Recurse | foreach ($_) { $_.fullname }
#Get-ChildItem .\ -Include bin,obj,artifacts -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}

# remove bin & obj folders
#Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { $_.fullname }
#Get-ChildItem .\ -Include bin,obj -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}


Get-ChildItem -path .\ -Include bin,obj,artifacts -Recurse | foreach ($_) { remove-item -Path $_.fullname -Recurse -Force -ErrorAction SilentlyContinue}

Get-ChildItem -path .\ *.bak -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

#-----------------------------------------------------------------------
$include = @("node_modules","bin","obj","Debug","Octo","Release","packages")
$path = ".\"

Get-ChildItem -path $path -Include "node_modules" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "bin","obj" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "Debug" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "packages" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
Get-ChildItem -path $path -Include "aspnet_client" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose



# $path = ".\Project.API"
#$include = 'node_modules,bin,obj,Debug,Octo,Release,packages'
# $include = @("node_modules","bin","obj","Debug","Octo","Release","packages")

#	Get-ChildItem -path .\ -Include @("node_modules","bin","obj","Debug","Octo","Release","packages") -Directory -Recurse

Get-ChildItem -path .\ -Directory -Recurse `
	-Include @("node_modules","bin","obj","Debug","Octo","Release","packages","artifacts") `
	 | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose `
	 | Where { $_.PSIsContainer }

# Get-ChildItem -path $path -Include node_modules -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
# Get-ChildItem -path $path -Include bin,obj -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
# Get-ChildItem -path $path -Include Debug -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
# Get-ChildItem -path $path -Include packages -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose

$folders = Get-ChildItem -path .\ -Directory -Recurse `
	-Include @("node_modules","bin","obj","Debug","Octo","Release","packages","artifacts")

foreach ($folder in $folders) {
	$folder

# Get-ChildItem -path $folder  `
	# -Include @("node_modules","bin","obj","Debug","Octo","Release","packages","artifacts") -Directory -Recurse `
	 # | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
}


function deltedeFolder {
	param( $folder )
	Remove-Item $folder -Force -Recurse -ErrorAction SilentlyContinue | Where { $_.PSIsContainer }
}