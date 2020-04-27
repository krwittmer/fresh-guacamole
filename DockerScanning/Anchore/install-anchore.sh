#!/bin/sh

docker pull docker.io/anchore/anchore-engine:latest
docker images

mkdir ~/ae-volume
cd ae-volume/
ls

docker create --name ae docker.io/anchore/anchore-engine:latest
docker cp ae:/docker-compose.yaml ~/ae-volume/docker-compose.yaml
ls
vim docker-compose.yaml

docker-compose pull
docker-compose up -d
docker-compose ps

python --version
apt-get install python-pip
pip install anchorecli
