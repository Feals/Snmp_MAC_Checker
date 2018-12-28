#!/bin/bash

#Copie des fichiers selectioner dans la BlackList#
touch /var/www/html/MAC/Sav_Date.txt
cp /var/www/html/Select_L.txt /var/www/html/MAC/
sed 's/\x0D$//' /var/www/html/MAC/Select_L.txt > /var/www/html/MAC/Select_no_rL.txt;cat /var/www/html/MAC/Select_L.txt >> /var/www/html/MAC/Blacklist_MAC.txt

#------------------------------------------------#

#Je supprime toute les lignes identiques a mon fichier Select_L.txt#

while read line0
do
sleep 0.1
sed -in "/$line0/d" /var/www/html/MAC/Learned_MAC.site;
done </var/www/html/MAC/Select_no_rL.txt

#-------------------------------------------------------------#

#Je Sauvegarde les lignes identiques#


while read line1
do
cat /var/www/html/MAC/Waiting.tmp | grep $line1 >> /var/www/html/MAC/Sav_Date.txt
done </var/www/html/MAC/Select_no_rL.txt

#-----------------------------------#

#Je supprime toute les lignes identiques a mon fichier Select_L.txt#

while read line2
do
sleep 0.1
sed -in "/$line2/d" /var/www/html/MAC/Learned_MAC.txt;
done </var/www/html/MAC/Select_no_rL.txt

#------------------------------------------------------------------#

#------------------------------------------------------------------#

#Je supprime toute les lignes identiques a mon fichier Select_L.txt#

while read line3
do
sleep 0.1
sed -in "/$line3/d" /var/www/html/MAC/Waiting.tmp;
done </var/www/html/MAC/Select_no_rL.txt

#------------------------------------------------------------------#

#Je vide la selection#


rm /var/www/html/Select_L.txt  /var/www/html/MAC/Select_no_rL.txt /var/www/html/MAC/Select_L.txt
rm /var/www/html/MAC/Learned_MAC.siten /var/www/html/MAC/Learned_MAC.txtn /var/www/html/MAC/Waiting.tmpn

touch /var/www/html/Select_L.txt
chmod 777 /var/www/html/Select_L.txt
#--------------------#
