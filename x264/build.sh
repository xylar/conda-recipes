#!/bin/bash

export CFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
./configure  --prefix=$PREFIX --enable-shared
make -j4
make install

