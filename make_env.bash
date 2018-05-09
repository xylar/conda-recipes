#!/usr/bin/env bash

export RELEASE="v80"
export PREPEND_CHANNEL="-c cdat/label/test"
export APPEND_CHANNEL=""

source activate 

#conda create -y -n cdat-${RELEASE}_py2 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat "python<3"
source activate cdat-${RELEASE}_py2
conda env export > cdat-${RELEASE}_py2.$(uname).yaml 

source deactivate
source activate base

#conda create -y -n cdat-${RELEASE}-nox_py2 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat mesalib "python<3"
source activate cdat-${RELEASE}-nox_py2
conda env export > cdat-${RELEASE}-nox_py2.$(uname).yaml 

source deactivate
source activate base

#conda create -y -n cdat-${RELEASE}_py3 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat "python>3"
source activate cdat-${RELEASE}_py3
conda env export > cdat-${RELEASE}_py3.$(uname).yaml 

source deactivate
source activate base

#conda create -y -n cdat-${RELEASE}-nox_py3 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat mesalib "python>3"
source activate cdat-${RELEASE}-nox_py3
conda env export > cdat-${RELEASE}-nox_py3.$(uname).yaml 
