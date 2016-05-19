#!/bin/bash

export CFLAGS="-I${PREFIX}/include -fPIC -w"
export CXXFLAGS="-I${PREFIX}/include -fPIC -w"
export CPPFLAGS="-I${PREFIX}/include -fPIC -w"
export LDFLAGS="-L${PREFIX}/lib"
export LC_RPATH="${PREFIX}/lib"

./configure  --prefix=$PREFIX 
make -j 8
make install

