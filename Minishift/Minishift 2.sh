openssl req -x509 -out dev.pag.com.crt -keyout dev.pag.com.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")


docker run --rm -it -v "/root/letsencrypt/log:/var/log/letsencrypt" -v "/var/www/html/shared:/var/www/" -v "/etc/letsencrypt:/etc/letsencrypt" -v "/root/letsencrypt/lib:/var/lib/letsencrypt" lojzik/letsencrypt certonly --webroot --webroot-path /var/www --email schyrerf@gmail.com -d dev.pag.com

#######################################################################################################################################################################################################

sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm

sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

sudo apt install libvirt-bin qemu-kvm

sudo usermod -a -G libvirt $USER
newgrp libvirt

sudo /usr/sbin/kvm-ok

systemctl is-active libvirtd

sudo virsh net-list --all

sudo virsh net-start default

sudo virsh net-autostart default

./minishift start

#######################################################################################################################################################################################################

docker run -d -p 443:443 -v pgdata:/var/lib/postgresql/9.6/main --name pag-ansible-tower ybalt/ansible-tower

#######################################################################################################################################################################################################


