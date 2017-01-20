#export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
#export CXXLAGS="${CFLAGS}"
#export CPPFLAGS="-I${PREFIX}/include"
#export LDFLAGS="-L${PREFIX}/lib"

mkdir SphPack
cd SphPack
curl -o spherepack3.2.tar http://uvcdat.llnl.gov/cdat/resources/spherepack3.2.tar
tar xvf spherepack3.2.tar
cp spherepack3.2/src/*.f ../src
cd ..
python setup.py install
