
Setup Containerized PARSE 				DONE
	NGINX 								DONE
	PARSE 								DONE
	PARSE-Dashboard						DONE
	mongoDB								DONE
	Jenkins								DONE

Setup hardened base RHEL image			DONE
	Create Audit Report 				DONE
	Export OVF							DONE

Setup Docker-Host 						DONE
	Docker 								DONE						
	git									DONE
	Hardening 							DONE
	Export OVF							DONE

Setup Docker- Registry 					DONE
	Docker Registry (Container)			DONE
	git 								DONE
	Hardening 							DONE
	Export OVF							DONE

Setup Provisioning Host 				DONE
	git  								DONE
	Terraform 							DONE
	Packer 								DONE
	Vault								DONE
	Ansible								DONE
	Export OVF							DONE

Setup containerized ELK 				DONE
	ElasticSearch 						DONE
	Logstash 							DONE
	Kibana 								DONE
	create docker-compose.yml 			DONE
	Test 								DONE

Setup FreeNAS							DONE
	CIFS								DONE
	NFS									DONE
	iSCSI								DONE
	Export OVF 							DONE

Setup hardened CentOS image 			DONE
	Create Audit Report 				DONE
	Export OVF							DONE

Setup SCAP-Workbench VM					DONE
	Install SCAP-Workbench 				DONE
	Create Audit Report(s)				DONE
	Export OVF 							DONE

Setup containerized Artifactory 		DONE
	Create docker-compose.yml 			DONE
	Test 								DONE

Setup containerized Nexus 				DONE
	Create docker-compose.yml 			DONE
	Test 								DONE

####################################################################################################

DOCKER HOST

sudo yum update -y
sudo yum install git -y

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo usermod -aG docker pag
sudo systemctl enable docker
sudo systemctl stop docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service


####################################################################################################

DOCKER REGISTRY

https://computingforgeeks.com/install-and-configure-docker-registry-on-centos-7/

sudo yum -y update
sudo yum -y install git
sudo yum -y install docker-distribution


sudo vi /etc/docker-distribution/registry/config.yml

version: 0.1
log:
  fields:
    service: registry
storage:
    cache:
        layerinfo: inmemory
    filesystem:
        rootdirectory: /var/lib/registry
http:
    addr: :5000


sudo firewall-cmd --add-port=5000/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl start docker-distribution
sudo systemctl enable docker-distribution

vi  /etc/docker/daemon.json

{
 "insecure-registries" : ["myregistry.local:5000"]
 }

systemctl restart docker


vi /etc/hosts
192.168.1.23 myregistry.local

docker pull ubuntu:16.04
docker tag ubuntu:16.04 myregistry.local:5000/ubuntu:16.04
docker push myregistry.local:5000/ubuntu:16.04

ls /var/lib/registry/docker/registry/v2/repositories

docker pull registry-hostname:500/image:tag

####################################################################################################

PROVISIONING HOST

udo yum -y update
sudo yum -y install git npm

unzip ABC
mv ABC /usr/bin

####################################################################################################

ELASTICSEARCH, KIBANA, LOGSTASH - ELK

https://elk-docker.readthedocs.io/#tweaking-the-image
https://logz.io/blog/elk-stack-on-docker/
https://logz.io/blog/docker-logging/
https://logz.io/blog/docker-logging-elk-stack-part-two/
https://logz.io/learn/docker-monitoring-elk-stack/
https://github.com/deviantony/docker-elk
https://www.elastic.co/blog/dockbeat-a-new-addition-to-the-beats-community
https://github.com/elastic/beats-docker

metricbeat setup -e \
  -E output.logstash.enabled=true \
  -E output.elasticsearch.hosts=['192.168.168.30:9200'] \
  -E output.elasticsearch.username=elastic \
  -E output.elasticsearch.password=changeme \
  -E setup.kibana.host=192.168.178.30:5601

sudo filebeat enroll http://192.168.178.30:5601 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcmVhdGVkIjoiMjAxOS0wNi0xNFQxMzozNToxNy40ODNaIiwiZXhwaXJlcyI6IjIwMTktMDYtMTRUMTM6NDU6MTcuNDgzWiIsInJhbmRvbUhhc2giOiLvv73vv73vv73vv71cdTAwMTdIPO-_vS7vv71cIu-_ve-_vWfvv71cdTAwMDDvv71UK--_vSrvv70r77-977-9ZCIsImlhdCI6MTU2MDUxOTMxN30.jGng0vDQb3OrskN4Q-hw-wyTzZ6Qy-KNXMV8GFPdvcM

sudo metricbeat enroll http://192.168.178.30:5601 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcmVhdGVkIjoiMjAxOS0wNi0xNFQxMzozODoyNC4xNjVaIiwiZXhwaXJlcyI6IjIwMTktMDYtMTRUMTM6NDg6MjQuMTY1WiIsInJhbmRvbUhhc2giOiLvv73vv71cdTAwMDBgXCIsXHUwMDA2IGHvv707Y--_ve-_vWDvv73vv70x77-9XHUwMDEwcO-_ve-_ve-_vVx1MDAxMiciLCJpYXQiOjE1NjA1MTk1MDR9.wM3Wb5dKnUz0-rCpjI4JJe_5nuxOazZrNmsPHvIY_HY

####################################################################################################

JFROG ARTIFACTORY

https://www.jfrog.com/confluence/display/RTF/Installing+with+Docker
https://www.jfrog.com/confluence/display/MC/Installing+with+Docker+Compose
https://github.com/jfrog/artifactory-docker-examples/tree/master/docker-compose/artifactory

git clone https://github.com/jfrog/artifactory-docker-examples.git
cd artifactory-docker-examples/docker-compose/artifactory
sudo ./prepareHostEnv.sh -t oss -c
sudo docker-compose -f artifactory-oss-postgresql.yml up -d


####################################################################################################

NEXUS

https://github.com/sonatype/docker-nexus3
https://www.ivankrizsan.se/2016/06/09/create-a-private-docker-registry/

User:			admin
Password: 		admin123

git clone https://github.com/sonatype/docker-nexus3.git
cd docker-nexus
docker-compose -f docker-compose.yml up -d






