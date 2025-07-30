$logPath = "C:\inetpub\mailroot\Badmail"
$maxDaystoKeep = -5
$cleanupRecordPath = "C:\scripts\Log_Cleanup.log"

$itemsToDelete = dir $logPath -Recurse -File *.B* | Where LastWriteTime -lt ((get-date).AddDays($maxDaystoKeep))

If ($itemsToDelete.Count -gt 0)
{
    ForEach ($item in $itemsToDelete)
    {
        "$($item.FullName) is older than $((get-date).AddDays($maxDaystoKeep)) and will be deleted." | Add-Content $cleanupRecordPath
        Remove-Item $item.FullName -Verbose
    }
}
Else
{
    "No items to be deleted today $($(Get-Date).DateTime)." | Add-Content $cleanupRecordPath
}

Write-Output "Cleanup of log files older than $((get-date).AddDays($maxDaystoKeep)) completed!"

Start-Sleep -Seconds 10
