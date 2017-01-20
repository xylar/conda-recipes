if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/dsgrid
python setup.py install

