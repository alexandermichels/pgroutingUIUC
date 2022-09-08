#!/bin/bash
# Builds/brings up the container and runs the osmconvert-add-db.sh script
docker-compose up --build -d
sleep 10  # wait a few seoncds for the database to startup
docker-compose exec pgr scripts/osmconvert-add-db.sh