if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/ZonalMeans
python setup.py install

