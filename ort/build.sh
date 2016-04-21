if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/ort
python setup.py install

