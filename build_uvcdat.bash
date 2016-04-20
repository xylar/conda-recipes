#!/usr/bin/env bash
./build_uvcdat_externals.bash
conda build libcdms
conda build cdat_info
conda build distarray
conda build regrid2
conda build cdms2
conda build cdtime
conda build cdutil
conda build udunits2
conda build unidata
conda build genutil
conda build dv3d
conda build vcs
conda build vcsaddons
conda build thermo
conda build wk
conda build pydebug
conda build uvcmetrics
conda build vistrails
conda build xmgrace
conda build esg
./build_uvcdat_contrib.bash
