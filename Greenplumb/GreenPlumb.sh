# GreenPlumb

git clone https://github.com/kongyew/greenplum-oss-docker
cd greenplum-oss-docker/gpdb
./build_docker.sh

docker run -it –hostname=gpdbsne \
–name gpdb5oss \
–publish 5432:5432 \
–publish 88:22 \
–volume `pwd`:/code \
kochanpivotal/gpdb5oss bin/bash

docker pull pivotaldata/gpdb-devel


# PG Admin

docker volume create --driver local --name=pga4volume

docker run --publish 5050:5050 \
  --volume=pga4volume:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name=pgadmin4 \
  --hostname=pgadmin4 \
  --detach \
crunchydata/crunchy-pgadmin4:centos7-10.9-2.4.1

vi pgadmin-env.list
PGADMIN_SETUP_EMAIL=schyrerf@gmail.com
PGADMIN_SETUP_PASSWORD=password
SERVER_PORT=5050

http://localhost:5050





