*** PostgreSQL hardening ***


* postgresql.conf
http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html
password_encryption							true
logging_collector							true
log_directory								pg_log
log_connections								true
log_disconnections							true
log_duration								true
log_hostname								true
log_line_prefix								%t %u %d %h

* Install last security updates

* Prevent server spoofing
unix_socket_directories						/tmp
(The simplest way to prevent invalid servers for local connections is to use a Unix domain socket directory (unix_socket_directory) that has write permission only for a trusted local user. This prevents a malicious user from creating their own socket file in that directory. If you are concerned that some applications might still reference /tmp for the socket file and hence be vulnerable to spoofing, during operating system startup create symbolic link /tmp/.s.PGSQL.5432 that points to the relocated socket file. You also might need to modify your /tmp cleanup script to preserve the symbolic link.)

* pg_hba.conf
general: TYPE - DATABASE - USER - CIDR_ADDRESS - METHOD
Remove all trust connections 				remove all TRUST lines
USe strong authentication					METHOD = crypt
Limit connections 							Add per-host lines for each application host in use
											Use md5 as the method for comparing the hashes across the wire
											EOF: all all 0.0.0.0/0 REJECT
Use SSL										Type = 
											local: unix-domain socket
   											host: TCP/IP connection with or without SSL
   											hostnossl: TCP/IP connection without SSL
   											hostssl: TCP/IP connection with SSL


* User Roles
Use metabase user 							allow INSERT / UPDATE / DELETE / SELECT


* Removing default public schema
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
CREATE SCHEMA myschema AUTHORIZATION [username];
SET search_path TO myschema,public;







