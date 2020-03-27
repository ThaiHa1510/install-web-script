#!/bin/bash
while [ 1 ];do
#clear
printf "=========================================================================\n"
printf "Chuan bi qua trinh tai ban cai dat Website... \n"
printf "=========================================================================\n"

printf "Ban hay dien thong tin nhu yeu cau: \n"
# domain
domain='/home/$host/public_html/'
echo -n "Domain cap nhap:"
read host;
done
# Download latest WordPress and uncompress
mkdir "/home/$host/";
mkdir "$domain";
cd "$domain"
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
cp /home/scripts/temp/default-static.conf /etc/nginx/conf.d/$host.conf
sed -i "s/xxx/"$host"/" /etc/nginx/conf.d/$host.conf
sed -i "s/www.xxx/"$host"/" /etc/nginx/conf.d/$host.conf

