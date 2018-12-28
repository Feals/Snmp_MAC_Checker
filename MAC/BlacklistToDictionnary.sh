#!/bin/bash

#Copie des fichiers selectioner dans la BlackList#
cp  /var/www/html/Select_B.txt /var/www/html/MAC/

#------------------------------------------------#

cat  /var/www/html/MAC/Sav_Date.txt >> /var/www/html/MAC/Trusted_MAC.txt

#-------------------------------------------------------------#

#Je vide les fichiers#
rm  /var/www/html/MAC/Sav_Date.txt
rm  /var/www/html/MAC/Blacklist_MAC.txt
rm  /var/www/html/MAC/Select_B.txt
rm  /var/www/html/Select_B.txt

touch /var/www/html/MAC/Sav_Date.txt
touch /var/www/html/MAC/Blacklist_MAC.txt
touch /var/www/html/Select_B.txt

chmod 777 /var/www/html/MAC/Sav_Date.txt /var/www/html/MAC/Blacklist_MAC.txt /var/www/html/Select_B.txt 
#--------------------#

