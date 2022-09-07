#!/bin/bash
# Builds/brings up the container and runs the osmconvert-add-db.sh script
docker-compose up --build -d
docker-compose exec pgr scripts/osmconvert-add-db.sh