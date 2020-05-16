# Build

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-bionic as build-env

WORKDIR /app

COPY ./src/WebAPI/*.csproj ./
RUN dotnet restore

COPY ./src/WebAPI ./
RUN dotnet publish -c Release -o webapi

# Deploy

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-bionic

WORKDIR /app

COPY --from=build-env /app/webapi ./

EXPOSE 80

ENTRYPOINT ["dotnet", "WebAPI.dll"]