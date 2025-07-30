
DateTime dateTime = DateTime.Now;
DateTime other = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);

Console.WriteLine(dateTime + " " + dateTime.Kind); // 6/1/2011 4:14:54 PM Local
Console.WriteLine(other + " " + other.Kind);       // 6/1/2011 4:14:54 PM Utc

DateTime utcDateTime = new DateTime(dateTime.Year, dateTime.Month, dateTime.Day, dateTime.Hour, dateTime.Minute, dateTime.Second, DateTimeKind.Utc)

