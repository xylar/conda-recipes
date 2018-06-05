#source activate "${CONDA_DEFAULT_ENV}"
export CFLAGS="-Wall -m64 -pipe -O2  -fPIC ${CFLAGS}"
export CXXFLAGS="${CFLAGS} ${CXXFLAGS}"
export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"
export LFLAGS="-fPIC ${LFLAGS}"
export FC=""
export LDSHARED="$CC -shared -pthread" 
./configure --prefix=${PREFIX}
make 
make install
${PYTHON} setup.py install

