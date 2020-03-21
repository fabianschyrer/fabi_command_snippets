# OpenShift PARSE Server


cd /home
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm && sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
sudo yum -y install libvirt libvirt-devel qemu-kvm
sudo usermod -aG libvirt $USER
sudo  newgrp libvirt
sudo wget https://github.com/minishift/minishift/releases/download/v1.34.1/minishift-1.34.1-linux-amd64.tgz
tar xvf minishift-1.34.1-linux-amd64.tgz 
sudo mv minishift /usr/local/bin/minishift
which minishift
cat /proc/cpuinfo
cat /proc/meminfo
yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install -y
systemctl enable libvirtd
systemctl start libvirtd
lsmod | grep -i kvm
brctl show
virsh net-list




sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y  docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
newgrp docker
sudo mkdir /etc/docker /etc/containers

sudo tee /etc/containers/registries.conf<<EOF
[registries.insecure]
registries = ['172.30.0.0/16']
EOF

sudo tee /etc/docker/daemon.json<<EOF
{
   "insecure-registries": [
     "172.30.0.0/16"
   ]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker

echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

DOCKER_BRIDGE=`docker network inspect -f "{{range .IPAM.Config }}{{ .Subnet }}{{end}}" bridge`
sudo firewall-cmd --permanent --new-zone dockerc
sudo firewall-cmd --permanent --zone dockerc --add-source $DOCKER_BRIDGE
sudo firewall-cmd --permanent --zone dockerc --add-port={80,443,8443}/tcp
sudo firewall-cmd --permanent --zone dockerc --add-port={53,8053}/udp
sudo firewall-cmd --reload

wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar xvf openshift-origin-client-tools*.tar.gz
cd openshift-origin-client*/
sudo mv  oc kubectl  /usr/local/bin/
oc cluster up

oc cluster up --routing-suffix=<ServerPublicIP>.xip.io \
 --public-hostname=<ServerPulicDNSName>

oc cluster up --routing-suffix=5.189.176.144 \
 --public-hostname=dev.romanstark.de



oc cluster up --public-hostname=dev.romanstark.de


Hi all. The issue can be solved by editing "./openshift.local.clusterup/openshift-controller-manager/openshift-master.kubeconfig". You should replace
"server: https://127.0.0.1:8443"
to your "https://(public-hostname or IP-address):8443" also all "name:", "user:" where is "127-0-0-1:8443" to your dnsname like "openshift-example-com:8443" or IP "192-168-0-254:8443"









5.189.176.144.xip.io
127.0.0.1:8443





https://5.189.176.144/parse


































./minishift start --cpus 4 --memory 24GB --disk-size 20GB




-- Starting Minishift VM .... FAIL E0719 17:41:05.311871   11419 start.go:494] Error starting the VM: Error getting the state for host: unexpected EOF. Retrying.
Error starting the VM: Error getting the state for host: unexpected EOF




sudo ./oc login https://192.168.42.179:8443 --token=CMaaA34xxr7W3vRR0MmJPBZtDfbyiuSRKwJz1xZLAdg

oc new-project parse
oc adm policy add-scc-to-user anyuid -z default -n parse
oc adm policy add-scc-to-user privileged -z default -n parse

oc create -f https://raw.githubusercontent.com/parse-community/parse-server-example/master/openshift.json
oc new-app parse-server-example  -e APP_ID=myappid -e MASTER_KEY=supersecret
oc patch route/parse-server-example -p '{"spec":{"tls": {"termination":"edge"}}}'
oc get routes -l app=parse-server-example -o jsonpath='{.items[*].spec.host}'
PARSE_SERVER_URL=$(oc get routes -l app=parse-server-example -o jsonpath='{.items[*].spec.host}')
PARSE_SERVER_URL='https://'$PARSE_SERVER_URL'/parse'
oc volume dc/mongodb --remove --name mongodb-data #incase you dont have persistent volume

$ oc project parse



The server is accessible via web console at:
    https://dev.romanstark.de:8443

You are logged in as:
    User:     developer
    Password: <any value>

To login as administrator:
    oc login -u system:admin




PARSE_SERVER_URL=parse-server-example-parse.dev.romanstark.de.nip.io




oc new-app https://github.com/parse-community/parse-dashboard.git \
-e PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=true \
-e PARSE_DASHBOARD_SERVER_URL=$PARSE_SERVER_URL \
-e PARSE_DASHBOARD_MASTER_KEY="supersecret" \
-e PARSE_DASHBOARD_APP_ID="myappid" \
-e PARSE_DASHBOARD_APP_NAME="MyApp" \
-e PARSE_DASHBOARD_USER_ID="user1" \
-e PARSE_DASHBOARD_USER_PASSWORD="pass"


oc new-app --allow-missing-images https://github.com/fabianschyrer/parse-dashboard.git \
oc new-app --allow-missing-images https://github.com/parse-community/parse-dashboard.git \
-e PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=true \
-e PARSE_DASHBOARD_SERVER_URL=$PARSE_SERVER_URL \
-e PARSE_DASHBOARD_MASTER_KEY="supersecret" \
-e PARSE_DASHBOARD_APP_ID="myappid" \
-e PARSE_DASHBOARD_APP_NAME="MyApp" \
-e PARSE_DASHBOARD_USER_ID="user1" \
-e PARSE_DASHBOARD_USER_PASSWORD="pass"


oc new-app --allow-missing-images https://github.com/parse-community/parse-dashboard.git \
-e PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=true \
-e PARSE_DASHBOARD_SERVER_URL=$PARSE_SERVER_URL \
-e PARSE_DASHBOARD_MASTER_KEY="supersecret" \
-e PARSE_DASHBOARD_APP_ID="scandit" \
-e PARSE_DASHBOARD_APP_NAME="scandit" \
-e PARSE_DASHBOARD_USER_ID="scandit-admin" \
-e PARSE_DASHBOARD_USER_PASSWORD="password" 

$ oc expose dc parse-dashboard --port=4040
$ oc expose svc parse-dashboard
$ oc patch route/parse-dashboard -p '{"spec":{"tls": {"termination":"edge"}}}'
$ oc get routes









git clone git@github.com:aerogear/android-showcase-template.git
