-------------------------------------------------------------------------------------------------------------------------------
https://stackoverflow.com/questions/398871/update-all-objects-in-a-collection-using-linq


foreach (var item in collection)
{
    item..needsChange = value;
}

collection.ToList().ForEach(c => c.PropertyToSet = value);
collection.ToList().ForEach(c => { c.Property1ToSet = value1; c.Property2ToSet = value2; });

Collection.All(c => { c.needsChange = value; return true; });
Collection.ForEach(c => { c.needsChange = value; })

var result = numbers.Select(x => x + 3);

List<Employee> employees = EmployeeRepository.All();
IEnumerable<int> ids = employees.Select(x => x.Id);

var sum = employees.Where(x => x.CompanyTimeInYears > 5).Select(x => x.Salary).Sum();


public int Sum(IEnumerable<int> numbers)
{
    var result = 0;
    foreach (var number in numbers)
    {
        result += number;
    }

    return result;
}

var sum = number.Aggregate((x, y) => x + y);

var sum = numbers.Sum();


https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.all?view=net-7.0

-------------------------------------------------------------------------------------------------------------------------------
