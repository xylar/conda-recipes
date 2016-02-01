#!/bin/bash

export CFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
./configure  --prefix=$PREFIX --enable-netcdf4
make -j 4
make install

