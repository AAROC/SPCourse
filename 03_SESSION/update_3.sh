#!/bin/bash

cd /home/testuser/SP_COURSE/03_SESSION

cp -r shibboleth/ /etc/
cp -r apache2/ /etc/
cp -r html/ /var/www/

chmod +x /var/www/html/intranet/sample.py
a2enmod mod_cgi

service shibd restart
service apache2 restart
