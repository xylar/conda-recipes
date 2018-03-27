#!/usr/bin/env bash
if [ $2"-" == "FULL-" ]; then ./build_uvcdat_externals.bash ; fi
#conda build -c conda-forge cdat_info
#conda build -c conda-forge distarray
#conda build -c conda-forge cdtime --numpy=1.11
#conda build -c conda-forge cdtime --numpy=1.10
#conda build -c conda-forge cdtime --numpy=1.9
#conda build -c conda-forge cdms2 --numpy=1.11
#conda build -c conda-forge cdms2 --numpy=1.10
#conda build -c conda-forge cdms2 --numpy=1.9
#conda build -c conda-forge genutil --numpy=1.11
#conda build -c conda-forge genutil --numpy=1.10
#conda build -c conda-forge genutil --numpy=1.9
#conda build -c conda-forge cdutil
conda build -c conda-forge dv3d --python=27 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge dv3d --python=36 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge vcs --python=27 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge vcs --python=36 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge vcsaddons --python=27 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge vcsaddons --python=36 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge thermo --python=27 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge thermo --python=36 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge wk --python=27 -c cdat/label/nightly -c conda-forge
conda build -c conda-forge wk --python=36 -c cdat/label/nightly -c conda-forge
#conda build -c conda-forge output_viewer
#conda build -c conda-forge cdp
#conda build -c conda-forge uvcmetrics --numpy=1.12
#conda build -c conda-forge uvcmetrics --numpy=1.11
#conda build -c conda-forge uvcmetrics --numpy=1.10
#conda build -c conda-forge uvcmetrics --numpy=1.9
#conda build -c conda-forge vistrails
#conda build -c conda-forge xmgrace
if [ $1"-" == "FULL-" ]; then ./build_uvcdat_contrib.bash ; fi
