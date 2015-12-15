#!/usr/bin/env bash

USER=main

/etc/init.d/postgresql start

for n in /home/$USER/notebooks/data/natural_earth2/*.shp;
do
  shp2pgsql -W LATIN1 -s 4326 -I -g the_geom "$n" | \
     psql --quiet natural_earth2
done

psql natural_earth2 --quiet -c "vacuum analyze"

psql main -c 'create extension postgis;'
psql main \
  -f /usr/share/postgresql/9.4/contrib/postgis-2.1/legacy.sql   
