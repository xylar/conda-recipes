#!/usr/bin/env bash

export RELEASE="v81"
export PREPEND_CHANNEL="-c cdat/label/test"
export PREPEND_CHANNEL=""
export APPEND_CHANNEL=""

source activate 

conda create -y -n cdat-${RELEASE}_py27 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat "python<3"
source activate cdat-${RELEASE}_py27
conda env export > cdat-${RELEASE}_py27.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py27 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat mesalib "python<3"
source activate cdat-${RELEASE}-nox_py27
conda env export > cdat-${RELEASE}-nox_py27.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}_py36 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat "python=3.6"
source activate cdat-${RELEASE}_py36
conda env export > cdat-${RELEASE}_py36.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py36 ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat mesalib "python=3.6"
source activate cdat-${RELEASE}-nox_py36
conda env export > cdat-${RELEASE}-nox_py36.$(uname).yaml 
