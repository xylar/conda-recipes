if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/HDF5Tools
python setup.py install

