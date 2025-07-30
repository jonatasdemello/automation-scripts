https://www.nuget.org/packages/asyncenumerator/

https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.parallel.foreachasync?view=net-9.0
https://www.hanselman.com/blog/parallelforeachasync-in-net-6

using Dasync.Collections;


       public async Task<int> SendAndRemoveFromQueueParallelAsync(IEnumerable<FamilyEmailModel> emailQueue)
       {
           Console.WriteLine("SendAndRemoveFromQueueParallelAsync {0} ", emailQueue.Count());
           if (emailQueue.Any())
           {
               await emailQueue.ParallelForEachAsync(async email =>
               {
                   /// Send one email message using MailGun or SMTP service
                   var result = await SendMessageAsync(email);

                   // Process response from MailGun
                   var emailresult = ConvertReason(result);

                   // remove from Queue after sending, in case the batch fails
                   await _emailRepository.EmailQueueProcess(email.EmailId, emailresult);
               }
               , maxDegreeOfParallelism: 10);
           }
           return emailQueue.Count();
       }

//---------------------------------------------------------------------------------------------------
            if (emailQueue.Any())
            {
                // try to process emails in parallel
                ParallelOptions parallelOptions = new()
                {
                    MaxDegreeOfParallelism = 5
                };
                await Parallel.ForEachAsync(emailQueue, parallelOptions, async (email, cancellationToken) =>
                {
                    // Send one email message using MailGun
                    List<EmailFailure> result = await SendMessageAsync(email);

                    if (result.Any())
                    {
                        // log bad emails
                        string emailresult = ConvertReason(result);
                        await _emailRepository.EmailQueueProcess(email.EmailId, emailresult);
                    }
                });
            }
            // add to log, update satus, delete from Family.EmailQueue and Family.Email
            await _emailRepository.EmailQueueProcessList(emailQueue);
            return emailQueue.Count();
        }