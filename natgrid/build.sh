if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/natgrid
python setup.py install

