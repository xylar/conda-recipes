if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/cssgrid
python setup.py install

