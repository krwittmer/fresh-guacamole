FROM nginx:alpine

COPY guacamole-selfsigned.crt /etc/ssl/certs/
COPY guacamole-selfsigned.key /etc/ssl/private/
COPY dhparam.pem /etc/nginx/

COPY nginx.conf /etc/nginx/conf.d/nginx.conf

