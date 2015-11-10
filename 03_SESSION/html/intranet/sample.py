#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-# enable debugging
import cgitb
from os import environ
cgitb.enable()

def get_name():
    attribute_prefix = ""
    if "%sdisplayName"%attribute_prefix in environ:
        return " ".join(environ["%sdisplayName"%attribute_prefix].split(";"))
    elif "%scn"%attribute_prefix in environ:
        return " ".join(environ["%scn"%attribute_prefix].split(";"))
    elif "%sgivenName"%attribute_prefix in environ and "%ssn"%attribute_prefix in environ:
        return " ".join(environ["%sgivenName"%attribute_prefix].split(";")) + " " + \
               " ".join(environ["%ssn"%attribute_prefix].split(";"))
    return "Unknown"

print "Content-Type: text/html;charset=utf-8"
print

username = environ.get("REMOTE_USER", None)
name = get_name()

print "<h1>Hello %s!!!</h1>" % username
print "<p>Your name is %s.</p>" % name
