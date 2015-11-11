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
