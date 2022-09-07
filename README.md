

Work is based on this [FOSS4G Workshop](https://workshop.pgrouting.org/2.7/en/index.html)

## Steps:

0. Download the data because it doesn't fit in Github. You can use the script `data/download_data.sh` or simply download some state from here: https://download.geofabrik.de/north-america/us.html The notebooks assume you will use Illinois.


1. From the repo run:

```
> bash up.sh
```

to bring up your database. This builds the Dockerfile, strips metadata from the .pbf file, extracts just a bounding box, and then adds the data to a PostgreSQL database. You can control some aspects of this by altering the variables under "environment" in the docker-compose.yml. The variables are:

- POSTGRES_USER=alex  # doesn't matter, just a username
- POSTGRES_PASSWORD=cybergis  # also doesn't matter, just password
- POSTGRES_DB=routing  # also doesn't matter, just name of database
- OSM_PLACE=illinois  # the file in ./data (${OSM_PLACE}-latest.osm.pbf)
- OSM_BBOX=-88.34,40.05,-88.14,40.18  # bounding box to extract from the file

The notebooks assume the variables above, so change at your own risk.

This step takes a while (a few minutes).

2. Run the notebooks!