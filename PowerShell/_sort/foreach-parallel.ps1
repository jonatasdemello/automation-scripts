https://devblogs.microsoft.com/powershell/powershell-foreach-object-parallel-feature/



Normally, when you use the ForEach-Object cmdlet, each object piped to the cmdlet is processed sequentially.

1..5 | ForEach-Object { "Hello $_"; sleep 1 }
Hello 1
Hello 2
Hello 3
Hello 4
Hello 5

(Measure-Command {
    1..5 | ForEach-Object { "Hello $_"; sleep 1 }
}).Seconds
5

But with the new ForEach-Object -Parallel parameter set, you can run all script in parallel for each piped input object.

1..5 | ForEach-Object -Parallel { "Hello $_"; sleep 1; } -ThrottleLimit 5
Hello 1
Hello 3
Hello 2
Hello 4
Hello 5

(Measure-Command {
    1..5 | ForEach-Object -Parallel { "Hello $_"; sleep 1; } -ThrottleLimit 5
}).Seconds
1


This new feature also supports jobs, where you can choose to have a job object returned instead of having results written to the console.

$Job = 1..5 | ForEach-Object -Parallel { "Hello $_"; sleep 1; } -ThrottleLimit 5 -AsJob
$job | Wait-Job | Receive-Job
Hello 1
Hello 2
Hello 3
Hello 5
Hello 4


However, there is still quite a bit of overhead to run script blocks in parallel. Script blocks run in a context called a PowerShell runspace. The runspace context contains all of the defined variables, functions and loaded modules. So initializing a runspace for script to run in takes time and resources. When scripts are run in parallel they must be run within their own runspace. And each runspace must load whatever module is needed and have any variable be explicitly passed in from the calling script. The only variable that automatically appears in the parallel script block is the piped in object. Other variables are passed in using the $using: keyword.

$computers = 'computerA','computerB','computerC','computerD'
$logsToGet = 'LogA','LogB','LogC'

# Read specified logs on each machine, using custom module
$logs = $computers | ForEach-Object -ThrottleLimit 10 -Parallel {
    Import-Module MyLogsModule
    Get-Logs -ComputerName $_ -LogName $using:logsToGet
}


# https://devblogs.microsoft.com/scripting/parallel-processing-with-jobs-in-powershell/


Below are two different ways to do a WMI Query as a job:

Get-WMIObject Win32_OperatingSystem -AsJob

Or

Start-Job {Get-WMIObject Win32_OperatingSystem}

After the job has been kicked off, you can check on the status of the job by running the Get-Job command, noting the State and HasMoreData values. The State will change to Completed when the job has finished and the  HasMoreData value will indicate if there is output.

Get-Job

Once the job has completed, you can use the Receive-Job cmdLet to get the data from the command.

Receive-Job -Id 3

Note that the HasMoreData value has now changed to False after running the Receive-Job command:

The important thing to remember here is that you have one chance to get the information from the job so make sure that you capture it in a variable if the output needs to be evaluated.

$JobOutput = Receive-Job -Id 1

Once you are done getting the job’s output, the job will basically hang out there until you remove it by running the Remove-Job Cmdlet.

Remove-Job -Id 1



# Loop through the server list
Get-Content "ServerList.txt" | %{

  # Define what each job does
  $ScriptBlock = {
    param($pipelinePassIn)
    Test-Path "\\$pipelinePassIn\c`$\Something"
    Start-Sleep 60
  }

  # Execute the jobs in parallel
  Start-Job $ScriptBlock -ArgumentList $_
}

Get-Job

# Wait for it all to complete
While (Get-Job -State "Running")
{
  Start-Sleep 10
}

# Getting the information back from the jobs
Get-Job | Receive-Job




$block = {
    Param([string] $file)
    "[Do something]"
}
#Remove all jobs
Get-Job | Remove-Job
$MaxThreads = 4
#Start the jobs. Max 4 jobs running simultaneously.
foreach($file in $files){
    While ($(Get-Job -state running).count -ge $MaxThreads){
        Start-Sleep -Milliseconds 3
    }
    Start-Job -Scriptblock $Block -ArgumentList $file
}
#Wait for all jobs to finish.
While ($(Get-Job -State Running).count -gt 0){
    start-sleep 1
}
#Get information from each job.
foreach($job in Get-Job){
    $info= Receive-Job -Id ($job.Id)
}
#Remove all jobs created.
Get-Job | Remove-Job

