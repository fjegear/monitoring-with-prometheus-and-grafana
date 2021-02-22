# Build

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
RUN mkdir /app
WORKDIR /app

COPY ./src/WebAPI/*.csproj ./
RUN dotnet restore

COPY ./src/WebAPI ./
RUN dotnet build
RUN dotnet publish -c Release -o out

# Deploy

FROM mcr.microsoft.com/dotnet/aspnet:5.0
RUN mkdir /app
WORKDIR /app

COPY --from=build-env /app/out ./

EXPOSE 80

ENTRYPOINT ["dotnet", "WebAPI.dll"]