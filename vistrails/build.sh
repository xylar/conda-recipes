#!/bin/env bash
export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

mkdir ${PREFIX}/vistrails
cp -rf * ${PREFIX}/vistrails

mkdir ${PREFIX}/bin
sed "s#CONDAPREFIX#${PREFIX}#g;" scripts/uvcdat_for_conda.in > ${PREFIX}/bin/uvcdat
chmod ugo+x ${PREFIX}/bin/uvcdat
