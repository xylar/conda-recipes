#!/usr/bin/env bash

export RELEASE="v81"
export PREPEND_CHANNEL="-c cdat/label/test"
export PREPEND_CHANNEL=""
export APPEND_CHANNEL=""

conda deactivate
conda activate base

for PYVER in 2.7 3.6 3.7
    do
        echo "Doing version $PYVER"
        conda create -y -n cdat-${RELEASE}_py$PYVER ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat python=$PYVER
        conda activate cdat-${RELEASE}_py$PYVER
        conda env export --no-builds > cdat-${RELEASE}_py$PYVER.$(uname).yaml 
        conda deactivate
        conda activate base
    done

