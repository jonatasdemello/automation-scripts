docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<password>' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<password>" -p 11143:1433 --name sql19-23 -v D:\Docker:/sql -d mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu

docker start SQL19-23
