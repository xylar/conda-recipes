#!/usr/bin/env bash
conda build hdf5
#conda build proj4
conda build libnetcdf
#conda build lapack
conda build clapack -c conda-forge
conda build ossuuid -c conda-forge
conda build gfortran -c conda-forge
conda build libcf -c conda-forge
conda build esmf --with-numpy ['1.9', '1.10', '1.11'] -c conda-forge
conda build jasper -c conda-forge
conda build g2clib -c conda-forge
conda build yasm -c conda-forge
conda build x264 -c conda-forge
conda build ffmpeg -c conda-forge
conda build cmor --with-numpy ['1.9', '1.10', '1.11'] -c conda-forge
conda build vtk -c conda-forge
conda build libdrs_c -c conda-forge
conda build libcdms -c conda-forge
conda build libdrs_f -c conda-forge
conda build lats -c conda-forge
conda build ezget -c conda-forge
conda build cd77 -c conda-forge
