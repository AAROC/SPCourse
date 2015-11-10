# SPCourse

Course on how to transform your application into a federated service.
This matherial includes a set of handson sessions referenced from the video lessons.
For all the sessions in the specific folder, a script implementing the solution is present.

The hands on sessions are the following:

## 01_SESSION: installation and base configuration of an SP
   This exercise will request to install and configure Shibboleth SP to protect the resources into a specific folder on Apache.
   The main steps to be followed to execute this exercise are:
   * install required packages, on Ubuntu execute
     ```
     apt-get install libapache2-mod-shib2 apache2 ntp php5 openssl
     ```
   * download the metadata signer certificate from the URL provided by the federation operators
     ```
     wget https://sp.lab.unimo.it/metadata-signer.crt -O /etc/shibboleth/metadata-signer.crt
     ```
   * copy SP certificates from the files provided within this repo
     ```
     cp /home/testuser/SP_COURSE/01_SESSION/shibboleth/sp-*.pem /etc/shibboleth
     ```
   * edit the file ``/etc/shibboleth/shibboleth2.xml`` by specifying:
     * ``entityID="https://sp1.local/shibboleth"``
     * ``<SSO entityID="https://idp-corso.irccs.garr.it/idp/shibboleth"``
     * configure the ``MetadataProvider`` to download the metadata file from the URL provided by the federation operator
   * download the metadata from the URL provided by the federation operator and change ownership
     ```
     https://sp.lab.unimo.it/rr3/signedmetadata/federation/fed-corso/metadata.xml -O signed-test-metadata.xml
     chown _shibd._shibd signed-test-metadata.xml
     ```
   * test shibboleth configuration
     ```
     shibd -t
     ```
   * modify apache2 configuration editing file ``/etc/apache2/sites-enabled/service_provider.conf`` and protecting the ``intranet`` location
   * restert services to apply modifications
     ```
     service shibd restart
     service apache2 restart
     ```

## 02_SESSION - application example PHP
   This exercise will request to create a sample PHP application to test parameter passing after Shibboleth login.
   The main steps to be followed to execute this exercise are:
   * edit ``/etc/shibboleth/attribute-map.xml`` file and uncomment all commented parts
   * create a sample PHP application in ``/var/www/html/intranet/sample.php`` with the content in course slide matherial
   * restert services to apply modifications
     ```
     service shibd restart
     ```

## 03_SESSION - application example Python/CGI
   This exercise will request to create a sample CGI/Python application to test parameter passing after Shibboleth login.
   The main steps to be followed to execute this exercise are:
   * create a sample CGI/Python application in ``/var/www/html/intranet/sample.py`` with the content in course slide matherial
   * make the script executable
     ```
     chmod +x /var/www/html/intranet/sample.py
     ```
   * check the the CGI module is already enabled in Apache2
     ```
     a2enmod mod_cgi
     ```
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```

## 04_SESSION application example Java
   This exercise will request to create a sample Java application to test parameter passing after Shibboleth login.
   The main steps to be followed to execute this exercise are:
   * install missing packages, in particular install tomcat7
     ```
     apt-get install tomcat7
     ```
   * modify file ``/etc/shibboleth/shibboleth2.xml`` to add ``attributePrefix="AJP_"`` in ``ApplicationDefaults`` tag.
   * modify tomcat configuration to enable AJP connector on port 8009, the connector must be enable din ``/etc/tomcat7/server.xml`` file and must have ``tomcatAuthentication="false"`` parameter set
   * modify the apache configuration in file ``/etc/apache2/sites-available/service_provider.conf`` by specifying:
     ```
     <Location /SPCourse>
       AuthType shibboleth
       ShibRequestSetting requireSession true
       Require shib-session
     </Location>
  
     ProxyPass        /SPCourse ajp://localhost:8009/SPCourse
     ProxyPassReverse /SPCourse ajp://localhost:8009/SPCourse
     ```
   * deploy war application to tomcat server
     ```
     cp /home/testuser/SP_COURSE/04_SESSION/tomcat7/SPCourse.war /var/lib/tomcat7/webapps/
     ```
   * restart services to apply modifications
     ```
     service shibd restart
     service apache2 restart
     service tomcat7 restart
     ```

## 05_SESSION application example Lazy Session
   This exercise will configure a lazy session page on a PHP application.
   The main steps to be followed to execute this exercise are:
   * modify the apache configuration in file ``/etc/apache2/sites-available/service_provider.conf`` by specifying:
     ```
     <Location /lazy.php>
	AuthType shibboleth
	ShibRequestSetting requireSession false
	Require shibboleth
     </Location>
     ```
   * create a sample lazy session page in PHP in the file ``/var/www/html/lazy.py`` with the content from the course slides matherial
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```
  
## 06_SESSION configuring multiple virtualhost
   This exercise will configure an SP serving multiple virtual hosts on the same server.
   The main steps to be followed to execute this exercise are:
   * configure multiple virtual hosts in apache2
   * download on your PC the SP metadata obtained from ``https://sp1.local/Shibboleth.sso/MetadataProvider``
   * edit the downloaded metadata file by adding a new Assertion Consumer Service (ACS) with protocol ``HTTP-POST`` and with hostname ``sp2.local``
   * share the new metadata file with the federation operators to receive it and share to all trusted entries.

## 07_SESSION access control configuration in Apache
   This exercise will permit to configure access control rules inside Apache.
   The main steps to be followed to execute this exercise are:
   * you can check the affiliation attribute for your user visiting ``https://sp1.local/Shibboleth.sso/Session`` after a successful Shibboleth login
   * create a page ``/var/www/html/affiliation_staff.html`` with a static content, this page will be used as an example and shown only to users with ``staff`` affilitation
   * modify the apache configuration in file ``/etc/apache2/sites-available/service_provider.conf`` by specifying:
     ```
     <Location /affiliation_staff.html>
         AuthType shibboleth
         ShibRequestSetting requireSession true
         Require shib-attr affiliation staff@irccs.garr.it
     </Location>
     ```
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```

## 08_SESSION access control configuration in the SP
   This exercise will permit to configure access control rules inside Apache.
   The main steps to be followed to execute this exercise are:
   * you can check the affiliation attribute for your user visiting ``https://sp1.local/Shibboleth.sso/Session`` after a successful Shibboleth login
   * create a page ``/var/www-sp2.local/html/affiliation_staff.html`` with a static content, this page will be used as an example and shown only to users with ``staff`` affilitation
   * modify the apache configuration in file ``/etc/apache2/sites-available/sp2.local.conf`` by specifying:
     ```
     <Location />
         AuthType shibboleth
         Require shibboleth
     </Location>
     ```
   * modify the shibboleth SP configuration in file ``/etc/shibboleth2.xml`` by specifying:
     ```
     <RequestMapper type="Native">
        <RequestMap>
             <Host name="sp2.local">
                <Path name="intranet/intranet.html" authType="shibboleth" requireSession="true" />
                <Path name="affiliation_staff.html" authType="shibboleth" requireSession="true">
                    <AccessControl>
                        <Rule require="affiliation">staff@irccs.garr.it</Rule>
                    </AccessControl>
                </Path>
             </Host>
         </RequestMap>
     </RequestMapper>
     ```
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```

## 09_SESSION configuring a centralized DS
   This exercise will permit to configure the SP to authenticate with a centralized Discovery Service.
   The main steps to be followed to execute this exercise are:
   * modify the shibboleth SP configuration in file ``/etc/shibboleth2.xml`` by specifying:
     ```
     <SSO discoveryProtocol="SAMLDS" discoveryURL="https://wayf.idem-test.garr.it/WAYF">
         SAML2 SAML1
     </SSO>
     ```
   * restart services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```

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
