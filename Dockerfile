# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore as distinct layers
COPY src/MicroSvc.Service/MicroSvcWeather/*.csproj ./
RUN dotnet restore ./MicroSvcWeather.csproj

# Copy the rest of the source code
COPY src/MicroSvc.Service/MicroSvcWeather/. ./

# Publish the application
RUN dotnet publish MicroSvcWeather.csproj -c Release -o /app/publish --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose port 80 (and 443 for HTTPS if needed)
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "MicroSvcWeather.dll"]