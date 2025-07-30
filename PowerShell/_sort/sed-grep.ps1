# grep and sed equivalent in PowerShell

(svn info filename) -match '^Last Changed Date:' -replace '^Last Changed Date: '

(svn info filename) -replace "(?sm).*?^Last Changed Date: (.*?)$.*","`$1"

svn info filename | Select-String '^Last Changed Date: (.*)$' | ForEach-Object{$_.Matches.Groups[1].Value}

# cat = Get-Content

cat file.txt | foreach {$_.replace("a","b")} | out-file newfile

cat file.txt | foreach {$_ -replace "\W", ""} # -replace operator uses regex

cat file.txt | foreach {$_.replace("abc","def")} # string.Replace uses text matching



