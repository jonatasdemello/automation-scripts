/*
	Replace If condicional with Dictionary

	https://stackoverflow.com/questions/18752699/alternative-to-if-else-if
*/

if (txtvar.BillText.IndexOf("SWGAS.COM") > -1)
{
    txtvar.Provider = "Southwest Gas";
}
else if (txtvar.BillText.IndexOf("georgiapower.com") > -1)
{
    txtvar.Provider = "Georgia Power";
}
else if (txtvar.BillText.IndexOf("City of Austin") > -1)
{
    txtvar.Provider = "City of Austin";
}
// And so forth for many different strings

// I would like to use something like a switch statement to be more efficient and readable
// but I'm unsure of how I would compare the BillText.
// I'm looking for something like this but can't figure out how to make it work.

switch (txtvar.BillText)
{
    case txtvar.BillText.IndexOf("Southwest Gas") > -1:
        txtvar.Provider = "Southwest Gas";
        break;
    case txtvar.BillText.IndexOf("TexasGas.com") > -1:
        txtvar.Provider = "Texas Gas";
        break;
    case txtvar.BillText.IndexOf("Southern") > -1:
        txtvar.Provider = "Southern Power & Gas";
        break;
}

//-------------------------------------------------------------------------------------------------------------------------------

// What you want is a Dictionary:

Dictionary<string, string> mapping = new Dictionary<string, string>();

mapping["SWGAS.COM"] = "Southwest Gas";
mapping["foo"] = "bar";

// ... as many as you need, maybe read from a file ...
// Then just:

return mapping[inputString];

//-------------------------------------------------------------------------------------------------------------------------------
// Why not use everything C# has to offer?
// The following use of anonymous types, collection initializers, implicitly typed variables,
// and lambda-syntax LINQ is compact, intuitive,
// and maintains your modified requirement that patterns be evaluated in order:

var providerMap = new[] {
    new { Pattern = "SWGAS.COM"       , Name = "Southwest Gas" },
    new { Pattern = "georgiapower.com", Name = "Georgia Power" },
    // More specific first
    new { Pattern = "City of Austin"  , Name = "City of Austin" },
    // Then more general
    new { Pattern = "Austin"          , Name = "Austin Electric Company" }
    // And for everything else:
    new { Pattern = String.Empty      , Name = "Unknown" }
};

txtVar.Provider = providerMap.First(p => txtVar.BillText.IndexOf(p.Pattern) > -1).Name;

// More likely, the pairs of patterns would come from a configurable source, such as:

var providerMap =
    System.IO.File.ReadLines(@"C:\some\folder\providers.psv")
    .Select(line => line.Split('|'))
    .Select(parts => new { Pattern = parts[0], Name = parts[1] }).ToList();

Finally, as @millimoose points out, anonymous types are less useful when passed between methods. In that case we can define a trival Provider class and use object initializers for nearly identical syntax:

class Provider {
    public string Pattern { get; set; }
    public string Name { get; set; }
}

var providerMap =
    System.IO.File.ReadLines(@"C:\some\folder\providers.psv")
    .Select(line => line.Split('|'))
    .Select(parts => new Provider() { Pattern = parts[0], Name = parts[1] }).ToList();



-------------------------------------------------------------------------------------------------------------------------------
// dictionary to hold mappings
Dictionary<string, string> mapping = new Dictionary<string, string>();
// add your mappings here
// loop over the keys
foreach (KeyValuePair<string, string> item in mapping)
{
    // return value if key found
    if(txtvar.BillText.IndexOf(item.Key) > -1) {
        return item.Value;
    }
}

-------------------------------------------------------------------------------------------------------------------------------

One more using LINQ and Dictionary

var mapping = new Dictionary<string, string>()
                        {
                            { "SWGAS.COM", "Southwest Gas" },
                            { "georgiapower.com", "Georgia Power" }
                            .
                            .
                        };

return mapping.Where(pair => txtvar.BillText.IndexOf(pair.Key) > -1)
              .Select(pair => pair.Value)
              .FirstOrDefault();

If we prefer empty string instead of null when no key matches we can use the ?? operator:

return mapping.Where(pair => txtvar.BillText.IndexOf(pair.Key) > -1)
              .Select(pair => pair.Value)
              .FirstOrDefault() ?? "";

If we should consider the dictionary contains similar strings we add an order by, alphabetically, shortest key will be first, this will pick 'SCE' before 'SCEC'

return mapping.Where(pair => txtvar.BillText.IndexOf(pair.Key) > -1)
              .OrderBy(pair => pair.Key)
              .Select(pair => pair.Value)
              .FirstOrDefault() ?? "";


