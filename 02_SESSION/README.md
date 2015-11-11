## 02_SESSION - application example PHP
   This exercise will request to create a sample PHP application to test parameter passing after Shibboleth login.
   The main steps to be followed to execute this exercise are:
   * edit ``/etc/shibboleth/attribute-map.xml`` file and uncomment all commented parts
   * create a sample PHP application in ``/var/www/html/intranet/sample.php`` with the content in course slide matherial
   * restert services to apply modifications
     ```
     service shibd restart
     ```
