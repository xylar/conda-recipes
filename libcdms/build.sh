export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

./configure \
    --enable-dap= \
    --enable-drs=no \
    --enable-hdf=no \
    --enable-pp=yes \
    --enable-ql=no \
    --cache-file=/dev/null \
    --with-nclib=${PREFIX}/lib \
    --with-ncinc=${PREFIX}/include \
    --with-daplib=/lib \
    --with-dapinc=/include \
    --with-hdfinc=./include \
    --with-hdflib=./lib \
    --with-hdf5lib=${PREFIX}/lib \
    --with-pnglib=/usr/X11/lib \
    --with-grib2lib=${PREFIX}/lib \
    --with-jasperlib=${PREFIX}/lib \
    --with-grib2inc=${PREFIX}/include \
    --enable-grib2 \
    --prefix=${PREFIX}
make 
make libinstall
make bininstall
