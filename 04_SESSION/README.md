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
