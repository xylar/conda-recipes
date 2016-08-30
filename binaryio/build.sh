if [ `uname` == Darwin ]; then export LDFLAGS="-lpython" ; fi
cd contrib/binaryio
python setup.py install
if [ `uname` == Darwin ]; then install_name_tool -change /System/Library/Frameworks/Python.framework/Versions/2.7/Python @rpath/libpython2.7.dylib ${SP_DIR}/*.so ; fi
