## 06_SESSION configuring multiple virtualhost
   This exercise will configure an SP serving multiple virtual hosts on the same server.
   The main steps to be followed to execute this exercise are:
   * configure multiple virtual hosts in apache2
   * download on your PC the SP metadata obtained from ``https://sp1.local/Shibboleth.sso/MetadataProvider``
   * edit the downloaded metadata file by adding a new Assertion Consumer Service (ACS) with protocol ``HTTP-POST`` and with hostname ``sp2.local``
   * share the new metadata file with the federation operators to receive it and share to all trusted entries.
