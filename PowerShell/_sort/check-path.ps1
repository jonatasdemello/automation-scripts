# c:\temp
$p0=Get-Location c:\temp
$p1=Get-Location c:\temp\1

$p0
$p1

$paths0 = (Get-ChildItem $p0 -Directory).FullName
$paths1 = (Get-ChildItem $p1 -Directory).FullName

$paths0
$paths1

"using @"
$paths00 = @(Get-ChildItem $p0 -Directory).FullName
$paths11 = @(Get-ChildItem $p1 -Directory).FullName

$paths00
$paths11

$paths10.GetType()
$paths11.GetType()

$paths111 = @((Get-ChildItem $p1 -Directory).FullName)
$paths111.GetType()

$paths000 = @((Get-ChildItem $p0 -Directory).Fullname)
$paths000.GetType()

$paths00 |% { $_ }
$paths01 |% { $_ }
$paths11 |% { $_ }
$paths11 |% { "ss " $_ }
$paths11 |% { "ss " + $_ }
$paths00 |% { "ss " + $_ }
$paths11 |% { "ss " + $_ }

if (!$paths11) { Write-Host "variable is null" }
if (!$paths00) { Write-Host "variable is null" }

$foo.count -gt 0

PS C:\temp> $paths11.count -gt 0
True
PS C:\temp> $paths00.count -gt 0
True
PS C:\temp> $paths00.count
8
PS C:\temp> $paths11.count
1

$null -eq $foo

PS C:\temp> $null -eq $foo
True
PS C:\temp> $null -eq $paths00
False
PS C:\temp> $null -eq $paths11
False
PS C:\temp> $null -eq $paths11[0]
True
PS C:\temp> $paths11 |% { $null -eq $_ }
True
PS C:\temp> $paths00 |% { $null -eq $_ }
False
False
False
False
False
False
False
False

$paths00 |% { "ss " + $_ }
$paths11 |% { "ss " + $_ }
$paths11 -eq $nul
$paths11 -eq $null
$paths11
$paths11 -eq ""
$paths11.GetType()
$paths11 ?? "null" : "ol"
if (!$paths11) { Write-Host "variable is null" }
if (!$paths00) { Write-Host "variable is null" }
$paths11.count -gt 0
$paths00.count -gt 0
$paths00.count
$paths11.count
$null -eq $foo
$null -eq $paths00
$null -eq $paths11
$null -eq $paths11[0]
$paths11 |% { "ss " + $_.GetType() }
$paths11 |% { "ss " + $null -eq $_ }
$paths11 |% { $null -eq $_ }
$paths00 |% { $null -eq $_ }
$paths0 |% { $null -eq $_ }
$paths1 |% { $null -eq $_ }
$null -eq $paths1
$null -eq $paths0
$null -ne $paths0
$null -ne $paths1