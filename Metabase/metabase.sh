docker pull metabase/metabase
docker run -d -p 3000:3000 --name metabase metabase/metabase
docker logs -f metabase

docker run -d -p 3000:3000 -v /Users/fabianalexander/Documents/Documents/Projects_internal/Metabase/metabase-data:/metabase-data -e "MB_DB_FILE=/metabase-data/metabase.db" --name metabase metabase/metabase

docker ps -a
docker commit ca072cd44a49 mycompany/metabase-custom
docker run -d -p 3000:3000 --name metabase mycompany/metabase-custom

docker run -d -p 3000:3000 \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=postgres" \
  -e "MB_DB_PASS=password" \
  -e "MB_DB_HOST=localhost" \
  --name metabase metabase/metabase

###################################################################################

docker pull postgres
docker run -d -p 5432:5431 --name postgres postgres
docker run --name postgres -e POSTGRES_PASSWORD=password -d postgres
docker run --name metabase --link postgres:postgres -d metabase
docker run -it --rm --link postgres:postgres postgres psql -h postgres -U postgres

gcloud container clusters create fabian-metabase --machine-type=f1-micro --num-nodes=1 --region=asia-southeast1 --tags=metabase-test 
docker tag cae9e58fef87 us.gcr.io/<PROJECT>/fabian-gke-metabase:latest
gcloud docker -- push us.gcr.io/<PROJECT>/fabian-gke-metabase:latest

Cluster IP:			10.51.240.242
Loadbalancer IP:	35.240.138.54
External Endpoint:	35.240.138.54:3000 

###################################################################################

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "fabian-test-metabase"

sudo yum install yum-utils
sudo curl -fsSL https://get.docker.com/ | sh 
sudo systemctl start docker

sudo docker pull metabase/metabase
sudo docker run -d -p 80:3000 -v /home/fabianalexander/metabase_storage/metabase-data:/metabase-data -e "MB_DB_FILE=/metabase-data/metabase.db" --name metabase metabase/metabase
sudo docker run -d -p 80:3000 --name metabase metabase/metabase
sudo docker logs -f metabase

Internal IP:		x.x.x.x
External IP:		x.x.x.x.

Client ID:			863016118673-i3AxjGggr6d7imdg6srq4g95qp7e02kl9l9g.apps.googleusercontent.com
Client Secret:		Mos0VrWfuWy1tHn8Bt3DKlo0hPR9Fi

<script src="https://apis.google.com/js/platform.js" async defer></script>

http://x.x.x.x
http://metabase.domain.com/




