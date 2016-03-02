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
