

gcloud container images list --repository=<DOCKER_REGISTRY>

gcloud container images list-tags <DOCKER_REGISTRY>/java.gcloud

gcloud container images describe <DOCKER_REGISTRY>/java.gcloud
gcloud container images describe <DOCKER_REGISTRY>/java.gcloud:latest
gcloud container images describe <DOCKER_REGISTRY>/java.gcloud@sha256:<SHA256>

gcloud container images list-tags --format='get(digest)'  <DOCKER_REGISTRY>/java.gcloud
gcloud container images list-tags --format='get(tag)'  <DOCKER_REGISTRY>/java.gcloud


docker run -ti <ID> /bin/bash

docker ps

docker ps -a

docker images

docker images -a

docker rmi <ID>