#!/usr/bin/env bash

export RELEASE="3.0.beta2"

conda create -y -n cdat-${RELEASE}_py2 -c cdat/label/nightly -c nesii/label/dev-esmf -c conda-forge -c uvcdat cdat "python<3"
source activate cdat-${RELEASE}_py2
conda env export > cdat-3.0.beta_py2.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py2 -c cdat/label/nightly -c nesii/label/dev-esmf -c conda-forge -c uvcdat cdat mesalib "python<3"
source activate cdat-${RELEASE}-nox_py2
conda env export > cdat-3.0.beta-nox_py2.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}_py3 -c cdat/label/nightly -c nesii/label/dev-esmf -c conda-forge -c uvcdat cdat "python>3"
source activate cdat-${RELEASE}_py3
conda env export > cdat-${RELEASE}_py3.$(uname).yaml 

source deactivate
source activate base

conda create -y -n cdat-${RELEASE}-nox_py3 -c cdat/label/nightly -c nesii/label/dev-esmf -c conda-forge -c uvcdat cdat mesalib "python>3"
source activate cdat-3.0.beta-nox_py3
conda env export > cdat-${RELEASE}-nox_py3.$(uname).yaml 
