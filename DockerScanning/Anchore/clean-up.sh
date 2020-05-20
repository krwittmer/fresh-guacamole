#!/bin/sh

# remove Docker images from Anchore?

anchore-cli image remove guacamole/guacd:latest
anchore-cli image remove guacamole/guacamole:latest
anchore-cli image list

docker-compose down

# remove Docker images?
