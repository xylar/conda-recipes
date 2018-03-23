#!/usr/bin/env bash

export RELEASE="v80"

conda create -y -n cdat-${RELEASE}_py2 -c cdat/label/${RELEASE} -c nesii/label/dev-esmf -c conda-forge cdat "python<3"
source activate cdat-${RELEASE}_py2
conda env export > cdat-${RELEASE}_py2.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py2 -c cdat/label/${RELEASE} -c nesii/label/dev-esmf -c conda-forge cdat mesalib "python<3"
source activate cdat-${RELEASE}-nox_py2
conda env export > cdat-${RELEASE}-nox_py2.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}_py3 -c cdat/label/${RELEASE} -c nesii/label/dev-esmf -c conda-forge cdat "python>3"
source activate cdat-${RELEASE}_py3
conda env export > cdat-${RELEASE}_py3.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py3 -c cdat/label/${RELEASE} -c nesii/label/dev-esmf -c conda-forge cdat mesalib "python>3"
source activate cdat-${RELEASE}-nox_py3
conda env export > cdat-${RELEASE}-nox_py3.$(uname).yaml 
