#!/bin/sh

# Core commands to add repo and install MariaDB server and client programs:
#
sudo apt-get update -y
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
sudo apt install -y mariadb-server mariadb-client
/usr/bin/mysql_secure_installation

# After installation, then check by login.
#
mysql -h somehost -u root -p

# From the CLI:
#
mysql -V

# From the MySQL prompt type:
#
SHOW VARIABLES LIKE "%version%";

# Also, do not forget about this:
#
cd /etc/mysql/mariadb.conf.d
sudo vi my.cnf

#Then add this to the 'my.cnf' file:
#
[mysqld]
bind-address = 0.0.0.0

#To install the Connect Storage Engine, use this command:
#
sudo apt-get install mariadb-plugin-connect
