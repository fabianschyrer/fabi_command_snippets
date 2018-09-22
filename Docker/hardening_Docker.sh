Docker hardening

# Containers run on a Linux host. A container host can run one or more containers.
# It is of utmost importance to harden the host to mitigate host security misconfiguration.
# You should follow infrastructure security best practices and harden your host OS.
# Keeping the host system hardened would ensure that the host vulnerabilities are mitigated.
# Not hardening the host system could lead to security exposures and breaches.

# Docker allows you to share a directory between the Docker host and a guest container without limiting the access rights of the container.
# This means that you can start a container and map the / directory on your host to the container.
# The container will then be able to alter your host file system without any restrictions.
# In simple terms, it means that you can attain elevated privileges with just being a member of the docker group and 
# then starting a container with mapped / directory on the host.

# configure audit logs
vi /etc/audit/audit.rules
-w /usr/bin/docker -k docker
-w /var/lib/docker -k docker
-w /etc/docker -k docker
-w /usr/lib/systemd/system/docker.service -k docker
-w /usr/lib/systemd/system/docker.socket -k docker
-w /etc/default/docker -k docker
-w /etc/docker/daemon.json -k docker
-w /usr/bin/docker-containerd -k docker
-w /usr/bin/docker-runc -k docker

# restart audit log service
service auditd restart

# disable inter container communication on default bridge
dockerd --icc=false

# set log level
dockerd --log-level="info"

# ensure dockerd is not allowed to make changes to host's IPtables
dockerd --iptables=false

# disable aufs storage for Docker deamon
dockerd --storage-driver aufs

# ensure TLS authentication is present
ps -ef | grep dockerd
# --tlsverify
# --tlscacert
# --tlscert
# --tlskey

# use default ulimit
dockerd --default-ulimit nproc=1024:2048 --default-ulimit nofile=100:200

# ensure user namespace
docker info --format '{{ .SecurityOptions }}'
touch /etc/subuid /etc/subgid
dockerd --userns-remap=default

# ensure default cgroup usage has been confirmed
dockerd --cgroup-parent=/foobar

# disable changes on legacy registry (v1)
dockerd --disable-legacy-registry

# ensure live restore is enabled
dockerd --live-restore

# disable userland proxy
dockerd --userland-proxy=false

# ensure containers are restricted from acquiring new privileges
dockerd --no-new-privileges

# set docker.service config file ownership to root:root
systemctl show -p FragmentPath docker.service
chown root:root /usr/lib/systemd/system/docker.service

# restrict docker.service file permission (644)
systemctl show -p FragmentPath docker.service
chmod 644 /usr/lib/systemd/system/docker.service

# set docker.socket file ownership to root:root
systemctl show -p FragmentPath docker.socket
chown root:root /usr/lib/systemd/system/docker.socket

# restrict docker.socket file permission (644)
systemctl show -p FragmentPath docker.socket
chmod 644 /usr/lib/systemd/system/docker.socket

# ensure that /etc/docker directory ownership is set to root:root
chown root:root /etc/docker

# restrict /etc/docker directory permission (755)
chmod 755 /etc/docker

# ensure that registry certificate file ownership is set to root:root
chown root:root /etc/docker/certs.d/<registry-name>/*

# restrict registry certificate file permission (444)
chmod 444 /etc/docker/certs.d/<registry-name>/*

# ensure that TLS CA certificate file ownership is set to root:root
chown root:root <path to TLS CA certificate file>

# restrict TLS CA certificate file permission (444)
chmod 444 <path to TLS CA certificate file>

# ensure that docker server certificate file ownership is set to root:root
chown root:root <path to Docker server certificate file>

# restrict docker server certificate file permission (444)
chmod 444 <path to Docker server certificate file>

# ensure that docker server certificate key file ownership is set to root:root
chown root:root <path to Docker server certificate key file>

# restrict docker server certificate key file permission (400)
chmod 400 <path to Docker server certificate key file>

# ensure that Docker socket file ownership is set to root:docker
chown root:docker /var/run/docker.sock

# ensure that Docker socket file permissions are set to 660
chmod 660 /var/run/docker.sock

# ensure that daemon.json file ownership is set to root:root
chown root:root /etc/docker/daemon.json

# ensure that daemon.json file permissions are set to 644
chmod 644 /etc/docker/daemon.json

# ensure that /etc/default/docker file ownership is set to root:root
chown root:root /etc/default/docker

# ensure that /etc/default/docker file permissions are set to 644
chmod 644 /etc/default/docker

# list packages inside containers and reduce to a minimum
docker exec $INSTANCE_ID rpm -qa

# periodically build docker iamges without cache to make sure security patches have been applied
docker build --no-cache

# check image for healthcheck instructions
docker inspect --format='{{ .Config.Healthcheck }}' <IMAGE>

# add healthcheck instructions to docker container
https://docs.docker.com/engine/reference/builder/#healthcheck

# use AppArmor security profiles for containers
https://docs.docker.com/engine/security/apparmor/
docker run --interactive --tty --security-opt="apparmor:PROFILENAME" centos /bin/bash

# ensure SELinux security options are set
https://docs.docker.com/engine/security/security/#other-kernel-security-features
https://docs.docker.com/engine/reference/run/#security-configuration
docker daemon --selinux-enabled
docker run --interactive --tty --security-opt label=level:TopSecret centos /bin/bash

# ensure Linux Kernel Capabilities are restricted within containers
# NET_ADMIN / SYS_ADMIN / SYS_MODULE
docker run --interactive --tty --cap-add={"NET_ADMIN","SYS_ADMIN"} centos:latest /bin/bash
docker run --interactive --tty --cap-drop={"SETUID","SETGID"} centos:latest /bin/bash
docker run --interactive --tty --cap-drop=all --cap- add={"NET_ADMIN","SYS_ADMIN"} centos:latest /bin/bash
# AUDIT_WRITE / CHOWN / DAC_OVERRIDE / FOWNER / FSETID / KILL / MKNOD / NET_BIND_SERVICE / NET_RAW / SETFCAP / SETGID / SETPCAP / SETUID / SYS_CHROOT

# limit docker container memory usage
docker run --interactive --tty --memory 256m centos /bin/bash

# ensure CPU priority is set appropriately on the container
docker run --interactive --tty --cpu-shares 512 centos /bin/bash

# ensure the container's root filesystem is mounted as read only
docker run <Run arguments> --read-only <Container Image Name or ID> <Command>

# /tmp r/o
docker run --interactive --tty --read-only --tmpfs "/run" --tmpfs "/tmp" centos /bin/bash

# persistant data directory
docker run --interactive --tty --read-only -v /opt/app/data:/run/app/data:rw centos /bin/bash

# Docker shared-storage volume plugins for Docker data volume to persist container data
docker volume create -d convoy --opt o=size=20GB my-named-volume
docker run --interactive --tty --read-only -v my-named-volume:/run/app/data centos /bin/bash

# set on failure restart policy to 5
docker run --detach --restart=on-failure:5 nginx

# ensure the host's process namespace is not shared
docker run --interactive --tty --pid=host centos /bin/bash

# share a certain process with the host
docker run --pid=host rhel7 strace -p 1234

# ensure the host's IPC namespace is not shared
docker run --interactive --tty --ipc=host centos /bin/bash

# share IPC namespace with another container
docker run --interactive --tty --ipc=container:e3a7a1a97c58 centos /bin/bash

# ensure the host's UTS namespace is not shared
docker run --rm --interactive --tty --uts=host rhel7.2

# ensure the container is restricted from acquiring additional privileges
docker run --rm -it --security-opt=no-new-privileges ubuntu bash

# ensure container health is checked at runtime
docker run -d --health-cmd='stat /etc/passwd || exit 1' nginx

# ensure PIDs cgroup limit is used
docker run -it --pids-limit 100 <Image_ID>

# list images that are currently used
docker images --quiet | xargs docker inspect --format '{{ .Id }}: Image={{ .Config.Image }}'

# clean up stopped containers
docker container prune

