export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
export ESMF_DIR=`pwd`"/esmf"
export ESMP_source="ESMP"
export ESMF_PTHREADS="OFF"
export ESMF_OS=`uname -s`

export ESMF_COMPILER="gfortran"
export ESMF_ABI="64"
if [ `uname` == Darwin ]; then
    export ESMF_OPENMP "OFF"
else
    export ESMF_OPENMP "ON"
fi
export ESMF_INSTALL=${PREFIX}
# ESMF_COMM env variable, choices are openmpi, mpiuni, mpi, mpich2, or mvapich2
ESMF_COMM="mpiuni"

ESMF_MOAB="OFF"
ESMF_ARRAYLITE="TRUE"
cd esmf
make  -j
make install
#${PYTHON} setup.py install
