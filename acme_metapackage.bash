export UVCDAT_VERSION=2.12
export BUILD=0
export VERSION=1.1.2

# For nightly set OPERATOR to ">="
export OPERATOR="=="

conda metapackage -c conda-forge -c acme -c uvcdat -c opengeostat acme-unified ${VERSION} --build-number ${BUILD}  \
    --dependencies "cdat_info ${OPERATOR}${UVCDAT_VERSION}" \
"distarray ${OPERATOR}${UVCDAT_VERSION}" \
"cdms2 ${OPERATOR}${UVCDAT_VERSION}" \
"cdtime ${OPERATOR}${UVCDAT_VERSION}" \
"cdutil ${OPERATOR}${UVCDAT_VERSION}" \
"genutil ${OPERATOR}${UVCDAT_VERSION}" \
"vtk-cdat ${OPERATOR}7.1.0.${UVCDAT_VERSION}" \
"dv3d ${OPERATOR}${UVCDAT_VERSION}" \
"vcs ${OPERATOR}${UVCDAT_VERSION}" \
"vcsaddons ${OPERATOR}${UVCDAT_VERSION}" \
"acme_diags ${OPERATOR}1.0.1" \
"cibots ${OPERATOR}0.2" \
"xarray ${OPERATOR}0.9.6" \
"dask ${OPERATOR}0.15.2" \
"nco ${OPERATOR}4.6.9" \
"lxml ${OPERATOR}3.8.0" \
"sympy ${OPERATOR}1.1.1" \
"pyproj ${OPERATOR}1.9.5.1" \
"pytest ${OPERATOR}3.2.2" \
"shapely  ${OPERATOR}1.6.1" \
"cartopy  ${OPERATOR}0.15.1" \
"progressbar ${OPERATOR}2.3" \
"scipy <1.0.0" \
"numpy >1.13" \
"jupyter" \
"nb_conda" \
"ipython" \
"bottleneck ${OPERATOR}1.2.1" \
"netcdf4 ${OPERATOR}1.2.9" \
"pyevtk ${OPERATOR}1.0.0"
