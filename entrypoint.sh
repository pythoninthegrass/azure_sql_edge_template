#!/usr/bin/env bash

set -e

MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD:-'Yukon900'}
MSSQL_DATABASE=${MSSQL_DATABASE:-'adventure-works'}
MSSQL_BACKUP=${MSSQL_BACKUP:-'/var/opt/mssql/backup/AdventureWorks2022.bak'}

# start sql server
/opt/mssql/bin/sqlservr &

# wait for sql server to start
sleep 10

# restore database
/opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-P "$MSSQL_SA_PASSWORD" \
	-d tempdb \
	-q "EXIT(RESTORE DATABASE $MSSQL_DATABASE FROM DISK = $MSSQL_BACKUP)"
