#!/usr/bin/env bash
if [ $2"-" == "FULL-" ]; then ./build_uvcdat_externals.bash ; fi
conda build -c conda-forge cdat_info
conda build -c conda-forge distarray
conda build -c conda-forge cdms2
conda build -c conda-forge cdtime
conda build -c conda-forge cdutil
conda build -c conda-forge unidata
conda build -c conda-forge genutil
conda build -c conda-forge dv3d
conda build -c conda-forge vcs
conda build -c conda-forge vcsaddons
conda build -c conda-forge thermo
conda build -c conda-forge wk
#conda build -c conda-forge pydebug
conda build -c conda-forge uvcmetrics
conda build -c conda-forge vistrails
conda build -c conda-forge xmgrace
if [ $1"-" == "FULL-" ]; then ./build_uvcdat_contrib.bash ; fi
