#!/bin/bash

CONDA_LST=`conda list`
if [[ ${CONDA_LST}'y' == *'openmpi'* ]]; then
    MPI_ARG="--enable-parallel"
else:
    MPI_ARG=""

./configure  --prefix=$PREFIX -fPIC -w ${MPI_ARG}
make -j 8
make install

