# Minishift AWS

ssh -i pag_openshift.pem ubuntu@18.185.86.81

sudo passwd ubuntu

sudo apt-get update -y

sudo apt install qemu-kvm libvirt-daemon libvirt-daemon-system -y

audo apt-get install virtualbox -y

sudo usermod -a -G libvirt $USER

newgrp libvirt

mkdir temp

cd temp

sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu16.04 -o /usr/local/bin/docker-machine-driver-kvm

sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

scp -i pag_openshift.pem minishift-1.34.1-linux-amd64.tgz   ubuntu@18.185.86.81:/home/ubuntu/temp

scp -i pag_openshift.pem openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz  ubuntu@18.185.86.81:/home/ubuntu/temp

sudo minishift start --vm-driver virtualbox --cpus 6 --memory 25600 --disk-size 60g --skip-registry-check=true







