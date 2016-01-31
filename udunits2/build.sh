#!/bin/bash

# http://www.michael-joost.de/gdal_install.html
unset CC CPP CXX


sh configure  --prefix=$PREFIX

make
make install

#ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
#DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
#mkdir -p $ACTIVATE_DIR
#mkdir -p $DEACTIVATE_DIR

#cp $RECIPE_DIR/posix/activate.sh $ACTIVATE_DIR/cmor-activate.sh
#cp $RECIPE_DIR/posix/deactivate.sh $DEACTIVATE_DIR/cmor-deactivate.sh
