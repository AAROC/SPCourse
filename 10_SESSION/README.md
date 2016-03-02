## 10_SESSION configuring an embedded DS
   This exercise will permit to configure the SP to authenticate with an embedded Discovery Service.
   The main steps to be followed to execute this exercise are:
   * install the Shibboleth embedded DS
     ```
     cp shibboleth-embedded-ds-1.0.2.tar.gz /usr/local/src
     cd /usr/local/src ; tar -zxf shibboleth-embedded-ds-1.0.2.tar.gz
     cd shibboleth-embedded-ds-1.0.2 ; make install
     ```
   * edit the apache site configurationf or shibboleth ds in ``/etc/apache2/sites-available/shibboleth-ds.conf``
     ```
     <IfModule mod_alias.c>
         <Location /shibboleth-ds>
             Allow from all
         </Location>
         Alias /shibboleth-ds/idpselect_config.js /etc/shibboleth-ds/idpselect_config.js
         Alias /shibboleth-ds/idpselect.js /etc/shibboleth-ds/idpselect.js
         Alias /shibboleth-ds/idpselect.css /etc/shibboleth-ds/idpselect.css
         Alias /shibboleth-ds/index.html /etc/shibboleth-ds/index.html
     </IfModule>
     ```
   * enable shibboleth-ds site in apache configuration
     ```
     a2ensite shibboleth-ds.conf
     ```
   * modify the shibboleth SP configuration in file ``/etc/shibboleth2.xml`` by specifying:
     ```
     <SSO discoveryProtocol="SAMLDS" discoveryURL="https://sp1.local/shibboleth-ds/index.html">
        SAML2 SAML1
     </SSO>
     
     ...
     
     <Handler type="DiscoveryFeed" Location="/DiscoFeed"/>
     ```
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```
