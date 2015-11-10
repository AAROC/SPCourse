#!/bin/bash

cd /home/testuser/SP_COURSE/04_SESSION

apt-get install -y tomcat7

cp -r shibboleth/ /etc/
cp -r apache2/ /etc/
cp -r tomcat7/server.xml /etc/tomcat7/server.xml
cp -r tomcat7/SPCourse.war /var/lib/tomcat7/webapps/

service tomcat7 restart
service shibd restart
service apache2 restart
