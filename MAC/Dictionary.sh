#!/bin/bash
snmpwalk -v 2c -O Uv -c rusyr2gl@3 10.36.0.2 1.3.6.1.2.1.17.4.3.1.1 >> /var/www/html/MAC/All_MAC_V3.txt
snmpwalk -v 2c -O Uv -c rusyr2gl@4 10.36.0.2 1.3.6.1.2.1.17.4.3.1.1 >> /var/www/html/MAC/All_MAC_V4.txt
sort -u /var/www/html/MAC/All_MAC_V3.txt|cut -d : -f2 > /var/www/html/MAC/Trusted_MAC_V3
sort -u /var/www/html/MAC/All_MAC_V4.txt|cut -d : -f2 > /var/www/html/MAC/Trusted_MAC_V4
cat /var/www/html/MAC/Trusted_MAC_V3 > Temp
cat /var/www/html/MAC/Trusted_MAC_V4 >> Temp
cat Temp > Trusted_MAC
rm Temp


