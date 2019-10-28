#!/usr/bin/env bash

export RELEASE="v82"
export ACTIVATE_COMMAND="source"

echo "ACTIVATE COMMAND: ${ACTIVATE_COMMAND}"

${ACTIVATE_COMMAND} deactivate
${ACTIVATE_COMMAND} activate base

for PYVER in 2.7 3.6 3.7
    do
        for MESA in y n
        do
            if [ $MESA == "y" ]; then
                export MESA_NAME="-nox"
                export MESA_PKG="mesalib"
            else
                export MESA_NAME=""
                export MESA_PKG=""
            fi
            echo "Doing version $PYVER with mesalib set to $MESA"
            conda env create -n cdat-${RELEASE}${MESA_NAME}_py$PYVER -f cdat-${RELEASE}${MESA_NAME}_py$PYVER.$(uname).yaml
	    echo "conda env create -n cdat-${RELEASE}${MESA_NAME}_py$PYVER -f cdat-${RELEASE}${MESA_NAME}_py$PYVER.$(uname).yaml"
            ${ACTIVATE_COMMAND} deactivate
            ${ACTIVATE_COMMAND} activate base
        done
    done

