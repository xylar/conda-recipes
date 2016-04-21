if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/trends
python setup.py install

