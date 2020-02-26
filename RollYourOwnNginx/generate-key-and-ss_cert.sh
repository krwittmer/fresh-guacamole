#!/bin/sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout guacamole-selfsigned.key -out guacamole-selfsigned.crt
openssl dhparam -dsaparam -out dhparam.pem 4096

