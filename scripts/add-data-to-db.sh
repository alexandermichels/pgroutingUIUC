#!/bin/bash
# original script, deprecated
PLACE="vermont"
cd /data
bzcat ${PLACE}-latest.osm.bz2 > ${PLACE}.osm
/usr/bin/osm2pgrouting \
  -f "${PLACE}.osm" \
  -c "/usr/share/osm2pgrouting/mapconfig.xml" \
  -d test \
  -U test \
  -W test \
  --clean