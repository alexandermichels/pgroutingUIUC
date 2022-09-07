FROM pgrouting/pgrouting:12-3.0-3.0.1

RUN apt update && apt install --fix-missing -y --no-install-recommends \
  bzip2 \
  osm2pgrouting \
  osmctools \
  osmium-tool