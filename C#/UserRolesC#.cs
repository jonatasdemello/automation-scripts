
// After creating the user record in Register post action

var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
var result = await UserManager.CreateAsync(user, model.Password);

// You can add the roles

await UserManager.AddToRoleAsync(user.Id, "role1");
await UserManager.AddToRoleAsync(user.Id, "role2");



//You can't pass multiple roles to the IsInRole function. But you can use the || functionality in c# as below.

@if (User.IsInRole("System Administrator") || User.IsInRole("Administrator"))
{
    //your code here
}


Roles
https://learn.microsoft.com/en-us/aspnet/core/security/authorization/roles?view=aspnetcore-7.0

https://learn.microsoft.com/en-us/aspnet/core/security/authentication/individual?view=aspnetcore-7.0

https://learn.microsoft.com/en-us/aspnet/core/security/authentication/identity?view=aspnetcore-7.0&tabs=visual-studio


EF
https://learn.microsoft.com/en-us/ef/core/dbcontext-configuration/
https://learn.microsoft.com/en-us/dotnet/core/extensions/generic-host
https://learn.microsoft.com/en-us/dotnet/core/extensions/logging?tabs=command-line
https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection
https://learn.microsoft.com/en-us/dotnet/core/extensions/configuration
https://learn.microsoft.com/en-us/dotnet/core/extensions/options

https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/options?view=aspnetcore-7.0
https://learn.microsoft.com/en-us/aspnet/core/tutorials/choose-web-ui?view=aspnetcore-6.0
https://learn.microsoft.com/en-us/dotnet/standard/commandline/

