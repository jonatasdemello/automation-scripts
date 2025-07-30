Write-Host "Removing [bin] and [obj] folder..."

Get-ChildItem .\ -include bin,obj -Recurse | ForEach-Object ($_) { remove-item $_.fullname -Force -Recurse }

Write-Host "Removing done."