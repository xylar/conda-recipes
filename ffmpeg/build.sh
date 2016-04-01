#!/bin/bash

export CFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
./configure  --prefix=$PREFIX --enable-shared --enable-gpl --enable-libx264 --enable-zlib
make -j4
make install

