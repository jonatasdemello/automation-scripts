Powershell String Concat
One way is:

	Write-Host "$($assoc.Id)  -  $($assoc.Name)  -  $($assoc.Owner)"

Another one is:

	Write-Host  ("{0}  -  {1}  -  {2}" -f $assoc.Id,$assoc.Name,$assoc.Owner )

Or just (but I don't like it ;) ):

	Write-Host $assoc.Id  "  -  "   $assoc.Name  "  -  "  $assoc.Owner
