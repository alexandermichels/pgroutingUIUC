
## pgroutingUIUC

**Author:** Alexander Michels

Work is based on this [FOSS4G Workshop](https://workshop.pgrouting.org/2.7/en/index.html)

## Steps:

0. Download the data because it doesn't fit in Github. You can use the script `data/download_data.sh` or simply download some state from here: https://download.geofabrik.de/north-america/us.html The notebooks assume you will use Illinois.


1. From the repo run:

```
> bash up.sh
```

<details>
    <summary>Click here to see the expected output from `bash up.sh`</summary>

```bash
Building pgr
Step 1/2 : FROM pgrouting/pgrouting:12-3.0-3.0.1
 ---> de07041c0250
Step 2/2 : RUN apt update && apt install --fix-missing -y --no-install-recommends   bzip2   osm2pgrouting   osmctools   osmium-tool
 ---> Using cache
 ---> a0ffd185a0f2
Successfully built a0ffd185a0f2
Successfully tagged pgroutinguiuc_pgr:latest
Creating pgroutinguiuc_pgr_1 ... done
Execution starts at: Thu Sep  8 16:03:38 2022

***************************************************
           COMMAND LINE CONFIGURATION             *
***************************************************
Filename = illinois-extracted.osm
Configuration file = /usr/share/osm2pgrouting/mapconfig.xml
host = localhost
port = 5432
dbname = routing
username = alex
schema= 
prefix = 
suffix = 
Drop tables
Don't create indexes
Don't add OSM nodes
***************************************************
Testing database connection: routing
database connection successful: routing
Connecting to the database
connection success

Dropping tables...
TABLE: ways dropped ... OK.
TABLE: ways_vertices_pgr dropped ... OK.
TABLE: pointsofinterest dropped ... OK.
TABLE: configuration dropped ... OK.
TABLE: osm_nodes dropped ... OK.
TABLE: osm_ways dropped ... OK.
TABLE: osm_relations dropped ... OK.

Creating tables...
TABLE: ways_vertices_pgr created ... OK.
TABLE: ways created ... OK.
TABLE: pointsofinterest created ... OK.
TABLE: configuration created ... OK.
Opening configuration file: /usr/share/osm2pgrouting/mapconfig.xml
    Parsing configuration

Exporting configuration ...
  - Done 
Counting lines ...
  - Done 
Opening data file: illinois-extracted.osm	total lines: 1156418
    Parsing data


End Of file


    Finish Parsing data

Adding auxiliary tables to database...

Export Ways ...
    Processing 53109 ways:
[******************|                                ] (37%) Total processed: 20000	 Vertices inserted: 36305	Split ways inserted 44994
[*************************************|             ] (75%) Total processed: 40000	 Vertices inserted: 17184	Split ways inserted 29033
[**************************************************|] (100%) Total processed: 53109	 Vertices inserted: 705	Split ways inserted 2327

Creating indexes ...

Processing Points of Interest ...
#########################
size of streets: 53109
Execution started at: Thu Sep  8 16:03:38 2022
Execution ended at:   Thu Sep  8 16:04:04 2022
Elapsed time: 25.837 Seconds.
User CPU time: -> 5.03359 seconds
#########################
```

</details>

<br />

to bring up your database. This builds the Dockerfile, strips metadata from the .pbf file, extracts just a bounding box, and then adds the data to a PostgreSQL database. You can control some aspects of this by altering the variables under "environment" in the docker-compose.yml. The variables are:

- POSTGRES_USER=root  # should be user in container
- POSTGRES_PASSWORD=cybergis  # also doesn't matter, just password
- POSTGRES_DB=routing  # also doesn't matter, just name of database
- OSM_PLACE=illinois  # the file in ./data (${OSM_PLACE}-latest.osm.pbf)
- OSM_BBOX=-88.34,40.05,-88.14,40.18  # bounding box to extract from the file

The notebooks assume the variables above, so change at your own risk. If you choose another location you will need to figure out your own bounding box and OSMids to route between. If you change the database name/username/password that is easier to change, just change it in the cell at the top of the notebook that connects to the postgresql server.

This step takes a while (a few minutes).

2. Run the notebooks! **It is recommended that you run these notebooks sequentially because some notebooks create views/functions that are used in other later notebooks.

* [notebooks/01_Simple_Routing_and_Viz.ipynb](notebooks/01_Simple_Routing_and_Viz.ipynb) - Simple pedestrian routing and visualization.
* [notebooks/02_Vehicle_Routing.ipynb](notebooks/02_Vehicle_Routing.ipynb) - More complex routing on a vehicle network and routing between lat/lon pairs.
* [notebooks/03_Functions_and_Multiple_Routing.ipynb](notebooks/03_Functions_and_Multiple_Routing.ipynb) - Using functions, calculating costs, and routing between multiple origin-destination pairs.

Presentation notebooks (used for GGIS 407 project)

* [pres/ProjectProposalSlides.ipynb](pres/ProjectProposalSlides.ipynb) - a RISE slides presentation of the project for GGIS 407 @ UIUC



## Debugging

Some of the information (especially "NOTICE" output from pgr) isn't veiwable from the notebook and you'll have to go into the container. To enter the container, run `docker-compose exec pgr bash` from the repository root. This opens a terminal in the container. To access the database, run `psql routing`.