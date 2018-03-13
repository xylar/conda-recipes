#!/usr/bin/env bash

conda create -y -n cdat-3.0.beta_py2 -c uvcdat/label/v30beta -c anaconda -c conda-forge cdat "python<3"
conda create -y -n cdat-3.0.beta-nox_py2 -c uvcdat/label/v30beta -c anaconda -c conda-forge cdat mesalib "python<3"
conda create -y -n cdat-3.0.beta_py3 -c uvcdat/label/v30beta -c conda-forge -c nesii/label/dev-esmf cdat "python>3"
conda create -y -n cdat-3.0.beta-nox_py3 -c uvcdat/label/v30beta -c conda-forge -c nesii/label/dev-esmf cdat mesalib "python>3"

source activate cdat-3.0.beta_py2
conda env export > cdat-3.0.beta_py2.$(uname).yaml 
source activate cdat-3.0.beta-nox_py2
conda env export > cdat-3.0.beta-nox_py2.$(uname).yaml 
source activate cdat-3.0.beta_py3
conda env export > cdat-3.0.beta_py3.$(uname).yaml 
source activate cdat-3.0.beta-nox_py3
conda env export > cdat-3.0.beta-nox_py3.$(uname).yaml 
