using Microsoft.AspNetCore;
using MicroSvcWeather;
using System.Diagnostics.CodeAnalysis;

[ExcludeFromCodeCoverage]
public static class Program
{
    public static void Main(string[] args) =>
        BuildWebHost(args).Run();

    public static IWebHost BuildWebHost(string[] args) =>
        WebHost.CreateDefaultBuilder(args)
        .ConfigureAppConfiguration(ConfigConfiguration)
            .UseStartup<Startup>()
            .Build();

    private static void ConfigConfiguration(WebHostBuilderContext context, IConfigurationBuilder builder)
    {
        var env = context.HostingEnvironment;
        builder.SetBasePath(env.ContentRootPath)
               .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
               .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true, reloadOnChange: true)
               .AddEnvironmentVariables();
    }
}