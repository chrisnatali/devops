Scripts associated with OSM RailsPort deployment on Ubuntu 14.04 server

Perform the following tasks to setup a VM or Sandbox:
* vm_osm is a known host with a blank Ubuntu server installed
* vm_osm_osm is a host login as the osm user with authorized_key access and ssh agent forwarding enabled

1.  Setup server and osm prereqs:
    ssh vm_osm bash -s < bootstrap14.sh
   
2.  Setup postgres:
    ssh vm_osm bash -s < osm_postgres.sh  
    
3.  Get the openstreetmap-website src fork from SEL github repo:
    (may need to ssh in and do ssh -T git@github.com to allow clone via git protocol)
    ssh vm_osm_osm bash -s < osm_site_setup.sh

4.  Update configuration (config/application.yml) with appropriate ip address, mail server...

5.  Setup the db, gems and run tests for openstreetmap-website:
    ssh vm_osm_osm OSM_PWD=<osm_db_user_pwd> bash -s < osm_post_site_setup.sh 

6.  For prod, setup apache + passenger, precompile rails assets ('asset pipeline') and start serving
    ssh vm_osm_osm bash -s < apache_passenger.sh
    Then modify /etc/apache2/sites-available/osm.conf with appropriate ServerName value

7.  For setting up cgimap (for faster map api calls):
    ssh vm_osm_osm bash -s < osm_cgimap.sh
    
    You will then need to configure lighttpd, etc  
    See the following github repo for more:
    https://github.com/zerebubuth/openstreetmap-cgimap
