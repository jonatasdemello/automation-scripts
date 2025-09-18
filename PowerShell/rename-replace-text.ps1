Get-ChildItem -Path .\ -Filter "*.pdf" -Include "" -Recurse | Rename-Item -NewName { $_.Name -replace "\]\[", "_" }
Get-ChildItem -Path .\ -Filter "*.pdf" -Recurse | Rename-Item -NewName { $_.Name -replace "^\[", "" }
Get-ChildItem -Path .\ -Filter "*.pdf" -Recurse | Rename-Item -NewName { $_.Name -replace "\].pdf", ".pdf" }

# remove comma
Get-ChildItem -Path .\ -Filter "*.pdf" -Include "*,*" -Recurse | Rename-Item -NewName { $_.Name -replace ",", "" }