itemsFromSystemA
    .AsParallel()
    .WithDegreeOfParallelism(Convert.ToInt32(Math.Ceiling((Environment.ProcessorCount * 0.75) * 2.0)))
    .ForAll(itemId => {        var item = GetItemFromSystemA(itemId);        var result = MigrateToSystemB(item);        SaveToSystemB(result);    });



Parallel
	https://www.nuget.org/packages/AsyncEnumerator
	https://github.com/Dasync/AsyncEnumerable
	https://stackoverflow.com/questions/15136542/parallel-foreach-with-asynchronous-lambda


You can use the ParallelForEachAsync extension method from AsyncEnumerator NuGet Package:

using Dasync.Collections;

var bag = new ConcurrentBag<object>();
await myCollection.ParallelForEachAsync(async item =>
{
  // some pre stuff
  var response = await GetData(item);
  bag.Add(response);
  // some post stuff
}, maxDegreeOfParallelism: 10);
var count = bag.Count;




https://www.hanselman.com/blog/how-to-run-background-tasks-in-aspnet
https://www.hanselman.com/blog/introducing-windows-azure-webjobs


General: Hangfire (or similar similar open source libraries)
	used for writing background tasks in your ASP.NET website
Cloud: Azure WebJobs
	A formal Azure feature used for offloading running of background tasks outside of your Website and scale the workload
Advanced: Azure Worker Role in a Cloud Service
	scale the background processing workload independently of your Website and you need control over the machine

Hangfire
	https://www.hangfire.io/overview.html
FluentScheduler
	https://github.com/jgeurts/FluentScheduler?WT.mc_id=-blog-scottha
Quartz.NET
	http://www.quartz-scheduler.net/

https://docs.hangfire.io/en/latest/tutorials/highlight.html


Web Jobs
https://docs.microsoft.com/en-us/azure/app-service/webjobs-dotnet-deploy-vs
https://docs.microsoft.com/en-us/azure/app-service/webjobs-create
https://docs.microsoft.com/en-us/azure/app-service/webjobs-dotnet-deploy-vs
https://docs.microsoft.com/en-us/azure/app-service/webjobs-sdk-how-to
https://docs.microsoft.com/en-us/azure/app-service/webjobs-sdk-get-started
https://github.com/Azure/azure-webjobs-sdk/wiki
https://stackify.com/azure-webjobs-vs-azure-functions/


Profiler:
https://github.com/MiniProfiler/dotnet

