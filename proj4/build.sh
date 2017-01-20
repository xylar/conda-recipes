#!/bin/bash

export CFLAGS="-I${PREFIX}/include -fPIC -w"
export CXXFLAGS="-I${PREFIX}/include -fPIC -w"
export CPPFLAGS="-I${PREFIX}/include -fPIC -w"
export LDFLAGS="-L${PREFIX}/lib"

export CONDA_LST=`conda list`
if [[ ${CONDA_LST}'y' == *'openmpi'* ]]; then
    export CC=mpicc
    export CXX=mpicxx
    export LC_RPATH="${PREFIX}/lib"
    export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib
fi

./configure  --prefix=$PREFIX
make -j 8
make install

