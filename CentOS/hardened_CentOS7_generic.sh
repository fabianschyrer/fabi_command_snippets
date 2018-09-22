Hardened CentOS7 on GCP

gcloud compute --project "<PROJECT>" ssh --zone "asia-southeast1-b" "fabian-hardened-centos7"

sudo yum update
sudo yum remove alsa-* ivtv-* iwl*firmware aic94xx-firmware

sudo vi /etc/fstab
/tmp /var/tmp none rw,nodev,noexec,nosuid,bind 0 0
tmpfs /dev/shm tmpfs rw,nodev,noexec,nosuid 0 0
proc /proc proc rw,hidepid=2 0 0
/dev/cdrom /mnt/cdrom iso9660 ro,noexec,nosuid,nodev,noauto 0 0

sudo vi /etc/modprobe.d/hardening.conf
install cramfs /bin/true
install freevxfs /bin/true
install jffs2 /bin/true
install hfs /bin/true
install hfsplus /bin/true
install squashfs /bin/true
install udf /bin/true
install fat /bin/true
install vfat /bin/true
install cifs /bin/true
install nfs /bin/true
install nfsv3 /bin/true
install nfsv4 /bin/true
install gfs2 /bin/true
blacklist usb-storage
blacklist firewire-core
install usb-storage /bin/true

sudo vi /opt/usb-auth.sh
#!/bin/bash
echo 0 > /sys/bus/usb/devices/usb1/authorized
echo 0 > /sys/bus/usb/devices/usb1/authorized_default

sudo vi /etc/systemd/system/usb-auth.service
[Unit]
Description=Disable USB auth
DefaultDependencies=no
[Service]
Type=oneshot
ExecStart=/bin/bash /opt/usb-auth.sh
[Install]
WantedBy=multi-user.target

sudo chmod 0700 /opt/usb-auth.sh
sudo systemctl enable usb-auth.service
sudo systemctl start usb-auth.service

sudo vi /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

sudo vi /etc/sysctl.conf
# Disable core dumps
fs.suid_dumpable = 0
# Disable System Request debugging functionality
kernel.sysrq = 0
# Restrict access to kernel logs
kernel.dmesg_restrict = 1
# Enable ExecShield protection - not available on CentOS 7
# kernel.exec-shield = 1
# Randomise memory space
kernel.randomize_va_space = 2
# Hide kernel pointers
kernel.kptr_restrict = 2

sudo sysctp -p

sudo sed -i -e 's/umask 022/umask 027/g' -e 's/umask 002/umask 027/g' /etc/bashrc
sudo sed -i -e 's/umask 022/umask 027/g' -e 's/umask 002/umask 027/g' /etc/csh.cshrc
sudo sed -i -e 's/umask 022/umask 027/g' -e 's/umask 002/umask 027/g' /etc/profile
sudo sed -i -e 's/umask 022/umask 027/g' -e 's/umask 002/umask 027/g' /etc/init.d/functions

sudo vi /etc/security/limits.conf
*  hard  core  0
# 4096 is a good starting point
*      soft   nofile    4096
*      hard   nofile    65536
*      soft   nproc     4096
*      hard   nproc     4096
*      soft   locks     4096
*      hard   locks     4096
*      soft   stack     10240
*      hard   stack     32768
*      soft   memlock   64
*      hard   memlock   64
*      hard   maxlogins 10
# Soft limit 32GB, hard 64GB
*      soft   fsize     33554432
*      hard   fsize     67108864
# Limits for root
root   soft   nofile    4096
root   hard   nofile    65536
root   soft   nproc     4096
root   hard   nproc     4096
root   soft   stack     10240
root   hard   stack     32768
root   soft   fsize     33554432

sudo find / -ignore_readdir_race -nouser -print -exec chown root {} \;
sudo find / -ignore_readdir_race -nogroup -print -exec chgrp root {} \;

sudo vi /etc/cron.daily/unowned_files
#!/bin/bash
find / -ignore_readdir_race \( -nouser -print -exec chown root {} \; \) , \( -nogroup -print -exec chgrp root {} \; \)

sudo chown root:root /etc/cron.daily/unowned_files
sudo chmod 0700 /etc/cron.daily/unowned_files

sudo find / -xdev -type f -perm -4000 -o -perm -2000

sudo sed -i "s/DefaultZone=.*/DefaultZone=drop/g" /etc/firewalld/firewalld.conf

sudo systemctl stop firewalld.service
sudo systemctl mask firewalld.service
sudo systemctl daemon-reload
sudo yum install iptables-services
sudo systemctl enable iptables.service ip6tables.service

sudo vi /etc/sysconfig/iptables
*filter
-F INPUT
-F OUTPUT
-F FORWARD
-P INPUT ACCEPT
-P FORWARD DROP
-P OUTPUT ACCEPT
-A INPUT -i lo -m comment --comment local -j ACCEPT
-A INPUT -d 127.0.0.0/8 ! -i lo -j REJECT --reject-with icmp-port-unreachable
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#-A INPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 22 -s 10.0.0.0/8 -j ACCEPT
#-A INPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 22 -s 172.16.0.0/12 -j ACCEPT
#-A INPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 22 -s 192.168.0.0/16 -j ACCEPT
#-A INPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 22 -j ACCEPT
-A INPUT -j DROP
-A OUTPUT -d 127.0.0.0/8 -o lo -m comment --comment local -j ACCEPT
-A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A OUTPUT -p icmp -m icmp --icmp-type any -j ACCEPT
-A OUTPUT -p udp -m udp -m conntrack --ctstate NEW --dport 53 -j ACCEPT
-A OUTPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 53 -j ACCEPT
-A OUTPUT -p udp -m udp -m conntrack --ctstate NEW --dport 123 -j ACCEPT
-A OUTPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 80 -j ACCEPT
-A OUTPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 443 -j ACCEPT
-A OUTPUT -p tcp -m tcp -m conntrack --ctstate NEW --dport 587 -j ACCEPT
-A OUTPUT -j LOG --log-prefix "iptables_output "
-A OUTPUT -j REJECT --reject-with icmp-port-unreachable
COMMIT

sudo vi /etc/sysconfig/ip6tables
*filter
-F INPUT
-F OUTPUT
-F FORWARD
-P INPUT DROP
-P FORWARD DROP
-P OUTPUT DROP
COMMIT

sudo iptables-restore < /etc/sysconfig/iptables
sudo ip6tables-restore < /etc/sysconfig/ip6tables

sudo vi /etc/hosts.allow
ALL: 127.0.0.1
sshd: ALL

sudo vi /etc/hosts.deny
ALL: ALL

sudo vi /etc/sysctl.conf
# Disable packet forwarding
net.ipv4.ip_forward = 0
# Disable redirects, not a router
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
# Disable source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
# Enable source validation by reversed path
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
# Log packets with impossible addresses to kernel log
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
# Disable ICMP broadcasts
net.ipv4.icmp_echo_ignore_broadcasts = 1
# Ignore bogus ICMP errors
net.ipv4.icmp_ignore_bogus_error_responses = 1
# Against SYN flood attacks
net.ipv4.tcp_syncookies = 1
# Turning off timestamps could improve security but degrade performance.
# TCP timestamps are used to improve performance as well as protect against
# late packets messing up your data flow. A side effect of this feature is 
# that the uptime of the host can sometimes be computed.
# If you disable TCP timestamps, you should expect worse performance 
# and less reliable connections.
net.ipv4.tcp_timestamps = 1
# Disable IPv6 unless required
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
# Do not accept router advertisements
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0

sudo vi /etc/modprobe.d/hardening.conf
install bnep /bin/true
install bluetooth /bin/true
install btusb /bin/true
install net-pf-31 /bin/true
install appletalk /bin/true
options ipv6 disable=1
install dccp /bin/true
install sctp /bin/true
install rds /bin/true
install tipc /bin/true

sudo for i in $(find /lib/modules/$(uname -r)/kernel/drivers/net/wireless -name "*.ko" -type f);do \ 	echo blacklist "$i" >>/etc/modprobe.d/hardening-wireless.conf;done

sudo nmcli radio all off

sudo vi /etc/sysconfig/network
NOZEROCONF=yes
NETWORKING_IPV6=no
IPV6INIT=no

sudo ip link | grep PROMISC

sudo yum install libreswan

sudo vi /etc/default/grub
sestatus

sudo userdel -r adm
sudo userdel -r ftp
sudo userdel -r games
sudo userdel -r lp

sudo vi /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
polkitd:x:999:998:User for polkitd:/:/sbin/nologin
ntp:x:38:38::/etc/ntp:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
fabianalexander:x:1000:1001::/home/fabianalexander:/bin/bash
#jitkasempintaya:x:1001:1002::/home/jitkasempintaya:/bin/bash
#getzyway:x:1002:1003::/home/getzyway:/bin/bash
tridsayods:x:1003:1004::/home/tridsayods:/bin/bash
pry:x:1004:1005::/home/pry:/bin/bash
#p_chayakon:x:1005:1006::/home/p_chayakon:/bin/bash
parin:x:1006:1007::/home/parin:/bin/bash
jenkins:x:1007:1008::/home/jenkins:/bin/bash
#True:x:1008:1009::/home/True:/bin/bash
pachara.pet:x:1009:1010::/home/pachara.pet:/bin/bash
#ken:x:1010:1011::/home/ken:/bin/bash
ycdpry:x:1011:1012::/home/ycdpry:/bin/bash
#CC:x:1012:1013::/home/CC:/bin/bash
#tridosayods_sir:x:1013:1014::/home/tridosayods_sir:/bin/bash
gce-dp:x:1014:1015::/home/gce-dp:/bin/bash
#jitkasem_pin:x:1015:1016::/home/jitkasem_pin:/bin/bash
#tomcat:x:1016:1017::/home/tomcat:/bin/bash
#sombat_won:x:1017:1018::/home/sombat_won:/bin/bash
dataplatform:x:1018:1019::/home/dataplatform:/bin/bash
terawat.tan:x:1019:1020::/home/terawat.tan:/bin/bash
#terawat_tan:x:1020:1021::/home/terawat_tan:/bin/bash
unbound:x:997:994:Unbound DNS resolver:/etc/unbound:/sbin/nologin

sudo groupdel games

sudo echo > /etc/securetty

sudo authconfig --passalgo=sha512 \
 --passminlen=16 \
 --passminclass=4 \
 --passmaxrepeat=2 \
 --passmaxclassrepeat=2 \
 --enablereqlower \
 --enablerequpper \
 --enablereqdigit \
 --enablereqother \
 --update

sudo vi /etc/security/pwquality.conf
difok = 8
gecoscheck = 1

sudo sed -i 's/\<nullok\>//g' /etc/pam.d/system-auth /etc/pam.d/system-auth-ac
sudo sed -i 's/\<nullok\>//g' /etc/pam.d/password-auth /etc/pam.d/password-auth-ac

sudo vi /etc/default/useradd
INACTIVE=0

sudo sed -i 's/^INACTIVE.*/INACTIVE=0/' /etc/default/useradd

sudo vi /etc/login.defs
PASS_MAX_DAYS 60
PASS_MIN_DAYS 1
PASS_MIN_LEN 14
PASS_WARN_AGE 14

sudo sed -i -e 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 60/' \
  -e 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/' \
  -e 's/^PASS_MIN_LEN.*/PASS_MIN_LEN 14/' \
  -e 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 14/' /etc/login.defs  

sudo vi /etc/login.defs
FAILLOG_ENAB yes
FAIL_DELAY 4
CREATE_HOME yes

sudo cut -d: -f2 /etc/passwd|uniq

sudo vi /etc/pam.d/system-auth
### Add the following line immediately BEFORE the pam_unix.so statement in the AUTH section
auth required pam_faillock.so preauth silent deny=3 unlock_time=900 fail_interval=900

sudo vi /etc/pam.d/password-auth
### Add the following line immediately BEFORE the pam_unix.so statement in the AUTH section
auth required pam_faillock.so preauth silent deny=3 unlock_time=900 fail_interval=900

sudo vi /etc/pam.d/system-auth
### Add the following line immediately AFTER the pam_unix.so statement in the AUTH section
auth [default=die] pam_faillock.so authfail deny=3 unlock_time=900 fail_interval=900

sudo vi /etc/pam.d/password-auth
### Add the following line immediately AFTER the pam_unix.so statement in the AUTH section
auth [default=die] pam_faillock.so authfail deny=3 unlock_time=900 fail_interval=900

sudo vi /etc/pam.d/system-auth
### Add the following line immediately BEFORE the pam_unix.so statement in the ACCOUNT section
account required pam_faillock.so

sudo vi /etc/pam.d/password-auth
### Add the following line immediately BEFORE the pam_unix.so statement in the ACCOUNT section
account required pam_faillock.so

sudo chattr +i /etc/pam.d/system-auth /etc/pam.d/password-auth

sudo yum install screen

sudo yum install vlock

sudo systemctl mask ctrl-alt-del.target

sudo vi /etc/issue
Unauthorised access prohibited. Logs are recorded and monitored.

sudo vi /etc/issue.net
Unauthorised access prohibited. Logs are recorded and monitored.

sudo vi /etc/profile
readonly TMOUT=900

sudo vi /etc/ssh/sshd_config
AuthenticationMethods publickey,password
HISTSIZE=5000

sudo sed -i 's/HISTSIZE=.*/HISTSIZE=5000/g' /etc/profile

sudo vi /etc/audit/auditd.conf
local_events = yes
write_logs = yes
log_file = /var/log/audit/audit.log
max_log_file = 25
num_logs = 10
max_log_file_action = rotate
space_left = 30
space_left_action = email
admin_space_left = 10
admin_space_left_action = email
disk_full_action = suspend
disk_error_action = suspend
action_mail_acct = root@ascendcorp.com
flush = data

sudo chown root:root /etc/audit/rules.d/audit.rules
sudo chmod 0640 /etc/audit/rules.d/audit.rules

sudo vi /etc/audit/rules.d/audit.rules
# Delete all currently loaded rules
-D
# Set kernel buffer size
-b 8192
# Set the action that is performed when a critical error is detected.
# Failure modes: 0=silent 1=printk 2=panic
-f 1
# Record attempts to alter the localtime file
-w /etc/localtime -p wa -k audit_time_rules
# Record events that modify user/group information
-w /etc/group -p wa -k audit_rules_usergroup_modification
-w /etc/passwd -p wa -k audit_rules_usergroup_modification
-w /etc/gshadow -p wa -k audit_rules_usergroup_modification
-w /etc/shadow -p wa -k audit_rules_usergroup_modification
-w /etc/security/opasswd -p wa -k audit_rules_usergroup_modification
# Record events that modify the system's network environment
-w /etc/issue.net -p wa -k audit_rules_networkconfig_modification
-w /etc/issue -p wa -k audit_rules_networkconfig_modification
-w /etc/hosts -p wa -k audit_rules_networkconfig_modification
-w /etc/sysconfig/network -p wa -k audit_rules_networkconfig_modification
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k audit_rules_networkconfig_modification
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k audit_rules_networkconfig_modification
# Record events that modify the system's mandatory access controls
-w /etc/selinux/ -p wa -k MAC-policy
# Record attempts to alter logon and logout events
-w /var/log/tallylog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock/ -p wa -k logins
# Record attempts to alter process and session initiation information
-w /var/log/btmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/run/utmp -p wa -k session
# Ensure auditd collects information on kernel module loading and unloading
-w /usr/sbin/insmod -p x -k modules
-w /usr/sbin/modprobe -p x -k modules
-w /usr/sbin/rmmod -p x -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
# Ensure auditd collects system administrator actions
-w /etc/sudoers -p wa -k actions
-w /etc/sudoers.d/ -p wa -k actions
# Record attempts to alter time through adjtimex
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k audit_time_rules
# Record attempts to alter time through settimeofday
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k audit_time_rules
# Record attempts to alter time through clock_settime
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -k time-change
# Record attempts to alter time through clock_settime
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -k time-change
# Record events that modify the system's discretionary access controls
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
# Ensure auditd collects unauthorised access attempts to files (unsuccessful)
-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
# Ensure auditd collects information on exporting to media (successful)
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k export
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k export
# Ensure auditd collects file deletion events by user
-a always,exit -F arch=b32 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-a always,exit -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
# Ensure auditd collects information on the use of privileged commands
-a always,exit -F path=/usr/bin/chage -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=4294967295 -F key=privileged-priv_change
-a always,exit -F path=/usr/bin/chfn -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/chsh -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/crontab -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/gpasswd -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/mount -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/newgrp -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/passwd -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/pkexec -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/screen -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/ssh-agent -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/sudo -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/sudoedit -F perm=x -F auid>=1000 -F auid!=4294967295 -F key=privileged
-a always,exit -F path=/usr/bin/su -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/umount -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/wall -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/bin/write -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/lib64/dbus-1/dbus-daemon-launch-helper -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/libexec/openssh/ssh-keysign -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/libexec/utempter/utempter -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/lib/polkit-1/polkit-agent-helper-1 -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/netreport -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/pam_timestamp_check -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/postdrop -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/postqueue -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/restorecon -F perm=x -F auid>=1000 -F auid!=4294967295 -F key=privileged-priv_change
-a always,exit -F path=/usr/sbin/semanage -F perm=x -F auid>=1000 -F auid!=4294967295 -F key=privileged-priv_change
-a always,exit -F path=/usr/sbin/setsebool -F perm=x -F auid>=1000 -F auid!=4294967295 -F key=privileged-priv_change
-a always,exit -F path=/usr/sbin/unix_chkpwd -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/userhelper -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/usr/sbin/usernetctl -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
# Make the auditd configuration immutable.
# The configuration can only be changed by rebooting the machine.
-e 2

sudo vi /etc/audisp/plugins.d/syslog.conf
active = yes

sudo systemctl enable auditd.service
sudo systemctl start auditd.service

sudo vi /etc/default/grub
audit=1

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo yum install epel-release
sudo yum install tripwire

sudo /usr/sbin/tripwire-setup-keyfiles
Passphrase:		P@ssw0rd

sudo tripwire --init
sudo tripwire --check

sudo yum install prelink

sudo vi /etc/sysconfig/prelink
PRELINKING=no

sudo sed -i 's/PRELINKING.*/PRELINKING=no/g' /etc/sysconfig/prelink

sudo prelink -ua

sudo vi /etc/systemd/journald.conf
[Journal]
Storage=persistent
# How much disk space the journal may use up at most
SystemMaxUse=256M
# How much disk space systemd-journald shall leave free for other uses
SystemKeepFree=512M
# How large individual journal files may grow at most
SystemMaxFileSize=32M

sudo systemctl daemon-reload
sudo systemctl restart systemd-journald

sudo vi /etc/rsyslog.conf
*.* @graylog.example.com:514

sudo yum install logwatch

sudo yum install epel-release
sudo yum install rkhunter clamav clamav-update
sudo rkhunter --update
sudo rkhunter --propupd
sudo freshclam -v
cd /etc/cron.daily/
ls -las

sudo yum install yum-utils
sudo yum install yum-cron

sudo vi /etc/yum/yum-cron.conf
update_cmd = default
update_messages = yes
download_updates = no	
apply_updates = no
emit_via = email	
email_from = notify@ascendcorp.com
email_to = acndataplatform@gmail.com
email_host = localhost

sudo vi /etc/yum/yum-cron-hourly.conf
update_cmd = minimal 		# yum --bugfix update-minimal
update_messages = yes
download_updates = yes
apply_updates = yes
emit_via = stdio

sudo systemctl enable yum-cron.service
sudo systemctl start yum-cron.service

sudo yum install psacct
sudo systemctl enable psacct.service
sudo systemctl start psacct.service

sudo groupadd ssh-users
sudo useradd -m -s /bin/bash -G ssh-users fabianalexander
sudo useradd -m -s /bin/bash -G ssh-users fabian

su - fabian
sudo mkdir --mode=0700 ~/.ssh
sudo ssh-keygen -b 4096 -t rsa -C "fabian" -f ~/.ssh/id_rsa

sudo ssh-keygen -b 4096 -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
sudo ssh-keygen -b 1024 -t dsa -N "" -f /etc/ssh/ssh_host_dsa_key
sudo ssh-keygen -b 521 -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key
sudo ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key

sudo yum install policycoreutils-python

sudo systemctl enable chronyd.service

sudo yum remove xinetd telnet-server rsh-server \
 rsh ypbind ypserv tfsp-server bind \
 vsfptd dovecot squid net-snmpd talk-server talk

sudo systemctl list-unit-files --type=service|grep enabled

sudo systemctl disable kdump.service
sudo systemctl mask kdump.service
sudo systemctl disable postfix.service
sudo systemctl disable tuned.service
sudo systemctl disable usb-auth.service

sudo systemctl set-default multi-user.target

sudo yum install epel-release
sudo yum install fail2ban

sudo vi /etc/fail2ban/jail.d/00-firewalld.conf 
#banaction = firewallcmd-ipset

sudo vi /etc/fail2ban/jail.conf
[sshd]
port    = ssh
enabled = true
ignoreip = 10.8.8.61
bantime  = 600
maxretry = 5

sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service

sudo yum install sysstat
sudo systemctl enable sysstat.service
sudo systemctl start sysstat.service

sudo yum install /usr/bin/virt-sysprep
sudo virt-sysprep --list-operations
sudo virt-sysprep --format auto --verbose --dry-run 


