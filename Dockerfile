FROM andrewosh/binder-base

USER root

RUN apt-get update -q > /dev/null 2>&1
RUN apt-get install -yq postgis \
                       postgresql-contrib \
                       postgresql-9.4 \
                       postgresql-client-9.4 \
                       postgresql-contrib-9.4 \
                       postgresql-9.4-postgis-2.1 \
                       ossim-core grass-core > /dev/null 2>&1

RUN echo "root:root" | chpasswd
RUN echo "main:main" | chpasswd

ADD pgstart.sh /usr/local/bin/pgstart.sh

USER main

#RUN conda update conda > /dev/null 2>&1
#RUN conda install anaconda=2.4.1 > /dev/null 2>&1

# install demo support
RUN conda install \
    ipywidgets \
    numpy > /dev/null 2>&1

RUN pip install \
    czml \
    geocoder > /dev/null 2>&1

RUN /home/main/anaconda/envs/python3/bin/pip install --upgrade pip
RUN /home/main/anaconda/envs/python3/bin/pip install \
    czml \
    geocoder \
    ipywidgets > /dev/null 2>&1


#RUN git clone https://github.com/epifanio/CesiumWidget.git --depth=1
RUN git clone  https://github.com/OSGeo-live/CesiumWidget --depth=1


WORKDIR CesiumWidget

RUN python setup.py install > /dev/null 2>&1
RUN /home/main/anaconda/envs/python3/bin/python setup.py install > /dev/null 2>&1

# jupyter-pip so crazy. this is cheating, as a real user wouldn't have
# the source checked out...
RUN jupyter nbextension install CesiumWidget/static/CesiumWidget --user --quiet > /dev/null 2>&1

#ADD install_cesiumwidget.sh /tmp/install_cesiumwidget.sh
#RUN /tmp/install_cesiumwidget.sh

ADD condalist.txt /tmp/condalist.txt
RUN conda install -y --file /tmp/condalist.txt > /dev/null 2>&1
RUN conda install -y -n python3 --file /tmp/condalist.txt > /dev/null 2>&1


ADD condalist-IOOS.txt /tmp/condalist-IOOS.txt
RUN conda install -y -c IOOS --file /tmp/condalist-IOOS.txt > /dev/null 2>&1
RUN conda install -y -c IOOS -n python3 --file /tmp/condalist-IOOS.txt > /dev/null 2>&1

COPY GSOC /home/main/notebooks/GSOC

USER root
ADD getdata.sh /tmp/getdata.sh
RUN /tmp/getdata.sh
RUN chown -R main /home/main/notebooks/
RUN chmod -R 777 /home/main/notebooks/

## setup postgresql
USER postgres
#
## start db and make new user and db (osgeo) listening from all host
RUN /etc/init.d/postgresql start &&\
    /usr/bin/psql --command "CREATE USER main WITH SUPERUSER PASSWORD 'main';" &&\
    /usr/bin/createdb -O main main &&\
    /usr/bin/createdb natural_earth2 &&\
    /usr/bin/psql natural_earth2 -c 'create extension postgis;' &&\
    /usr/bin/psql natural_earth2 -f /usr/share/postgresql/9.4/contrib/postgis-2.1/legacy.sql

## add naturalhear data into postgis
ADD naturalearth.sh /tmp/naturalearth.sh
RUN /tmp/naturalearth.sh
#
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf
#
#EXPOSE 5432