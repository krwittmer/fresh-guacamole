#!/bin/sh
#
# Start Guacamole services
docker-compose up -d
sleep 1

docker ps -a
