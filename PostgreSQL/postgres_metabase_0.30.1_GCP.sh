***** Metabase Staging on GCP (v.0.30.1) *****

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "fabian-test-metabase"
docker exec -t -u postgres metabase-db pg_dump metabase-db --username=postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
sudo docker exec -t -u postgres metabase-db pg_dumpall -c > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

gcloud compute scp --recurse --zone "asia-southeast1-b" fabian-test-metabase:/home/fabianalexander/dump_24-08-2018_03_29_18.sql /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/postgres/DB_dumps

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "dp-docker-metabase"
35.240.251.20 

sudo mkdir /usr/share/metabase-staging_postgres_pga
cd metabase-staging_postgres_pga

sudo yum check-update
sudo yum update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl status docker

sudo docker volume create --driver local --name=metabase-staging-pgvol
sudo docker volume create --driver local --name=metabase-staging-pglogvol
sudo docker volume create --driver local --name=metabase-staging-pga4vol

sudo docker network create --driver bridge metabase-staging-pgnetwork
a1f021dd97c9cd7f77b5e0a308666d10c53b511d796947a2fd6aac7811b077fd

sudo vi pg-env.list
PG_MODE=primary
PG_PRIMARY_USER=postgres
PG_PRIMARY_PASSWORD=password
PG_DATABASE=metabase
PG_USER=metabase
PG_PASSWORD=password
PG_ROOT_PASSWORD=password
PG_PRIMARY_PORT=5432
EOF

sudo vi pgadmin-env.list
PGADMIN_SETUP_EMAIL=user@domain.com
PGADMIN_SETUP_PASSWORD=password
SERVER_PORT=5050
EOF

sudo docker pull crunchydata/crunchy-postgres:centos7-10.5-2.1.0
sudo docker pull crunchydata/crunchy-pgadmin4:centos7-10.4-2.0.0
sudo docker pull metabase/metabase:v0.30.1
sudo docker pull metabase/metabase:v0.30.0
sudo docker pull metabase/metabase:v0.29.3

sudo docker tag 5d4fe855e8ae postgres:staging
sudo docker tag dd00a7d5905d pgadmin4:staging
sudo docker tag 8892387b6fc2 metabase:staging

sudo docker run --publish 5432:5432 \
  --volume=metabase-staging-pgvol:/var/lib/postgresql/data \
  --volume=metabase-staging-pglogvol:/var/log \
  --env-file=pg-env.list \
  --name="postgres-metabase-staging" \
  --hostname="postgres-metabase-staging" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  postgres:staging

sudo docker exec -it postgres-metabase-staging vi /pgdata/postgres-metabase-staging/postgresql.conf
log_directory = 'pg_log' 
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_statement = 'all'

sudo docker stop postgres-metabase-staging
sudo docker start postgres-metabase-staging

sudo docker run --publish 5050:5050 \
  --volume=metabase-staging-pga4vol:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name="pgadmin4-metabase-staging" \
  --hostname="pgadmin4-metabase-staging" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  pgadmin4:staging


sudo docker run --publish 5050:5050 \
  --volume=metabase-staging-pga4vol:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name="pgadmin4-metabase-staging" \
  --hostname="pgadmin4-metabase-staging" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  pgadmin-small:staging  

URL:		http://35.240.251.20:5050/browser/
Username:	user@domain.com
Password:	password

docker exec -t -u postgres metabase-db pg_dump metabase-db --username=postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

psql postgresql://postgres-metabase-staging:5432 -U postgres -f dump_22-08-2018_06_44_30.sql
psql postgresql://postgres-metabase-staging:5432 -U postgres -f dump_24-08-2018_03_29_18.sql

postgres
password
HOVjihGiyG

sudo docker run --publish 3000:3000 \
  --name metabase-staging \
  --network="metabase-staging-pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase-db" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=postgres" \
  -e "MB_DB_PASS=HOVjihGiyG" \
  -e "MB_DB_HOST=postgres-metabase-staging" \
  --detach \
  metabase:staging

sudo docker run --publish 3000:3000 \
  --name metabase-staging \
  --network="metabase-staging-pgnetwork" \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase-db" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=postgres" \
  -e "MB_DB_PASS=HOVjihGiyG" \
  -e "MB_DB_HOST=postgres-metabase-staging" \
  --detach \
  metabase/metabase:v0.29.3


* Google OAuth integration
name:			metabase-staging
URL:			http://metabase-staging.domain.com
client ID:		863016118673-gdpte1jokgri1g1mpaQ1@r9j0qhfo83b552n.apps.googleusercontent.com
client secret:	rFvOIZFSvZJn-bc5h1HEVs5VaeY




sudo usermod -aG docker fabianalexander





* NGINX 

gcloud compute scp --recurse --zone "asia-southeast1-b" /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/nginx dp-docker-metabase:/home/fabianalexander/transfer
/usr/share/metabase-staging_nginx
sudo cp /home/fabianalexander/transfer /usr/share/metabase-staging_nginx

sudo docker build -t nginx:staging .

sudo docker run --publish 443:443 --publish 80:80 \
--name nginx-metabase-staging  \
--network="metabase-staging-pgnetwork" \
--detach \
nginx:staging

sudo docker logs -f nginx-metabase-staging:staging



* Metabase Credentials Encryption

openssl rand -base64 32
77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=

export MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU='

java $JAVA_OPTS -jar /app/metabase.jar
MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=' java $JAVA_OPTS -jar /app/metabase.jar

bash-4.3# MB_ENCRYPTION_SECRET_KEY='77mcxJchMzoBPkpvM6jboKpHKSpNmzRp7IXKvPZAIFU=' java $JAVA_OPTS -jar /app/metabase.jar
08-23 03:01:24 INFO metabase.util :: Loading Metabase...
08-23 03:01:36 INFO util.encryption :: Saved credentials encryption is ENABLED for this Metabase instance. 🔐 
For more information, see https://www.metabase.com/docs/latest/operations-guide/start.html#encrypting-your-database-connection-details-at-rest



* Postgres Encryption

postgres=# CREATE EXTENSION btree_gist;
postgres=# CREATE EXTENSION pgcrypto;






* GCR
docker commit metabase-staging-v0.30.1 us.gcr.io/<PROJECT>/metabase.docker:latest
docker commit postgres-metabase-staging us.gcr.io/<PROJECT>/metabase.docker.postgres:latest
docker commit pgadmin4-metabase-staging us.gcr.io/<PROJECT>/metabase.docker.pgadmin4:latest
docker commit metabase-staging-nginx us.gcr.io/<PROJECT>/metabase.docker.nginx:latest

gcloud docker -- push us.gcr.io/<PROJECT>/metabase.docker:latest
gcloud docker -- push us.gcr.io/<PROJECT>/metabase.docker.postgres:latest
gcloud docker -- push us.gcr.io/<PROJECT>/metabase.docker.pgadmin4:latest
gcloud docker -- push us.gcr.io/<PROJECT>/metabase.docker.nginx:latest

docker pull us.gcr.io/<PROJECT>/metabase.docker:latest
docker pull us.gcr.io/<PROJECT>/metabase.docker.postgres:latest
docker pull us.gcr.io/<PROJECT>/metabase.docker.pgadmin4:latest
docker pull us.gcr.io/<PROJECT>/metabase.docker.nginx:latest



* docker commands to deploy container with GCR images

sudo docker run --publish 5432:5432 \
  --name="postgres-metabase-staging" \
  --hostname="postgres-metabase-staging" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  us.gcr.io/<PROJECT>/metabase.docker.postgres:latest

sudo docker run --publish 3000:3000 \
  --name="metabase-staging-v0.30.1" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  us.gcr.io/<PROJECT>/metabase.docker:latest

sudo docker run --publish 5050:5050 \
  --name="pgadmin4-metabase-staging" \
  --hostname="pgadmin4-metabase-staging" \
  --network="metabase-staging-pgnetwork" \
  --detach \
  us.gcr.io/<PROJECT>/metabase.docker.pgadmin4:latest

sudo docker run --publish 443:443 --publish 80:80 \
	--name nginx-metabase-staging  \
	--network="metabase-staging-pgnetwork" \
	--detach \
	us.gcr.io/<PROJECT>/metabase.docker.nginx:latest















