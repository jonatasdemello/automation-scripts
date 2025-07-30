https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection

// Service registration methods
// The framework provides service registration extension methods that are useful in specific scenarios:

// Each services.Add{LIFETIME}<{SERVICE}> extension method adds (and potentially configures) services.

//-------------------------------------------------------------------------------------------------------------------------------
// Add{LIFETIME}<{SERVICE}, {IMPLEMENTATION}>()

	services.AddSingleton<IMyDep, MyDep>();

//-------------------------------------------------------------------------------------------------------------------------------
// Add{LIFETIME}<{SERVICE}>(sp => new {IMPLEMENTATION})

	services.AddSingleton<IMyDep>(sp => new MyDep());
	services.AddSingleton<IMyDep>(sp => new MyDep(99));

//-------------------------------------------------------------------------------------------------------------------------------
// Add{LIFETIME}<{IMPLEMENTATION}>()

	services.AddSingleton<MyDep>();

//-------------------------------------------------------------------------------------------------------------------------------
// AddSingleton<{SERVICE}>(new {IMPLEMENTATION})

	services.AddSingleton<IMyDep>(new MyDep());
	services.AddSingleton<IMyDep>(new MyDep(99));

//-------------------------------------------------------------------------------------------------------------------------------
// AddSingleton(new {IMPLEMENTATION})

	services.AddSingleton(new MyDep());
	services.AddSingleton(new MyDep(99));

/*
Transient

Transient lifetime services are created each time they're requested from the service container. This lifetime works best for lightweight, stateless services. Register transient services with AddTransient.
In apps that process requests, transient services are disposed at the end of the request.

Scoped

For web applications, a scoped lifetime indicates that services are created once per client request (connection). Register scoped services with AddScoped.
In apps that process requests, scoped services are disposed at the end of the request.

Singleton

Singleton lifetime services are created either:

    The first time they're requested.
    By the developer, when providing an implementation instance directly to the container. This approach is rarely needed.

Every subsequent request of the service implementation from the dependency injection container uses the same instance. If the app requires singleton behavior, allow the service container to manage the service's lifetime. Don't implement the singleton design pattern and provide code to dispose of the singleton. Services should never be disposed by code that resolved the service from the container. If a type or factory is registered as a singleton, the container disposes the singleton automatically.
*/
-------------------------------------------------------------------------------------------------------------------------------

// appsettings.json file:
{
    "SecretKey": "Secret key value",
    "TransientFaultHandlingOptions": {
        "Enabled": true,
        "AutoRetryDelay": "00:00:07"
    },
    "Logging": {
        "LogLevel": {
            "Default": "Information",
            "Microsoft": "Warning",
            "Microsoft.Hosting.Lifetime": "Information"
        }
    }
}

// TransientFaultHandlingOptions class:
public sealed class TransientFaultHandlingOptions
{
    public bool Enabled { get; set; }
    public TimeSpan AutoRetryDelay { get; set; }
}

// When using the options pattern, an options class:
    // Must be non-abstract with a public parameterless constructor
    // Contain public read-write properties to bind (fields are not bound) => has { get; set; }

// The following code is part of the Program.cs C# file and:
    // Calls ConfigurationBinder.Bind to bind the TransientFaultHandlingOptions class to the "TransientFaultHandlingOptions" section.
    // Displays the configuration data.


using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using ConsoleJson.Example;

using IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureAppConfiguration((hostingContext, configuration) =>
    {
        configuration.Sources.Clear();

        IHostEnvironment env = hostingContext.HostingEnvironment;

		// load from json
        configuration
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile($"appsettings.{env.EnvironmentName}.json", true, true);

        IConfigurationRoot configurationRoot = configuration.Build();

		// bind section "TransientFaultHandlingOptions" to the TransientFaultHandlingOptions instance.
        TransientFaultHandlingOptions options = new();
        configurationRoot.GetSection(nameof(TransientFaultHandlingOptions))
                         .Bind(options);

		// the ConfigurationBinder.Get<T> is used to acquire an instance of the TransientFaultHandlingOptions
		// object with its property values populated from the underlying configuration.
		var options = configurationRoot.GetSection(nameof(TransientFaultHandlingOptions))
                     .Get<TransientFaultHandlingOptions>();

        Console.WriteLine($"TransientFaultHandlingOptions.Enabled={options.Enabled}");
        Console.WriteLine($"TransientFaultHandlingOptions.AutoRetryDelay={options.AutoRetryDelay}");
    })
    .Build();

// Application code should start here.

await host.RunAsync();


// to bind the "TransientFaultHandlingOptions" section and add it to the dependency injection service container.
// TransientFaultHandlingOptions is added to the service container with Configure and bound to configuration:

services.Configure<TransientFaultHandlingOptions>(
    configurationRoot.GetSection(key: nameof(TransientFaultHandlingOptions)));

// To access both the services and the configurationRoot objects, you must use the ConfigureServices method
// the IConfiguration is available as the HostBuilderContext.Configuration property.

Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        var configurationRoot = context.Configuration;
        services.Configure<TransientFaultHandlingOptions>(
            configurationRoot.GetSection(nameof(TransientFaultHandlingOptions)));
    });



// using the positon options
using Microsoft.Extensions.Options;

namespace ConsoleJson.Example;

public sealed class ExampleService
{
    private readonly TransientFaultHandlingOptions _options;

    public ExampleService(IOptions<TransientFaultHandlingOptions> options) =>
        _options = options.Value;

    public void DisplayValues()
    {
        Console.WriteLine($"TransientFaultHandlingOptions.Enabled={_options.Enabled}");
        Console.WriteLine($"TransientFaultHandlingOptions.AutoRetryDelay={_options.AutoRetryDelay}");
    }
}


// OptionsBuilder API
services.AddOptions<MyOptions>("optionalName")
    .Configure<ExampleService, ScopedService, MonitorService>(
        (options, es, ss, ms) => options.Property = DoSomethingWith(es, ss, ms));

// -------------------------------------------------------------------------------------------------------------------------------

// Extends an instance of IServiceCollection
// Calls OptionsServiceCollectionExtensions.AddOptions<TOptions>(IServiceCollection) with the type parameter of LibraryOptions
// Chains a call to Configure, which specifies the default option values

using Microsoft.Extensions.DependencyInjection;

namespace ExampleLibrary.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddMyLibraryService(
        this IServiceCollection services)
    {
        services.AddOptions<LibraryOptions>()
            .Configure(options =>
            {
                // Specify default option values
            });

        // Register lib services here...
        // services.AddScoped<ILibraryService, DefaultLibraryService>();

        return services;
    }
}

// or BindConfiguration extension method
		services.AddOptions<LibraryOptions>()
			.Configure<IConfiguration>(
				(options, configuration) =>
					configuration.GetSection("LibraryOptions").Bind(options));


// Extends an instance of IServiceCollection
// Defines an IConfiguration parameter namedConfigurationSection
// Calls Configure<TOptions>(IServiceCollection, IConfiguration) passing the generic type parameter of LibraryOptions and the namedConfigurationSection instance to configure

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace ExampleLibrary.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddMyLibraryService(
      this IServiceCollection services,
      IConfiguration namedConfigurationSection)
    {
        // Default library options are overridden
        // by bound configuration values.
        services.Configure<LibraryOptions>(namedConfigurationSection);

        // Register lib services here...
        // services.AddScoped<ILibraryService, DefaultLibraryService>();

        return services;
    }
}


//-------------------------------------------------------------------------------------------------------------------------------

// Action<TOptions> parameter
// Consumers of your library may be interested in providing a lambda expression that yields an instance of your options class.
// In this scenario, you define an Action<LibraryOptions> parameter in your extension method.

using Microsoft.Extensions.DependencyInjection;

namespace ExampleLibrary.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddMyLibraryService(
        this IServiceCollection services,
        Action<LibraryOptions> configureOptions)
    {
        services.Configure(configureOptions);

        // Register lib services here...
        // services.AddScoped<ILibraryService, DefaultLibraryService>();

        return services;
    }
}

// In the preceding code, the AddMyLibraryService:
//
//     Extends an instance of IServiceCollection
//     Defines an Action<T> parameter configureOptions where T is LibraryOptions
//     Calls Configure given the configureOptions action
//
// Consumers in this pattern provide a lambda expression (or a delegate that satisfies the Action<LibraryOptions> parameter):

using ExampleLibrary.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

using IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureServices(services =>
    {
        services.AddMyLibraryService(options =>
        {
            // User defined option values
            // options.SomePropertyValue = ...
        });
    })
    .Build();

// Application code should start here.

await host.RunAsync();
