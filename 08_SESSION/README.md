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
