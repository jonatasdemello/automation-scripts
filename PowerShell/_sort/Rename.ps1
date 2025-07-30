# Rename files

Dir | Rename-Item –NewName { $_.name –replace "old","new" }
Dir | Rename-Item –NewName { $_.extention –replace ".bat",".ps1" }
Dir | Rename-Item –NewName { "--" + $_.name }


gci *.sql | ren -newname { $_.name -replace 'dbo','pubs'}


Get-ChildItem | Rename-Item -NewName { $_.Name -replace '_1','_2' }

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }
Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.ps1' }

Get-ChildItem -Path C:\Temp\*.txt | ForEach-Object { Rename-Item $_ -NewName "File$i.csv"}

Get-Item Path1\* | Move-Item -Destination Path2

Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.txt','.log' }
Get-ChildItem *.txt | Rename-Item -NewName { $_.Name -replace '.pdf','1.pdf' } | Move-Item -Destination Path2


#-------------------------------------------------------------------------------------------------------------------------------

Rename-Item -Path C:\Example\oldname.txt -NewName C:\Example\newname.txt

Move-Item -Path C:\Temp\Oldname.txt -Destination C:\Temp\newname.txt -Force

Get-ChildItem -Path "C:\Temp" -Recurse -Include "*.txt" | Rename-Item -NewName { $_.Name -replace " ","-" }
Get-ChildItem -Path "C:\Temp" | Rename-Item -NewName {$_.Name -replace "oldname", "newname"}

# the regular expression pattern (\d{4})-(\d{2})-(\d{2}) matches dates in the format “YYYY-MM-DD”
Get-ChildItem -Path "C:\Docs" -File | Rename-Item -NewName {$_.Name -replace '(\d{4})-(\d{2})-(\d{2})', '$2-$3-$1'}

# The regular expression pattern [^\w\s\.-] matches any character that is not a word character, a whitespace character, a dot, or a hyphen.
Get-ChildItem -Path "C:\Documents" -Filter "*.txt" | Rename-Item -NewName { $_.Name -replace "[^\w\s\.-]", "" }


Get-ChildItem -Path "C:\Temp\Logs" -Recurse -Include "*.txt" | ForEach-Object -Begin { $Counter = 1 } -Process { Rename-Item $_ -NewName "Log_$Counter.log" ; $Counter++ }

-------------------------------------------------------------------------------------------------------------------------------
#Get the Timestamp
$TimeStamp = Get-Date -F yyyy-MM-dd_HH-mm
#Get all text files from a Folder and rename them by appending Timestamp
Get-ChildItem -Path "C:\Temp" -Recurse -Include "*.txt" | ForEach-Object {
    Rename-Item -Path $_.FullName -NewName "$($_.DirectoryName)\$($_.BaseName)_$TimeStamp$($_.Extension)"
}
-------------------------------------------------------------------------------------------------------------------------------
#Get all text files from a Folder and rename them by appending Timestamp
Get-ChildItem -Path "C:\Temp" -Recurse -Include "*.txt" | ForEach-Object {
    Rename-Item $_.FullName -NewName "$($_.DirectoryName)\AppLog - $($_.BaseName)$($_.Extension)"
}
-------------------------------------------------------------------------------------------------------------------------------
$i = 1
Get-ChildItem -Path C:\Temp\*.txt | ForEach-Object {
   Rename-Item $_ -NewName "File$i.csv"
   $i++
}
-------------------------------------------------------------------------------------------------------------------------------
Get-ChildItem index.*.txt | ForEach-Object {
    $NewName = $_.Name -replace "^(index\.)(.*)",'$2'
    $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
    Move-Item -Path $_.FullName -Destination $Destination -Force
}
-------------------------------------------------------------------------------------------------------------------------------
#Parameters
$Folder = "C:\Reports"
$Prefix = "MyPrefix_"
$Suffix = "_MySuffix"

#Add Prefix and Suffix to All Files in the Folder
Get-ChildItem -Path $Folder | ForEach-Object {
    $NewName = '{0}{1}{2}{3}' -f $Prefix,$_.BaseName,$Suffix,$_.Extension
    Rename-Item -Path $_.FullName -NewName $NewName
}
-------------------------------------------------------------------------------------------------------------------------------
#Get All Txt Files from C:\Logs Folder
$Files = Get-ChildItem C:\Logs\*.txt
 #Change File extention from .txt to .log
ForEach ($File in $Files) {
    Rename-Item -Path $File.FullName -NewName ($File.Name -replace ".txt", ".log")
    Write-host "Renamed File:"$File.FullName
}
-------------------------------------------------------------------------------------------------------------------------------
# Rename Files to Sentence Case in PowerShel

# Directory path
$Directory = "C:\Temp\Logs"

#Get All Files from the Folder
Get-ChildItem -Path $Directory -File | ForEach-Object {
    #Frame the File name
    $NewName = ($_.BaseName.Substring(0,1).ToUpper() + $_.BaseName.Substring(1).ToLower()) + $_.Extension
    #powershell sentence case files
    Rename-Item -Path $_.FullName -NewName $NewName
}
-------------------------------------------------------------------------------------------------------------------------------
# changing file names to title case?

# Directory path
$Directory = "C:\Temp\Logs"

#Get the current system culture
$Culture = [System.Globalization.CultureInfo]::CurrentCulture
$TextInfo = $culture.TextInfo

# Get All Files from the Folder
Get-ChildItem -Path $Directory -File -Recurse | ForEach-Object {
    #Frame the File name
    $NewName = $textInfo.ToTitleCase($_.BaseName) + $_.Extension
    #Rename the File
    Rename-Item -Path $_.FullName -NewName $NewName
}
-------------------------------------------------------------------------------------------------------------------------------
#Parameter
$OldFile = "C:\Logs\OldFile.txt"
$NewFile = "C:\Logs\NewFile.log"

#PowerShell to rename file if exists
If (Test-Path $OldFile) {
    Rename-Item -Path $OldFile -NewName $NewFile
    Write-host "'$OldFile' has been renamed to '$NewFile'" -f Green
}
Else{
    Write-host "'$OldFile' does not exists!" -f Yellow
}
-------------------------------------------------------------------------------------------------------------------------------
#Parameter
$OldFile = "C:\Logs\OldFile.txt"
$NewFile = "C:\Logs\NewFile.log"

#PowerShell to rename file if exists
If (Test-Path $OldFile) {
    #Check if the Target File Exists
    If (Test-Path $NewFile) {
        #Delete the target file
        Remove-Item $NewFile
    }
    Rename-Item -Path $OldFile -NewName $NewFile
    Write-host "'$OldFile' has been renamed to '$NewFile'" -f Green
}
Else{
    Write-host "'$OldFile' does not exists!" -f Yellow
}



Get-ChildItem | %{Rename-Item $_ -NewName ("NEW-FILE-NAME-{0}.EXTENSION" -f $nr++)}
Get-ChildItem | %{Rename-Item $_ -NewName ("beach-trip-2022-{0}.jpg" -f $nr++)}

Get-ChildItem | Rename-Item -NewName {$_.name.substring(0,$_.BaseName.length-N) + $_.Extension}
Get-ChildItem | Rename-Item -NewName {$_.name.substring(0,$_.BaseName.length-8) + $_.Extension}

Get-ChildItem | Rename-Item -NewName {$_.name -replace "OLD-FILE-NAME-PART",""}
Get-ChildItem | Rename-Item -NewName {$_.name -replace "-be",""}

Get-ChildItem | Rename-Item -NewName { $_.Name -replace " ","SEPARATOR" }
Get-ChildItem | Rename-Item -NewName { $_.Name -replace " ","_" }

Get-ChildItem | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, ".NEW-EXTENSION") }
Get-ChildItem | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "doc") }

Get-ChildItem -filter *.EXTENSION | %{Rename-Item $_ -NewName ("NEW-FILE-NAME-{0}.EXTENSION" -f $nr++)}
Get-ChildItem -filter *.jpg | %{Rename-Item $_ -NewName ("beach-trip-{0}.jpg" -f $nr++)}

