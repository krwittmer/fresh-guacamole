#!/bin/sh
docker-compose up -d
sleep 1
docker ps -a
