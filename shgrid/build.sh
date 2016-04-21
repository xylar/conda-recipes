if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/shgrid
python setup.py install

