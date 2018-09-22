***** metabase *****

* API

curl -X GET \
  -H "Content-Type: application/json" \
  -H "X-Metabase-Session: 38f4939c-ad7f-4cbe-ae54-30946daf8593" \
  http://localhost:3000/api/user/current

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "export@a.com", "password": "password1"}' \
  http://metabase.ascendanalyticshub.com:3000/api/session 

* Metabase - Docker Setup with PostgreSQL and PGadmin

dpage/pgadmin4
postgres
metabase/metabase

docker run -d -p 5432:5432 \
	--name postgres \
	-e POSTGRES_PASSWORD=metabase \
	-e POSTGRES_USER=metabase \
	-e POSTGRES_DB=metabase \
	-d postgres

docker run -p 81:80 \
	--name pgadmin \
	-e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
	-e "PGADMIN_DEFAULT_PASSWORD=password" \
	-d dpage/pgadmin4

docker run -d -p 3000:3000 \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=metabase" \
  -e "MB_DB_PASS=metabase" \
  -e "MB_DB_HOST=localhost" \
  --name metabase metabase/metabase

docker run -d -p 3000:3000 --name metabase metabase/metabase


* Metabase - Docker Setup with PostgreSQL and PGadmin (improved)

https://info.crunchydata.com/blog/easy-postgresql-10-and-pgadmin-4-setup-with-docker

mkdir postgres
cd postgres

docker volume create --driver local --name=pgvol
docker volume create --driver local --name=pglogvol
docker volume create --driver local --name=pga4vol
docker network create --driver bridge pgnetwork
fe3ee2a1114b7af7cad1c78c79e4df4fc0f1d6eb387147e3fc5a8d900bf30897

vi pg-env.list
PG_MODE=primary
PG_PRIMARY_USER=postgres
PG_PRIMARY_PASSWORD=password
PG_DATABASE=metabase
PG_USER=metabase
PG_PASSWORD=metabase
PG_ROOT_PASSWORD=rootpassword
PG_PRIMARY_PORT=5432
EOF

vi pgadmin-env.list
PGADMIN_SETUP_EMAIL=user@domain.com
PGADMIN_SETUP_PASSWORD=password
SERVER_PORT=5050
EOF

vi metabase-env.list
EOF

=============================


=============================

docker run --publish 5432:5432 \
  --volume=pgvol:/var/lib/postgresql/data \
  --volume=pglogvol:/var/log \
  --env-file=pg-env.list \
  --name="postgres" \
  --hostname="postgres" \
  --network="pgnetwork" \
  --detach \
	crunchydata/crunchy-postgres:centos7-10.5-2.1.0

docker exec -it postgres vi /pgdata/postgres/postgresql.conf
log_directory = 'pg_log' 
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_statement = 'all'
docker stop postgres
docker start postgres

docker run --publish 5050:5050 \
  --volume=pga4vol:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name="pgadmin4" \
  --hostname="pgadmin4" \
  --network="pgnetwork" \
  --detach \
  	crunchydata/crunchy-pgadmin4:centos7-10.4-2.0.0

docker run --publish 3000:3000 \
  --name metabase \
  --network="pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=metabase" \
  -e "MB_DB_PASS=metabase" \
  -e "MB_DB_HOST=postgres" \
  --detach \
  metabase/metabase

http://localhost:5050
user@domain.com
password

Object -> Create -> Server
Name:				metabase-pg10
Hostname: 			postgres
Port:				5432
maintenance DB:		postgres
Username:			metabase
Password:			metabase

http://localhost:3000
user@domain.com
password1

Add database
Type:				PostgreSQL
name:				metabase-pg10
Host:				postgres
Port:				5432
Database name:		metabase
Database username:	metabase
Database password:	metabase

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "fabian-test-metabase"

Backup:
docker exec -t -u postgres your-db-container pg_dumpall -c > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
docker exec -t your-db-container pg_dumpall -c --username=postgres | gzip > /var/data/postgres/backups/dump_date +%d-%m-%Y"_"%H_%M_%S.gz
docker exec -t -u postgres metabase-db pg_dumpall -c > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

docker exec -t -u postgres metabase-db pg_dump metabase-db --username=postgres | gzip > dump_`date +%d-%m-%Y"_"%H_%M_%S`.gz
docker exec -t -u postgres metabase-db pg_dump metabase-db --username=postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
docker exec -t -u postgres metabase-db pg_dump metabase-db -t "tablename" --username=postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

docker exec -t -u postgres metabase-db pg_dump -Fc metabase-db --username=postgres | gzip > dump_`date +%d-%m-%Y"_"%H_%M_%S`.gz
docker exec -t -u postgres metabase-db pg_dump -Fc metabase-db --username=postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

gcloud compute scp --recurse [INSTANCE_NAME]:[REMOTE_DIR] [LOCAL_DIR]
gcloud compute scp --recurse --zone "asia-southeast1-b" fabian-test-metabase:/home/fabianalexander/postgresBAK/dump_22-08-2018_04_39_54.sql /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/postgres/DB_dumps
gcloud compute scp --recurse --zone "asia-southeast1-b" fabian-test-metabase:/home/fabianalexander/postgresBAK/dump_22-08-2018_04_41_15.gz /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/postgres/DB_dumps
gcloud compute scp --recurse --zone "asia-southeast1-b" fabian-test-metabase:/home/fabianalexander/postgresBAK/* /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/postgres/DB_dumps
gcloud compute scp --recurse --zone "asia-southeast1-b" fabian-test-metabase:/home/fabianalexander/dump_24-08-2018_02_43_44.sql /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/postgres/DB_dumps

Restore:
cat your_dump.sql | docker exec -i your-db-container psql --username postgres
cat dump_22-08-2018_03_45_57.sql | docker exec -i postgres psql metabase -U metabase -W metabase
cat dump_22-08-2018_03_45_57.sql | docker exec -i postgres psql postgresql://postgres:5432 --username metabase --password metabase
cat dump_22-08-2018_03_45_57.sql | docker exec -i postgres psql postgresql://postgres:5432 --username=postgres --password=rootpassword
cat dump_22-08-2018_06_01_22.sql | docker exec -i postgres psql postgresql://postgres:5432 --username=postgres --password=rootpassword


psql postgresql://postgres:5432/metabase 



docker exec -it <CONTAINER> gunzip < backup.tar.gz | pg_restore -U <USER> -F t -d <DB>
docker exec -it metabase gunzip < dump_22-08-2018_04_41_15.gz | pg_restore -U postgres -F t -d metabase


docker exec -i postgres pg_restore -C --clean --no-acl --no-owner -U postgres -d metabase-db < dump_22-08-2018_05_05_29.sql

docker exec -it postgres psql -U postgres metabase < dump_22-08-2018_05_05_29.sql
psql -U postgres database < file.sql



cat backup.sql | docker exec -i [POSTGRESQL_CONTAINER] /usr/bin/psql -h [POSTGRESQL_HOST] -U [POSTGRESQL_USER] [POSTGRESQL_DATABASE]
cat backup_all.sql | docker exec -i [POSTGRESQL_CONTAINER] /usr/bin/psql -h [POSTGRESQL_HOST] -U [POSTGRESQL_USER]
cat dump_22-08-2018_06_01_22.sql | docker exec -i postgres /usr/bin/psql -h postgres -U postgres -W rootpassword
cat dump_22-08-2018_06_01_22.sql | docker exec -i postgres /usr/bin/psql -h postgres -U metabase -W metabase


pg_restore -i -h localhost -p 5432 -U postgres -d metabase -v dump_22-08-2018_06_01_22.sql
psql postgresql://postgres:5432 -U postgres -f dump_22-08-2018_06_01_22.sql
HOVjihGiyG


docker run --publish 3000:3000 \
  --name metabase0.29.3 \
  --network="pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase-db" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=metabase" \
  -e "MB_DB_PASS=metabase" \
  -e "MB_DB_HOST=postgres" \
  --detach \
  metabase/metabase:v0.29.3


docker run --publish 3000:3000 \
  --name metabase0.30.0 \
  --network="pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase-db" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=postgres" \
  -e "MB_DB_PASS=HOVjihGiyG" \
  -e "MB_DB_HOST=postgres" \
  --detach \
  metabase/metabase:v0.30.0


docker run --publish 3000:3000 \
  --name metabase \
  --network="pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase-db" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=postgres" \
  -e "MB_DB_PASS=HOVjihGiyG" \
  -e "MB_DB_HOST=postgres" \
  --detach \
  metabase/metabase

postgres
HOVjiQ4!hGiyG

export@a.com
password1

user@domain.com
tDCz4jYdWyOY1QAw



openssl rand -base64 32
77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=

export MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU='

java $JAVA_OPTS -jar /app/metabase.jar
MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=' java $JAVA_OPTS -jar /app/metabase.jar

bash-4.3# MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=' java $JAVA_OPTS -jar /app/metabase.jar
08-23 03:01:24 INFO metabase.util :: Loading Metabase...
08-23 03:01:36 INFO util.encryption :: Saved credentials encryption is ENABLED for this Metabase instance. 🔐 
For more information, see https://www.metabase.com/docs/latest/operations-guide/start.html#encrypting-your-database-connection-details-at-rest




postgres=# CREATE EXTENSION btree_gist;
CREATE EXTENSION
postgres=# CREATE EXTENSION pgcrypto;
CREATE EXTENSION























