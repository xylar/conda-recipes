#!/bin/bash

mkdir build
cd build

CONDA_LST=`conda list`
OSNAME=`uname`

pkgs=(ComparisonStatistics  HDF5Tools  MSU   ZonalMeans  binaryio  dsgrid  eof  lmoments  ort    shgrid   spherepack  SP   asciidata   cssgrid  natgrid  regridpack trends )

for p in ${pkgs[*]}
do
    cd contrib/$p
    python setup.py install
    if [ `uname` == Darwin ]; then install_name_tool -change /System/Library/Frameworks/Python.framework/Versions/2.7/Python @rpath/libpython2.7.dylib ${SP_DIR}/*.so ; fi
    cd ../..
done

