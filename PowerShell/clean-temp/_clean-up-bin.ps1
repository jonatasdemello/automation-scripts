# remove bin & obj folders

$dirs = "dir1", "dir2", "dir3", "dir4"

foreach ($folder in $dirs) {
	Get-ChildItem -path .\$folder -Directory -Recurse `
	-Include @("node_modules","bin","obj","Debug","Octo","Release","packages", "TestResults") `
	 | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose `
	 | Where { $_.PSIsContainer }
}


function deltedeFolder {
	param( $folder )
	Remove-Item $folder -Force -Recurse -ErrorAction SilentlyContinue | Where { $_.PSIsContainer }
}