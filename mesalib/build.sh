#!/bin/bash

export CFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
./configure  --prefix=$PREFIX --with-driver=osmesa --disable-gallium --disable-gallium-intel --disable-egl
make
make install

