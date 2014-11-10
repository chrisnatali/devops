Scripts associated with OSM Tile server deployment on Ubuntu 14.04 server

Perform the following tasks to setup a VM or Sandbox:
* vm_tiles is a known host with a blank Ubuntu server installed
* vm_tiles_tiles is a host login as the tiles user with authorized_key access and ssh agent forwarding enabled

1.  Setup server, tiling utils (mainly TileStache) and osm sync utils:
    ssh vm_tiles_tiles bash -s < bootstrap14.sh
   
2.  Setup the postgis DB (called osm_grid owned by tiles user):
    ssh vm_tiles bash -s < setup_postgis14.sh  
    
3.  Import data into your repo:
    - upload gridmaps_pgsql.style to tiles home dir (via scp or similar)
    - login to vm_tiles_tiles
    - Run the following to import an extract (assumes extract.osm.pbf is in HOME dir)
    osm2pgsql --database osm_grid --style gridmaps_pgsql.style --slim extract.osm.pbf --hstore-all --extra-attributes --cache-strategy sparse --cache 1200M

4.  Config and startup apache + TileStache (via mod_wsgi):
    ssh vm_tiles_tiles bash -s < apache_modwsgi.sh

5.  Install and setup tilemill (optional):
    ssh vm_tiles_tiles bash -s < tilemill.sh  
    
    Then copy and edit the config.json file, cd into the tilemill dir and run it on that server via:
    ./index.js --config=config.json    



