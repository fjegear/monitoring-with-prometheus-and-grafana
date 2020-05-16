# Build

FROM microsoft/dotnet:2.2-sdk AS build-env
RUN mkdir /app
WORKDIR /app

COPY ./src/WebAPI/*.csproj ./
RUN dotnet restore

COPY ./src/WebAPI ./
RUN dotnet build
RUN dotnet publish -c Release -o out

# Deploy

FROM microsoft/dotnet:2.2-aspnetcore-runtime
RUN mkdir /app
WORKDIR /app

COPY --from=build-env /app/out ./

EXPOSE 80

ENTRYPOINT ["dotnet", "WebAPI.dll"]