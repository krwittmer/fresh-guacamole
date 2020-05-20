#!/bin/sh

rm wget.log
rm guacamole-login.html

wget --no-check-certificate --output-file=wget.log --output-document='guacamole-login.html' https://myhost.net/guacamole-web

