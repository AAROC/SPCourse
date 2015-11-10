#!/bin/bash

cd /home/testuser/SP_COURSE/06_SESSION

cp -r apache2/ /etc/
cp -r var/ /

service apache2 restart
