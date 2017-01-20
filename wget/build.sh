#!/bin/bash

export CFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
#export OPENSSL_LIBS="-L${PREFIX}/lib -lssl"
./configure  --prefix=$PREFIX --with-ssl=openssl
make -j4
make install

