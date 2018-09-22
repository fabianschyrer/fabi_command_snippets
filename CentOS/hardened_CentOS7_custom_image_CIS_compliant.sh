DP hardenend CentOS 7 - CIS compliant

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "fabian-hardened-centos7-cis"

sudo df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d -perm -0002 2>/dev/null | xargs chmod a+t

sudo systemctl disable autofs
sudo yum repolist
sudo rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'

sudo grep ^gpgcheck /etc/yum.conf
gpgcheck=1

sudo grep ^gpgcheck /etc/yum.repos.d/*

sudo yum install aide
sudo aide --init
sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
sudo crontab -u root -e
0 5 * * * /usr/sbin/aide --check

sudo chown root:root /boot/grub2/grub.cfg
sudo chmod og-rwx /boot/grub2/grub.cfg
sudo chown root:root /boot/grub2/user.cfg
sudo chmod og-rwx /boot/grub2/user.cfg

sudo sysctl -w fs.suid_dumpable=0

sudo dmesg | grep NX
NX (Execute Disable) protection: active

sudo sysctl -w kernel.randomize_va_space=2

sudo prelink -ua
sudo yum remove prelink

sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo vi /etc/selinux/config
SELINUX=enforcing
SELINUXTYPE=targeted

sudo yum remove setroubleshoot

sudo yum remove mcstrans

sudo yum install libselinux

sudo chown root:root /etc/motd
sudo chmod 644 /etc/motd

sudo chown root:root /etc/issue
sudo chmod 644 /etc/issue

sudo chown root:root /etc/issue.net
sudo chmod 644 /etc/issue.net

sudo yum check-update --security
sudo yum update --security
sudo yum check-update

sudo chkconfig chargen-dgram off
sudo chkconfig chargen-stream off

sudo chkconfig daytime-dgram off
sudo chkconfig daytime-stream off

sudo chkconfig discard-dgram off
sudo chkconfig discard-stream off

sudo chkconfig echo-dgram off
sudo chkconfig echo-stream off

sudo chkconfig time-dgram off
sudo chkconfig time-stream off

sudo chkconfig tftp off

sudo systemctl disable xinetd

sudo yum install ntp
sudo yum install chrony

sudo yum remove xorg-x11*

sudo systemctl disable avahi-daemon

sudo systemctl disable cups

sudo systemctl disable slapd

sudo systemctl disable nfs
sudo systemctl disable nfs-server
sudo systemctl disable rpcbind

sudo systemctl disable named

sudo systemctl disable vsftpd

sudo systemctl disable httpd

sudo systemctl disable dovecot

sudo systemctl disable smb

sudo systemctl disable squid

sudo systemctl disable snmpd

sudo vi /etc/postfix/main.cf
inet_interfaces = loopback-only

sudo systemctl restart postfix

sudo systemctl disable ypserv

sudo systemctl disable rsh.socket
sudo systemctl disable rlogin.socket
sudo systemctl disable rexec.socket

sudo systemctl disable telnet.socket

sudo systemctl disable tftp.socket

sudo systemctl disable rsyncd

sudo systemctl disable ntalk

sudo yum remove ypbind

sudo yum remove rsh

sudo yum remove talk

sudo yum remove openldap-clients

sudo vi /etc/sysctl.conf
net.ipv4.ip_forward = 0

sudo sysctl -w net.ipv4.ip_forward=0
sudo sysctl -w net.ipv4.route.flush=1

sudo vi /etc/sysctl.conf
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

sudo vi /etc/sysctl.conf
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

sudo sysctl -w net.ipv4.conf.all.accept_source_route=0
sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
sudo sysctl -w net.ipv4.route.flush=1

sudo vi /etc/sysctl.conf
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0

sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0

sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

sudo sysctl -w net.ipv4.conf.all.log_martians=1
sudo sysctl -w net.ipv4.conf.default.log_martians=1
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1

sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.icmp_ignore_bogus_error_responses = 1

sudo sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

sudo sysctl -w net.ipv4.conf.all.rp_filter=1
sudo sysctl -w net.ipv4.conf.default.rp_filter=1
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1

sudo sysctl -w net.ipv4.tcp_syncookies=1
sudo sysctl -w net.ipv4.route.flush=1

vi /etc/sysctl.conf
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0

sudo sysctl -w net.ipv6.conf.all.accept_ra=0
sudo sysctl -w net.ipv6.conf.default.accept_ra=0
sudo sysctl -w net.ipv6.route.flush=1

vi /etc/sysctl.conf
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.route.flush=1

sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX="ipv6.disable=1"

sudo grub2-mkconfig > /boot/grub2/grub.cfg
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo yum install tcp_wrappers

sudo chown root:root /etc/hosts.allow
sudo chmod 644 /etc/hosts.allow

sudo chown root:root /etc/hosts.deny
sudo chmod 644 /etc/hosts.deny

sudo vi /etc/modprobe.d/CIS.conf
install dccp /bin/true
install sctp /bin/true
install rds /bin/true
install tipc /bin/true

sudo yum install iptables

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -s 127.0.0.0/8 -j DROP

sudo service auditd reload
sudo systemctl enable auditd

sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX="audit=1"

grub2-mkconfig -o /boot/grub2/grub.cfg

sudo yum install rsyslog
sudo yum install syslog-ng

sudo vi /etc/audit/audit.rules
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time- change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
-w /etc/sysconfig/network-scripts/ -p wa -k system-locale
-w /etc/selinux/ -p wa -k MAC-policy
-w /usr/share/selinux/ -p wa -k MAC-policy
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock/ -p wa -k logins
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k logins
-w /var/log/btmp -p wa -k logins
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access 
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access 
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access 
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
-w /var/log/sudo.log -p wa -k actions
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
-e 2

sudo systemctl enable rsyslog

sudo vi /etc/rsyslog.conf
sudo vi /etc/rsyslog.d/*.conf
*.emerg								 :omusrmsg:*
mail.*								-/var/log/mail
mail.info							-/var/log/mail.info
mail.warning						-/var/log/mail.warn
mail.err 							 /var/log/mail.err
news.crit							-/var/log/news/news.crit
news.err 							-/var/log/news/news.err
news.notice 						-/var/log/news/news.notice
*.=warning;*.=err 					-/var/log/warn
*.crit 								 /var/log/warn
*.*;mail.none;news.none 			-/var/log/messages
local0,local1.* 					-/var/log/localmessages
local2,local3.* 					-/var/log/localmessages
local4,local5.* 					-/var/log/localmessages
local6,local7.* 					-/var/log/localmessages
$FileCreateMode 0640

sudo pkill -HUP rsyslogd

sudo vi /etc/rsyslog.conf
# $ModLoad imtcp
# $InputTCPServerRun 514

sudo pkill -HUP rsyslogd

sudo systemctl enable syslog-ng

sudo vi /etc/syslog-ng/syslog-ng.conf
log { source(src); source(chroots); filter(f_console); destination(console); };
log { source(src); source(chroots); filter(f_console); destination(xconsole); };
log { source(src); source(chroots); filter(f_newscrit); destination(newscrit); };
log { source(src); source(chroots); filter(f_newserr); destination(newserr); };
log { source(src); source(chroots); filter(f_newsnotice); destination(newsnotice); };
log { source(src); source(chroots); filter(f_mailinfo); destination(mailinfo); };
log { source(src); source(chroots); filter(f_mailwarn); destination(mailwarn); };
log { source(src); source(chroots); filter(f_mailerr); destination(mailerr); };
log { source(src); source(chroots); filter(f_mail); destination(mail); };
log { source(src); source(chroots); filter(f_acpid); destination(acpid); flags(final); };
log { source(src); source(chroots); filter(f_acpid_full); destination(devnull); flags(final); };
log { source(src); source(chroots); filter(f_acpid_old); destination(acpid); flags(final); };
log { source(src); source(chroots); filter(f_netmgm); destination(netmgm); flags(final); };
log { source(src); source(chroots); filter(f_local); destination(localmessages); };
log { source(src); source(chroots); filter(f_messages); destination(messages); };
log { source(src); source(chroots); filter(f_iptables); destination(firewall); };
log { source(src); source(chroots); filter(f_warn); destination(warn); };
options { chain_hostnames(off); flush_lines(0); perm(0640); stats_freq(3600); threaded(yes); };

sudo pkill -HUP syslog-ng

sudo find /var/log -type f -exec chmod g-wx,o-rwx {} +

sudo systemctl enable crond

sudo chown root:root /etc/crontab
sudo chmod og-rwx /etc/crontab

sudo chown root:root /etc/cron.hourly
sudo chmod og-rwx /etc/cron.hourly

sudo chown root:root /etc/cron.daily
sudo chmod og-rwx /etc/cron.daily

sudo chown root:root /etc/cron.weekly
sudo chmod og-rwx /etc/cron.weekly

sudo chown root:root /etc/cron.monthly
sudo chmod og-rwx /etc/cron.monthly

sudo chown root:root /etc/cron.d
sudo chmod og-rwx /etc/cron.d

sudo rm /etc/cron.deny
sudo rm /etc/at.deny
sudo touch /etc/cron.allow
sudo touch /etc/at.allow
sudo chmod og-rwx /etc/cron.allow
sudo chmod og-rwx /etc/at.allow
sudo chown root:root /etc/cron.allow
sudo chown root:root /etc/at.allow

# sudo chown root:root /etc/ssh/sshd_config
# sudo chmod og-rwx /etc/ssh/sshd_config

# sudo vi /etc/ssh/sshd_config
# Protocol 2
# LogLevel INFO
# X11Forwarding no
# MaxAuthTries 4
# IgnoreRhosts yes
# HostbasedAuthentication no
# PermitRootLogin no
# PermitEmptyPasswords no
# PermitUserEnvironment no
# MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128- etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
# ClientAliveInterval 300
# ClientAliveCountMax 0
# LoginGraceTime 60
# Banner /etc/issue.net

sudo vi /etc/pam.d/password-auth
sudo vi /etc/pam.d/system-auth
password sufficient pam_unix.so remember=5

sudo vi /etc/login.defs
PASS_MAX_DAYS 90
PASS_MIN_DAYS 7
PASS_WARN_AGE 7
useradd -D -f 30

#!/bin/bash
for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd` ; do
  if [ $user != "root" ]; then
    usermod -L $user
	if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ];
then
      usermod -s /sbin/nologin $user
   fi fi
done

sudo usermod -g 0 root

sudo vi /etc/bashrc
sudo vi /etc/profile
sudo vi /etc/profile.d/*.sh
umask 027

sudo vi /etc/bashrc
sudo vi /etc/profile
TMOUT=600

sudo chown root:root /etc/passwd
sudo chmod 644 /etc/passwd

sudo chown root:root /etc/shadow
sudo chmod 000 /etc/shadow

sudo chown root:root /etc/group
sudo chmod 644 /etc/group

sudo chown root:root /etc/gshadow
sudo chmod 000 /etc/gshadow

sudo chown root:root /etc/passwd-
sudo chmod u-x,go-wx /etc/passwd-

sudo chown root:root /etc/shadow-
sudo chmod 000 /etc/shadow-

sudo chown root:root /etc/group-
sudo chmod u-x,go-wx /etc/group-

sudo chown root:root /etc/gshadow-
sudo chmod 000 /etc/gshadow-









