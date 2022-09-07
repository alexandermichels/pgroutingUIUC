#!/bin/bash
docker-compose up --build -d
docker-compose exec pgr scripts/osmconvert-add-db.sh