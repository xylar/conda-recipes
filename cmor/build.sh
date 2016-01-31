#!/bin/bash

export CFLAGS="-I/home/dnadeau/anaconda2/include -I/home/dnadeau/anaconda2/include/json-c"
export LDFLAGS="-L/home/dnadeau/anaconda2/lib"


./configure \
    --with-python=$PREFIX \
    --with-netcdf=$PREFIX \
    --with-uuid=$PREFIX \
    --with-json-c=$PREFIX \
    --with-udunits2=$PREFIX \
    --prefix=$PREFIX
make
make install

#ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
#DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
#mkdir -p $ACTIVATE_DIR
#mkdir -p $DEACTIVATE_DIR

#cp $RECIPE_DIR/posix/activate.sh $ACTIVATE_DIR/cmor-activate.sh
#cp $RECIPE_DIR/posix/deactivate.sh $DEACTIVATE_DIR/cmor-deactivate.sh
