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
echo -e "$Vlan3\n$Vlan4" > scan.tmp

#---------------------#

#Remplacement des espaces par des : et suppressions des espaces#

cut -d "|" -f1 Trusted_MAC.txt | tr -s " " ":" | sort -u > Trust.tmp
sed -i 's/ //g' Trust.tmp && sed -i 's/ //g' scan.tmp
diff -b <(sort scan.tmp) <(sort Trust.tmp) |grep "<" | cut -d " " -f2 > Learn.tmp
sed -i 's/ //g' Learn.tmp

#--------------------------------------------------------------#

#Comparaison du Dictionnaire avec le Scan#

diff -b <(sort Learn.tmp) <(sort Trust.tmp) |grep "<" | cut -d " " -f2 > Learn1.tmp

#----------------------------------------#

#Ajout de la date a coté des nouvelles Adresses#

while read line0
do
echo $line0$FirstView$LastView >> learn_sort.tmp
done < Learn1.tmp

#----------------------------------------------#

#Suppressions des fichiers tmp et on tri/supprime les espaces pour l'affichage sur le site#

sort -u learn_sort.tmp > Learning.tmp
rm learn_sort.tmp Learn1.tmp Learn.tmp scan.tmp
	#sed -i 's/ //g' Learned_MAC.site
	#sed -i '1iAdresse MAC      |First View|Last View' Learned_MAC.txt

#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------#

#Je cherche les Différences Entre le Waiting et le Learning#

touch Waiting.tmp
cut -d "|" -f1 Learning.tmp| tr -s " " ":" > New.tmp
cut -d "|" -f1 Waiting.tmp | tr -s " " ":" > Old.tmp
comm -23 <(sort New.tmp) <(sort Old.tmp) > Diff.tmp

rm Difference.tmp
touch Difference.tmp
while read line1
do
echo $line1$FirstView$LastView >> Difference.tmp
done <Diff.tmp


#---------------------------------------------------------#

#Je cherche les similarités Entre le Waiting et le Learning#

comm -12 <(sort New.tmp) <(sort Old.tmp) > Same.tmp

#---------------------------------------------------------#


#Je supprime toute les lignes identiques a mon fichier Same.tmp#
cut -d"|" -f1,2 Waiting.tmp > SavFirstView.tmp

while read line2
do
  sed -in "/$line2/d" Waiting.tmp

done <Same.tmp
#-------------------------------------------------------------#

#Je rajoute toute les lignes identiques avec la nouvelle date#


while read line3
do
echo "$line3$LastView" >> Waiting.tmp
done <SavFirstView.tmp

#------------------------------------------------------------------#
cat Difference.tmp >>Waiting.tmp
cat Waiting.tmp > Learned_MAC.txt
cut -d"|" -f1 Learned_MAC.txt > Learned_MAC.site
rm Diff.tmp Learning.tmp New.tmp Old.tmp Same.tmp SavFirstView.tmp Trust.tmp
