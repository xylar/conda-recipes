export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

#if [ `uname` == Linux ]; then
#    # To make sure we get the correct g++
#    export LD_LIBRARY_PATH=${PREFIX}/lib:${LIBRARY_PATH}
#    export CC="gcc -Wl,-rpath=${PREFIX}/lib"
#    export CXX="g++ -Wl,-rpath=${PREFIX}/lib"
#else
#    export CC="gcc"
#    export CXX="g++"
#fi

if [ $(uname) == "Linux" ];then
    export LDSHARED="$CC -shared -pthread"
    LDSHARED="$CC -shared -pthread" python setup.py install
else
    python setup.py install
fi

