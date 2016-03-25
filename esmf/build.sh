export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

./configure --prefix=${PREFIX}
#make  -j${CPU_COUNT}
#make install
${PYTHON} setup.py install
