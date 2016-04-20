if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/binaryio
python setup.py install

