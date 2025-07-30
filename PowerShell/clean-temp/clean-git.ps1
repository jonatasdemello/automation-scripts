# clean git
Get-ChildItem -path .\ -Include ".git" -Directory -Recurse -Force | Remove-Item -force -Recurse -ErrorAction SilentlyContinue -verbose
