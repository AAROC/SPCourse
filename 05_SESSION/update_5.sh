#!/bin/bash

cd /home/testuser/SP_COURSE/05_SESSION

cp -r shibboleth/ /etc/
cp -r apache2/ /etc/
cp -r html/ /var/www/

service shibd restart
service apache2 restart
