if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/asciidata
python setup.py install

