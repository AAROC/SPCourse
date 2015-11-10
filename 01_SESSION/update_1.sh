#!/bin/bash

cd /home/testuser/SP_COURSE/01_SESSION

cp -r shibboleth/ /etc/
cp -r apache2/ /etc/

chown _shibd /etc/shibboleth
chown _shibd:_shibd /etc/shibboleth/sp-*

service shibd restart
service apache2 restart

