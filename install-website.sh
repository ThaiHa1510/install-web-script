#!/bin/bash
# script chi chay voi quyen root
#if [ $(id -u) -ne 0 ] ; 
#then 
#    echo "Please run as root" ; 
#    exit 1 ; 
#fi
printf "Chon loai website ban muon cai dat \n"
printf "1.Wordpress \n"
printf "2.Static Website \n"
read styleweb;
case $styleweb in 
	1)
	echo "Ban chon Wordpress Website"
    sh ./includes/script-cai-wordpress.sh 
	;;
	2)
	echo "Ban chon Static website "
    sh ./includes/script-cai-static.sh 
	;;
	*)
	exit
	;;
esac