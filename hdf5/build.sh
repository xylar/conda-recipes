#!/bin/bash

export CFLAGS="-I${PREFIX}/include -fPIC -w"
export CXXFLAGS="-I${PREFIX}/include -fPIC -w"
export CPPFLAGS="-I${PREFIX}/include -fPIC -w"
export LDFLAGS="-L${PREFIX}/lib"

CONDA_LST=`conda list`
if [[ ${CONDA_LST}'y' == *'openmpi'* ]]; then
    MPI_ARG="--enable-parallel"
    export CC=mpicc
    export CXX=mpicxx
    export LC_RPATH="${PREFIX}/lib"
    export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib
else
    MPI_ARG=""
fi

./configure  --prefix=$PREFIX ${MPI_ARG}
make -j 8
make install

