#!/bin/bash
cp /etc/shibboleth/sp-key.pem /var/simplesamlphp/cert/
cp /etc/shibboleth/sp-cert.pem /var/simplesamlphp/cert/
chown www-data /var/simplesamlphp/cert/sp-key.pem
cp -r /home/testuser/CORSO_IDEM/4_SESSIONE/html/* /var/www/html/
