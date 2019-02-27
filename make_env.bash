#!/usr/bin/env bash

export RELEASE="v81"
export PREPEND_CHANNEL="-c cdat/label/test"
export PREPEND_CHANNEL=""
export APPEND_CHANNEL=""

source activate 

for PYVER in 2.7 3.6 3.7
    do
        echo "Doing version $PYVER"
        conda create -y -n cdat-${RELEASE}_py$PYVER ${PREPEND_CHANNEL} -c cdat/label/${RELEASE} -c conda-forge ${APPEND_CHANNEL} cdat python=$PYVER
        source activate cdat-${RELEASE}_py$PYVER
        conda env export > cdat-${RELEASE}_py$PYVER.$(uname).yaml 
        source deactivate
        source activate base
    done

