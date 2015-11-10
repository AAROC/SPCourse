#!/bin/bash

cd /home/testuser/SP_COURSE/08_SESSION

cp -r apache2/ /etc/
cp -r shibboleth/ /etc/

service shibd restart
service apache2 restart
