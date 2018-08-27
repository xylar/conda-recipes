export VERSION=8.0
export CDMS_VERSION=3.0.2018.08.15
export CDTIME_VERSION=3.0
export VERSION_EXTRA=""
export BUILD=1
export OPERATOR=">="
export CDMS_OPERATOR=">"
export PY3_VERSION="<"
conda metapackage cdat ${VERSION}${VERSION_EXTRA} --build-number ${BUILD} --dependencies "cdat_info ${OPERATOR}${VERSION}" "distarray ${OPERATOR}2.12.2" "cdms2 ${CDMS_OPERATOR}${CDMS_VERSION}" "cdtime ${OPERATOR}${CDTIME_VERSION}" "cdutil ${OPERATOR}${VERSION}" "genutil ${OPERATOR}${VERSION}" "vtk-cdat ${OPERATOR}8.0.1.${VERSION}" "dv3d ${OPERATOR}${VERSION}" "vcs ${OPERATOR}${VERSION}" "vcsaddons ${OPERATOR}${VERSION}" "thermo ${OPERATOR}${VERSION}" "wk ${OPERATOR}${VERSION}" matplotlib basemap ipython jupyter nb_conda flake8 autopep8 spyder eofs windspharm cibots cdp output_viewer esmpy scipy "ffmpeg >4"
