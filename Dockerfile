ARG Version

FROM mcr.microsoft.com/dotnet/aspnet:$Version AS base
WORKDIR /app

# Use the official .NET 8 SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:$Version AS build
WORKDIR /src

# Copy solution and restore as distinct layers
COPY ["src/MicroSvc.Service/MicroSvcWeather/MicroSvcWeather.csproj", "src/MicroSvcWeather"]
RUN dotnet restore "src/MicroSvc.Service/MicroSvcWeather/MicroSvcWeather.csproj"
COPY..
WORKDIR /src/src/MicroSvc.Service/MicroSvcWeather
RUN dotnet build "MicroSvcWeather.csproj" -c Release -o /app/build

# Build the application
FROM build AS publish
RUN dotnet publish "MicroSvcWeather.csproj" -c Release -o /app/publish --no-restore

# Use the official .NET 8 ASP.NET runtime image for the final stage
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose port (adjust if your app uses a different port)
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["dotnet", "MicroSvcWeather.dll","--config-dir=/etc/config", "--log-dir=/data/logs", "--secrets-dir=/etc/secrets"]