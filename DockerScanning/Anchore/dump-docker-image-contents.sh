#!/bin/sh

anchore-cli image content guacamole/guacd:latest os | grep guac
anchore-cli image content guacamole/guacd:latest files > guacd-file-list
anchore-cli image content guacamole/guacamole:latest files > guacamole-file-list

less guacamole-file-list

