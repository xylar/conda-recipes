#!/bin/bash -x

# Try to locate local stdc++ as VTK relies on local drivers built vs latest stdc++

STDCPLUSPLUS=$(/sbin/ldconfig -p | grep stdc++ | head -n 1 | awk '{ print $NF }')

if [ -z "${LD_PRELOAD}" ]; then
    export LD_PRELOAD=${STDCPLUSPLUS}
else
    export LD_PRELOAD_SAVED_ANACONDA=${LD_PRELOAD}
    export LD_PRELOAD=${STDCPLUSPLUS}:${LD_PRELOAD_SAVED_ANACONDA}
fi


