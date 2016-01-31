#!/bin/bash

export CFLAGS="-I/home/dnadeau/anaconda2/include"
export LDFLAGS="-L/home/dnadeau/anaconda2/lib"
./configure  --prefix=$PREFIX
make
make install

