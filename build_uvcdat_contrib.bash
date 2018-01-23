#!/usr/bin/env bash
conda build hdf5tools -c conda-forge
conda build asciidata -c conda-forge
#conda build binaryio -c conda-forge --numpy=1.11
conda build cssgrid -c conda-forge --numpy=1.11
conda build dsgrid -c conda-forge --numpy=1.11
conda build lmoments -c conda-forge --numpy=1.11
conda build natgrid -c conda-forge --numpy=1.11
#conda build ort -c conda-forge --numpy=1.11
#conda build regridpack -c conda-forge --numpy=1.11
conda build shgrid -c conda-forge --numpy=1.11
conda build trends -c conda-forge --numpy=1.11
conda build spherepack -c conda-forge --numpy=1.11
conda build zonalmeans -c conda-forge --numpy=1.11
#conda build binaryio -c conda-forge --numpy=1.12
conda build cssgrid -c conda-forge --numpy=1.12
conda build dsgrid -c conda-forge --numpy=1.12
conda build lmoments -c conda-forge --numpy=1.12
conda build natgrid -c conda-forge --numpy=1.12
#conda build ort -c conda-forge --numpy=1.12
#conda build regridpack -c conda-forge --numpy=1.12
conda build shgrid -c conda-forge --numpy=1.12
conda build trends -c conda-forge --numpy=1.12
conda build spherepack -c conda-forge --numpy=1.12
conda build zonalmeans -c conda-forge --numpy=1.12
#conda build binaryio -c conda-forge --numpy=1.13
conda build cssgrid -c conda-forge --numpy=1.13
conda build dsgrid -c conda-forge --numpy=1.13
conda build lmoments -c conda-forge --numpy=1.13
conda build natgrid -c conda-forge --numpy=1.13
#conda build ort -c conda-forge --numpy=1.13
#conda build regridpack -c conda-forge --numpy=1.13
conda build shgrid -c conda-forge --numpy=1.13
conda build trends -c conda-forge --numpy=1.13
conda build spherepack -c conda-forge --numpy=1.13
conda build zonalmeans -c conda-forge --numpy=1.13
