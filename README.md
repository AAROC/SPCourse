# SPCourse

Course on how to transform your application into a federated service.
This matherial includes a set of handson sessions referenced from the video lessons.
For all the sessions in the specific folder, a script implementing the solution is present.

The hands on sessions are the following:

1. **01_SESSION: installation and base configuration of an SP**
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
     cp /home/testuser/CORSO_IDEM/1_SESSIONE/shibboleth/sp-*.pem /etc/shibboleth
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

1. **02_SESSION - application example PHP**
   This exercise will request to create a sample PHP application to test parameter passing after Shibboleth login.
   The main steps to be followed to execute this exercise are:
   * edit ``/etc/shibboleth/attribute-map.xml`` file and uncomment all commented parts
   * create a sample PHP application in ``/var/www/html/intranet/sample.php`` with the content in course slide matherial
   * restert services to apply modifications
     ```
     service shibd restart
     ```

1. **03_SESSION - application example Python/CGI**
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
   * restert services to apply modifications
     ```
     service apache2 restart
     service shibd restart
     ```

## EXERCISE 4 - application example Java
- apt-get install tomcat7
- vim /etc/shibboleth/shibboleth2.xml
  attributePrefix="AJP_"
- service shibd restart
- vim /etc/tomcat7/server.xml
  tomcatAuthentication="false"
- vim /etc/apache2/sites-available/service_provider.conf  
  <Location /CorsoIDEM>
    AuthType shibboleth
    ShibRequestSetting requireSession true
    Require shib-session
  </Location>
  
  ProxyPass        /CorsoIDEM ajp://localhost:8009/CorsoIDEM
  ProxyPassReverse /CorsoIDEM ajp://localhost:8009/CorsoIDEM
- cp /home/testuser/CORSO_IDEM/2_SESSIONE/tomcat7/CorsoIDEM.war /var/lib/tomcat7/webapps/
- service apache2 restart
- service tomcat7 restart

## EXERCISE 5 - application example Lazy Session
- vim /etc/apache2/sites-available/service_provider.conf  
  <Location /lazy.php>
	AuthType shibboleth
	ShibRequestSetting requireSession false
	Require shibboleth
  </Location>
- vi /var/www/html/lazy.py
  copy from slide (attento manca virgolette)
- service apache2 restart
- service shibd restart
  
## EXERCISE 6 - configuring multiple virtualhost
- configure virtualhost in apache2
- download SP metadata from https://sp1.local/Shibboleth.sso/MetadataProvider
- add HTTP-POST ACS with name sp2.local

## EXERCISE 7 - access control configuration in Apache
- view https://sp1.local/Shibboleth.sso/Session and verify value for attribure affiliation
- create /var/www/html/affiliation_staff.html
  with simple content to be created
- configure /etc/apache2/sites-available/service_provider.conf
  with
  <Location /affiliation_staff.html>
    AuthType shibboleth
    ShibRequestSetting requireSession true
    Require shib-attr affiliation staff@irccs.garr.it
  </Location>
- service apache2 restart
- service shibd restart

## EXERCISE 8 - access control configuration in the SP
- view https://sp1.local/Shibboleth.sso/Session and verify value for attribure affiliation
- create /var/www-sp2.local/html/affiliation_staff.html
  with simple content to be created
- vim /etc/apache2/sites-enabled/sp2.local.conf
<Location />
AuthType shibboleth
Require shibboleth
</Location>
- vim /etc/shibboleth2.xml
<RequestMapper type="Native">
        <RequestMap>
                <Host name="sp2.local">
                <Path name="intranet/intranet.html" authType="shibboleth" requireSession="true">
                </Path>
                <Path name="affiliation_staff.html" authType="shibboleth" requireSession="true">
                <AccessControl>
                        <Rule require="affiliation">staff@irccs.garr.it</Rule>
                </AccessControl>
                </Path>
                </Host>
        </RequestMap>
</RequestMapper>
- service apache2 restart
- service shibd restart

## EXERCISE 9 - configuring a centralized DS
- vim /etc/shibboleth/shibboleth2.xml
    <SSO discoveryProtocol="SAMLDS" discoveryURL="https://wayf.idem-test.garr.it/WAYF">
       SAML2 SAML1
    </SSO>
- service apache2 restart
- service shibd restart

## EXERCISE 10 - configuring an embedded DS
- cp shibboleth-embedded-ds-1.0.2.tar.gz /usr/local/src
- cd /usr/local/src ; tar -zxf shibboleth-embedded-ds-1.0.2.tar.gz
- cd shibboleth-embedded-ds-1.0.2 ; make install
- vim /etc/apache2/sites-available/shibboleth-ds.conf
<IfModule mod_alias.c>
  <Location /shibboleth-ds>
    Allow from all
  </Location>
  Alias /shibboleth-ds/idpselect_config.js /etc/shibboleth-ds/idpselect_config.js
  Alias /shibboleth-ds/idpselect.js /etc/shibboleth-ds/idpselect.js
  Alias /shibboleth-ds/idpselect.css /etc/shibboleth-ds/idpselect.css
  Alias /shibboleth-ds/index.html /etc/shibboleth-ds/index.html
</IfModule>
- a2ensite shibboleth-ds.conf
- vim /etc/shibboleth/shibboleh2.xml
    <SSO discoveryProtocol="SAMLDS" discoveryURL="https://sp1.local/shibboleth-ds/index.html">
       SAML2 SAML1
    </SSO>
    ...
	<Handler type="DiscoveryFeed" Location="/DiscoFeed"/>
- service apache2 restart
- service shibd restart
