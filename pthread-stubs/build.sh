#!/bin/bash

osname=`uname`
if [ $osname == Linux ]; then
    export CC="gcc -Wl"
    export CXX="g++ -Wl"
elif [ $osname == Darwin ]; then
    export CC="clang"
    export CXX="clang++"
fi

export CFLAGS="-I${PREFIX}/include "${CFLAGS}
export LDFLAGS="-L${PREFIX}/lib "${LDFLAGS}

./configure --prefix=$PREFIX

make -j${CPU_COUNT}
make install
