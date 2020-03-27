
#!/bin/bash

while [ 1 ];do
#clear
printf "=========================================================================\n"
printf "Chuan bi qua trinh tai ban cai dat WordPress... \n"
printf "=========================================================================\n"

printf "Ban hay dien thong tin nhu yeu cau: \n"
# domain
echo -n "Domain cap nhap:"
read host;
echo -n "Database Host:"
read mysqlhost;
echo -n "Database Name:"
read mysqldb;
echo -n "Database User:"
read mysqluser;
echo -n "Database Password:"
read mysqlpass;
domain='/home/$host/public_html/'


if [ "$mysqldb" != "" ] && [ "$mysqluser" != "" ] && [ "$mysqlpass" != "" ]; then
	break
fi
done

clear
printf "=========================================================================\n"
printf "Downloading... \n"
printf "=========================================================================\n"

# Download latest WordPress and uncompress
mkdir "/home/$host/";
mkdir "$domain";
cd "$domain"

pwd
echo "Ban muon update wordpress"
read update;
if ["$update" != ""]

rm -rf "$domain"/wp-admin "$domain"/wp-includes
find "$domain" -maxdepth 1 -type f  -delete
wget http://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz
cp -r  wordpress/* ./

# Grab Salt Keys
wget -O /tmp/wp.keys https://api.wordpress.org/secret-key/1.1/salt/

# Butcher our wp-config.php file
sed -e "s/localhost/"$mysqlhost"/" -e "s/database_name_here/"$mysqldb"/" -e "s/username_here/"$mysqluser"/" -e "s/password_here/"$mysqlpass"/" wp-config-sample.php > wp-config.php
sed -i '/#@-/r /tmp/wp.keys' wp-config.php
sed -i "/#@+/,/#@-/d" wp-config.php

# Tidy up
rm -rf wordpress
rm latest.tar.gz
rm /tmp/wp.keys
rm wp-content
 then
# Chown
if [ -f /etc/redhat-release ]; then #CentOS
 if ps ax | grep -v grep | grep 'httpd' > /dev/null; then #Apache
 chown -R apache:apache *
 elif ps ax | grep -v grep | grep 'nginx' > /dev/null; then #Nginx
 chown -R nginx:nginx *
 fi
elif [ -f /etc/lsb-release ]; then #Ubuntu
 chown -R www-data:www-data * #Both for Apache and Nginx
fi
#
printf "=========================================================================\n"
printf "Cau hinh vitrual host \n"
printf "=========================================================================\n"
cp /home/scripts/temp/default.conf /etc/nginx/conf.d/$host.conf
sed -i "s/xxx/"$host"/" /etc/nginx/conf.d/$host.conf
sed -i "s/www.xxx/"$host"/" /etc/nginx/conf.d/$host.conf
printf "=========================================================================\n"
printf "Tao database va user \n"
printf "=========================================================================\n"
sh /home/scripts/mysql-db-create.sh $mysqldb $mysqluser $mysqlpass $host
clear
printf "=========================================================================\n"
printf "Xong, gio ban hay truy cap vao domain de cai dat WordPress va kich hoat plugin! \n"
printf "=========================================================================\n"
