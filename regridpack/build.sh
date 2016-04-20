if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/regridpack
python setup.py install

