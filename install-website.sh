#!/bin/bash
if [ $(id -u) -ne 0 ] ; 
then 
    echo "Please run as root" ; 
    exit 1 ; 
fi
printf "Chon loai website ban muon cai dat \n"
printf "1.Wordpress \n"
printf "2.Static Website \n"
read styleweb;
case $styleweb in 
	1)
	echo "Ban chon Wordpress Website"
    sh script-cai-wordpress.sh 
	;;
	2)
	echo "Ban chonStatic website "
    sh script-cai-static.sh 
	;;
	*)
	exit
	;;
esac