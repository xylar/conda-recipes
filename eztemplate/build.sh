if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/EzTemplate
python setup.py install

