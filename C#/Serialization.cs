// https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/quality-rules/ca1869

// Using a local instance of JsonSerializerOptions for serialization or deserialization can substantially degrade the performance of your application if your code executes multiple times since System.Text.Json internally caches serialization-related metadata into the provided instance.


static string Serialize<T>(T value)
{
    JsonSerializerOptions jsonOptions = new()
    {
        WriteIndented = true
    };

    return JsonSerializer.Serialize(value, jsonOptions);
}

static T Deserialize<T>(string json)
{
    return JsonSerializer.Deserialize<T>(json, new JsonSerializerOptions { AllowTrailingCommas = true });
}

//---------------------------------------------------------------------------------------------------
// You can use the singleton pattern to avoid creating a new JsonSerializerOptions instance every time your code is executed.

private static readonly JsonSerializerOptions s_writeOptions = new()
{
    WriteIndented = true
};

private static readonly JsonSerializerOptions s_readOptions = new()
{
    AllowTrailingCommas = true
};

static string Serialize<T>(T value)
{
    return JsonSerializer.Serialize(value, s_writeOptions);
}

static T Deserialize<T>(string json)
{
    return JsonSerializer.Deserialize<T>(json, s_readOptions);
}
