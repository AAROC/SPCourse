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
