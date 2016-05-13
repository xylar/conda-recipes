export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
export LFLAGS="-fPIC"
export CC=mpicc
export CXX=mpicxx
export LC_RPATH="${PREFIX}/lib"
export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib

${PYTHON} setup.py install
