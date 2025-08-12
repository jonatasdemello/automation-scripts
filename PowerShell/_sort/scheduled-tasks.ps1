# show Scheduled Tasks

Get-ScheduledTask

Get-ScheduledTask | Get-ScheduledTaskInfo

Get-ScheduledTask | Sort-Object TaskName, State, TaskPath

Get-ScheduledTask -TaskName '*Update*'
