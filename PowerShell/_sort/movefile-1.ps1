
Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.pdf','1.pdf' } | Move-Item -Destination Path2

Get-ChildItem | rename-item -NewName { $_.Name -replace '_1','' }


Get-ChildItem *.txt -File | Move-Item -Destination Path2

gci "*ubun*" -File | mv -destination .\linux\
