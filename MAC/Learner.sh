#!/bin/bash

#Heure Unix Execution du Script#

date=$(date +%s)
LastView=$(echo "|$date")
FirstView=$(echo "|$date")

#Heure Humaine Execution du script#


#------------------------------#

#Scan Des Adresses MAC#

Vlan3=$(snmpwalk -v 2c -O Uv -c rusyr2gl@3 10.36.0.2 1.3.6.1.2.1.17.4.3.1.1 | cut -d " " -f2,3,4,5,6,7,8 | tr -s " " ":" |sed 's/\(.*\).$/\1/')
Vlan4=$(snmpwalk -v 2c -O Uv -c rusyr2gl@4 10.36.0.2 1.3.6.1.2.1.17.4.3.1.1 | cut -d " " -f2,3,4,5,6,7,8 | tr -s " " ":" |sed 's/\(.*\).$/\1/')
echo -e "$Vlan3\n$Vlan4" > /var/www/html/MAC/scan.tmp

#---------------------#

#Remplacement des espaces par des : et suppressions des espaces#

cut -d "|" -f1 /var/www/html/MAC/Trusted_MAC.txt | tr -s " " ":" | sort -u > /var/www/html/MAC/Trust.tmp
sed -i 's/ //g' /var/www/html/MAC/Trust.tmp && sed -i 's/ //g' /var/www/html/MAC/scan.tmp
diff -b <(sort /var/www/html/MAC/scan.tmp) <(sort /var/www/html/MAC/Trust.tmp) |grep "<" | cut -d " " -f2 > /var/www/html/MAC/Learn.tmp
sed -i 's/ //g' /var/www/html/MAC/Learn.tmp

#--------------------------------------------------------------#

#Comparaison du Dictionnaire avec le Scan#

diff -b <(sort /var/www/html/MAC/Learn.tmp) <(sort /var/www/html/MAC/Trust.tmp) |grep "<" | cut -d " " -f2 > /var/www/html/MAC/Learn1.tmp

#----------------------------------------#

#Ajout de la date a coté des nouvelles Adresses#

while read line0
do
echo $line0$FirstView$LastView >> /var/www/html/MAC/learn_sort.tmp
done < /var/www/html/MAC/Learn1.tmp

#----------------------------------------------#

#Suppressions des fichiers tmp et on tri/supprime les espaces pour l'affichage sur le site#

sort -u /var/www/html/MAC/learn_sort.tmp > /var/www/html/MAC/Learning.tmp
rm /var/www/html/MAC/learn_sort.tmp /var/www/html/MAC/Learn1.tmp /var/www/html/MAC/Learn.tmp /var/www/html/MAC/scan.tmp
	#sed -i 's/ //g' /var/www/html/MAC/Learned_MAC.site
	#sed -i '1iAdresse MAC      |First View|Last View' /var/www/html/MAC/Learned_MAC.txt

#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#

#Je cherche les Différences Entre le Waiting et le Learning#

touch Waiting.tmp
cut -d "|" -f1 /var/www/html/MAC/Learning.tmp| tr -s " " ":" > /var/www/html/MAC/New.tmp
cut -d "|" -f1 /var/www/html/MAC/Waiting.tmp | tr -s " " ":" > /var/www/html/MAC/Old.tmp
comm -23 <(sort /var/www/html/MAC/New.tmp) <(sort /var/www/html/MAC/Old.tmp) > /var/www/html/MAC/Diff.tmp

rm /var/www/html/MAC/Difference.tmp
touch /var/www/html/MAC/Difference.tmp
while read line1
do
echo $line1$FirstView$LastView >> /var/www/html/MAC/Difference.tmp
done < /var/www/html/MAC/Diff.tmp

#---------------------------------------------------------#

#Je cherche les similarités Entre le Waiting et le Learning#

comm -12 <(sort /var/www/html/MAC/New.tmp) <(sort /var/www/html/MAC/Old.tmp) > /var/www/html/MAC/Same.tmp

#---------------------------------------------------------#


#Je supprime toute les lignes identiques a mon fichier Same.tmp#
cut -d"|" -f1,2 /var/www/html/MAC/Waiting.tmp > /var/www/html/MAC/SavFirstView.tmp

while read line2
do
  sed -in "/$line2/d" /var/www/html/MAC/Waiting.tmp;

done < /var/www/html/MAC/Same.tmp
#-------------------------------------------------------------#

#Je rajoute toute les lignes identiques avec la nouvelle date#


while read line3
do
echo "$line3$LastView" >> /var/www/html/MAC/Waiting.tmp
done < /var/www/html/MAC/SavFirstView.tmp

#------------------------------------------------------------------#
fichier=/var/www/html/MAC/Difference.tmp
if [ -s $fichier ]; then
  cat /var/www/html/MAC/Difference.tmp>>/var/www/html/MAC/Waiting.tmp
fi
cat /var/www/html/MAC/Waiting.tmp > /var/www/html/MAC/Learned_MAC.txt
cut -d "|" -f1 /var/www/html/MAC/Learned_MAC.txt > /var/www/html/MAC/Learned_MAC.site

rm /var/www/html/MAC/Diff.tmp /var/www/html/MAC/Learning.tmp /var/www/html/MAC/New.tmp /var/www/html/MAC/Old.tmp /var/www/html/MAC/Same.tmp /var/www/html/MAC/SavFirstView.tmp /var/www/html/MAC/Trust.tmp /var/www/html/MAC/Waiting.tmpn
