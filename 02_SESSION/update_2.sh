#!/bin/bash

cd /home/testuser/SP_COURSE/02_SESSION

cp -r shibboleth/ /etc/
cp -r apache2/ /etc/
cp -r html/ /var/www/

chmod +x /var/www/html/intranet/prova.py

service shibd restart
service apache2 restart
