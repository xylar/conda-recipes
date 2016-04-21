if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/spherepack
python setup.py install

