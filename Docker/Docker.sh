# Run Docker container
docker run --publish 3000:3000 \
  --name metabase \
  --network="metabase-network" \
  --env-file=metabase-env.list \
  --detach \
  <DOCKER_REGISTRY>/metabase.docker:latest \

MB_ENCRYPTION_SECRET_KEY=AGCzjwP8TcZ1bZUc+xbBp3p/lHTAiblxO9lredIeycqwYfHKrzSq/uX1Eo679IGN81FGPtULjJFC0TizusLL4Q==

docker inspect metabase -f '{{ .Config.Env }}'

docker exec -d metabase /bin/bash -c 

docker network create --driver bridge --subnet 172.0.0.0/29 metabase-network 

#!/bin/bash

docker exec -d metabase /bin/bash -c openssl rand -base64 64 > $MB_ENCRYPTION_SECRET_KEY
MB_ENCRYPTION_SECRET_KEY='IYqrSi5QDthvFWe4/WdAxhnra5DZC3RKx3ZSrOJDKsM=' java -jar metabase.jar

Cdn7gPW2E/gD6Gtf9s//HdVZVEawtwWsVq1gj+4ZDJxNd7QE5CisWXC+KOgOdXIcqiCJFAQFFMBk0OI0sbPagg==



openssl rand -base64 64 2> $MB_ENCRYPTION_SECRET_KEY

openssl rand -base64 64 | wc -c > $MB_ENCRYPTION_SECRET_KEY



# Run Docker container
docker run --publish 3000:3000 \
  --name metabase \
  --network="metabase-network" \
  --env-file=metabase-env.list \
  --detach \
  <DOCKER_REGISTRY>/metabase.docker:latest \

# Create Key on Docker Host
openssl rand -base64 64 > MB_ENCRYPTION_SECRET_KEY.txt

# Copy MB_ENCRYPTION_SECRET_KEY.txt to metabase Docker container
docker cp ./MB_ENCRYPTION_SECRET_KEY.txt metabase:/tmp/
docker cp ./metabase-enable-encryption.sh metabase:/tmp/

# Read MB_ENCRYPTION_SECRET_KEY.txt and store into $MB_ENCRYPTION_SECRET_KEY variable
docker exec -d metabase /tmp/metabase-enable-encryption.sh











# Read MB_ENCRYPTION_SECRET_KEY.txt and store into $MB_ENCRYPTION_SECRET_KEY variable
MB_ENCRYPTION_SECRET_KEY=`cat /tmp/MB_ENCRYPTION_SECRET_KEY.txt`
echo "$MB_ENCRYPTION_SECRET_KEY"

# Enable Metabase db connection details encryption at rest
MB_ENCRYPTION_SECRET_KEY='$MB_ENCRYPTION_SECRET_KEY' java -jar /app/metabase.jar





docker run --publish 3000:3000 \
  --name metabase \
  --network="metabase-network" \
  --env-file=metabase-env.list \
  -e "MB_ENCRYPTION_SECRET_KEY=`cat MB_ENCRYPTION_SECRET_KEY.txt`" \
  --detach \
  us.gcr.io/dataplatform-1363/acm.dp.metabase.docker:latest


docker run --publish 5432:5432 \
  --env-file=pg-env.list \
  --name="postgres-metabase" \
  --hostname="postgres-metabase" \
  --network="metabase-network" \
  --detach \
  postgres:latest


docker run --publish 5432:5432 \
  --volume /Users/fabianalexander/Documents/bitbucket_repo/acm-dp-metabase-docker-postgres/pgdata/data:/var/lib/postgresql/data \
  --env-file=pg-env.list \
  --name="postgres-metabase" \
  --hostname="postgres-metabase" \
  --network="metabase-network" \
  --detach \
  postgres:latest


docker run --publish 5432:5432 \
  --env-file=pg-env.list \
  --name="postgres-metabase" \
  --hostname="postgres-metabase" \
  --network="metabase-network" \
  --detach \
  us.gcr.io/dataplatform-1363/acm.dp.metabase.docker.postgres:latest


docker run --publish 5432:5432 \
  --volume "$PWD/data:/var/lib/postgresql/data" \
  --env-file=pg-env.list \
  --name="postgres-metabase" \
  --hostname="postgres-metabase" \
  --network="metabase-network" \
  --detach \
  us.gcr.io/dataplatform-1363/acm.dp.metabase.docker.postgres:latest




/Users/fabianalexander/Documents/bitbucket_repo/acm-dp-metabase-docker-postgres/pgdata/data

docker cp postgres-metabase:/var/lib/postgresql/data /Users/fabianalexander/Documents/bitbucket_repo/acm-dp-metabase-docker-postgres/




echo [ALIASES...] \
>> ~/.bashrc

alias docker-clean-unused='docker system prune --all --force --volumes'
alias docker-clean-all='docker stop $(docker container ls -a -q) && docker system prune -a -f --volumes'

source ~/.bashrc





echo "alias docker-clean-unused='docker system prune --all --force --volumes'
alias docker-clean-all='docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes'" \
>> ~/.bashrc && source ~/.bashrc





docker container stop $(docker container ls -a -q)
docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes

docker container rm $(docker container ls -a -q)
docker image rm $(docker image ls -a -q)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)

docker rmi $(docker images -f "dangling=true" -q)

docker kill $(docker ps -q)
docker_clean_ps
docker rmi $(docker images -a -q)

docker image prune -a
docker container prune 
docker volume prune
docker network prune
docker system prune
docker system prune --all --force --volumes

docker build --no-cache

docker volume rm $(docker volume ls -qf dangling=true)
docker volume ls -qf dangling=true | xargs -r docker volume rm

docker network ls  
docker network ls | grep "bridge"   
docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }')

docker images
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker rmi --f $(docker images --filter dangling=true -q)

docker images | grep "none"
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')

docker ps
docker ps -a
docker rm $(docker ps -qa --no-trunc --filter "status=exited")

docker-machine create --driver virtualbox --virtualbox-disk-size "40000" default

docker rm $(docker ps -a -q)

docker rmi $(docker images -q)




docker kill metabase postgres-metabase
docker rm metabase postgres-metabase
docker system prune -a -f
docker volume prune -f


schyrerf@gmail.com
password1

admin@abc.com
1QRjwCU7hdPUiX

user@abc.com
D3VTBwfussdGFk





docker build .
docker image list



docker tag ed37dfa3cdd4 us.gcr.io/tmn-th-equator-ci/acn.dp.generic.database.etl:latest
gcloud docker -- push us.gcr.io/tmn-th-equator-ci/acn.dp.generic.database.etl:latest


docker tag cae9e58fef87 us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest
gcloud docker -- push us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest




docker run -p 8089:8080 us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest /bin/bash 

docker run -ti -d -P -p 22:22 8089:8080 --name acm-dp-jenkins-docker-base-FABIAN us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest  /bin/bash

docker run -ti -p 8089:8080 -h jenkins --name acm_dp_jenkins_docker_base_fabian us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest /bin/bash

docker run -ti -p 8089:8080 us.gcr.io/dataplatform-1363/acm-dp-jenkins-docker-base:latest /bin/bash

# Delete all Images 
docker ps -a -q
docker rmi $(docker images -q) -f

# Delete all running containers
docker kill $(docker ps -q)

# Delete all stopped containers
docker rm $(docker ps -a -q)

docker exec -it [container-id] bash














