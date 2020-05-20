#!/bin/sh

anchore-cli image add guacamole/guacd:latest
anchore-cli image add guacamole/guacamole:latest
anchore-cli image list

anchore-cli image vuln guacamole/guacd:latest os
anchore-cli image vuln guacamole/guacd:latest all
anchore-cli image vuln guacamole/guacamole:latest os
anchore-cli image vuln guacamole/guacamole:latest all
