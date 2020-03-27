#!/bin/bash

# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # Green

EXPECTED_ARGS=4
E_BADARGS=65
MYSQL=`which mysql`
MYSQL_PASS="78aliefFafeefa"
Q1="CREATE DATABASE IF NOT EXISTS $1;"
Q2="GRANT ALL ON $1.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
CONFIG_FILE="/etc/nginx/conf.d/$4.conf";
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass host"
  exit $E_BADARGS
fi
 
$MYSQL -uroot -p"$MYSQL_PASS" -e "$SQL"

ok "Database $1 and user $2 created with a password $3"
echo -e "=========================================================================" >> /home/DBinfo.txt
echo -e "Database:  -$1 Created on: $(date) when add $4 to VPS " >> /home/DBinfo.txt
echo -e "=========================================================================" >> /home/DBinfo.txt
echo -e "Data name: $1" >> /home/DBinfo.txt
echo -e "Username: $2" >> /home/DBinfo.txt
echo -e "password: $3" >> /home/DBinfo.txt

