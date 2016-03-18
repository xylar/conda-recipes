export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export FFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

cmake . -DCMAKE_INSTALL_PREFIX=${PREFIX}
make  -j${CPU_COUNT}
make install
