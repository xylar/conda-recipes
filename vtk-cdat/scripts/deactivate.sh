#!/bin/bash -x

if [ -z "${LD_PRELOAD_SAVED_ANACONDA}" ]; then
    unset LD_PRELOAD
else
    export LD_PRELOAD=${LD_PRELOAD_SAVED_ANACONDA}
    unset LD_PRELOAD_SAVED_ANACONDA
fi
