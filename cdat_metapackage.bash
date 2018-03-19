export VERSION=2.12
export VERSION_EXTRA="nightly"
export BUILD=2
export OPERATOR=">"
export PY3_VERSION="<"
conda metapackage cdat ${VERSION}.${VERSION_EXTRA} --build-number ${BUILD} --dependencies "cdat_info ${OPERATOR}${VERSION}" "distarray ${OPERATOR}${VERSION}" "cdms2 ${OPERATOR}${VERSION}" "cdtime ${OPERATOR}${VERSION}" "cdutil ${OPERATOR}${VERSION}" "genutil ${OPERATOR}${VERSION}" "vtk-cdat ${OPERATOR}=7.1.0.${VERSION}" "dv3d ${OPERATOR}${VERSION}" "vcs ${OPERATOR}${VERSION}" "vcsaddons ${OPERATOR}${VERSION}" "thermo ${OPERATOR}${VERSION}" "wk ${OPERATOR}${VERSION}" matplotlib basemap ipython jupyter nb_conda flake8 autopep8 spyder eofs windspharm cibots cdp output_viewer esmpy "proj4<5"
