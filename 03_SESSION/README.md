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
