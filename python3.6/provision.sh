#!/bin/sh

set -e # fail on any error


# Versions
# ===================================================================
GEOS_VERSION=3.6.1
PROJ_VERSION=4.9.3
PROJ_DATUMGRID_VERSION=1.6
GDAL_VERSION=2.3.1


# Install libraries
# ===================================================================
apk add --no-cache linux-headers build-base


# Install geos
# ===================================================================
cd /tmp
wget http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2
tar xjf geos-${GEOS_VERSION}.tar.bz2
cd geos-${GEOS_VERSION}
./configure --enable-silent-rules CFLAGS="-D__sun -D__GNUC__"  CXXFLAGS="-D__GNUC___ -D__sun"
make -s
make -s install


# Install proj
# ===================================================================
cd /tmp
wget http://download.osgeo.org/proj/proj-${PROJ_VERSION}.tar.gz
wget http://download.osgeo.org/proj/proj-datumgrid-${PROJ_DATUMGRID_VERSION}.zip
tar xzf proj-${PROJ_VERSION}.tar.gz
cd proj-${PROJ_VERSION}/nad
unzip ../../proj-datumgrid-${PROJ_DATUMGRID_VERSION}.zip
cd ..
./configure --enable-silent-rules
make -s
make -s install


# Install gdal
# ===================================================================
cd /tmp
wget http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz
tar xzf gdal-${GDAL_VERSION}.tar.gz
cd gdal-${GDAL_VERSION}
./configure --enable-silent-rules --with-static-proj4=/usr/local/lib --with-python
make -s
make -s install


# Clean up
# ===================================================================
rm -rf /tmp/*
rm -rf /root/.cache
