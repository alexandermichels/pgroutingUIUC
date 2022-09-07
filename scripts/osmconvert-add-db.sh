#!/bin/bash
PLACE=$OSM_PLACE
BBOX=$OSM_BBOX
EXTRACT_TO="extracted.osm"
cd /data
# drop unnecessary metadata
# see: https://github.com/pgRouting/osm2pgrouting/issues/221
osmconvert ${PLACE}-latest.osm.pbf --drop-author --drop-version --out-osm -o=${PLACE}.osm
# osmium extract --bbox LEFT,BOTTOM,RIGHT,TOP [OPTIONS] OSM-FILE
# see: https://docs.osmcode.org/osmium/latest/osmium-extract.html
osmium extract --overwrite --bbox $BBOX ${PLACE}.osm -o ${EXTRACT_TO}

/usr/bin/osm2pgrouting \
  -f  ${EXTRACT_TO} \
  -c "/usr/share/osm2pgrouting/mapconfig.xml" \
  -d $POSTGRES_DB \
  -U $POSTGRES_USER \
  -W $POSTGRES_PASSWORD \
  --clean

# because it will cause errors when re-launching
chmod -R 777 /data