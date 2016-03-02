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
