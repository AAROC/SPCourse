#!/bin/bash

cd /home/testuser/SP_COURSE/09_SESSION

cp shibboleth-embedded-ds-1.0.2.tar.gz /usr/local/src
cd /usr/local/src ; tar -zxf shibboleth-embedded-ds-1.0.2.tar.gz
cd shibboleth-embedded-ds-1.0.2 ; make install
cp shibboleth-ds.conf /etc/apache2/sites-available/shibboleth-ds.conf

sed -i 's/entityID="https:\/\/idp-corso.irccs.garr.it\/idp\/shibboleth"/isDefault="true"/g' /etc/shibboleth/shibboleth2.xml
sed -i 's/discoveryURL="https:\/\/ds.example.org\/DS\/WAYF">/discoveryURL="https:\/\/sp1.local\/shibboleth-ds\/index.html">/g' /etc/shibboleth/shibboleth2.xml

a2ensite shibboleth-ds.conf

service shibd restart
service apache2 restart
