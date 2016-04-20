if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/lmoments
python setup.py install

