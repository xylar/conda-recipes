export UVCDAT_VERSION=2.12
export BUILD=0
export VERSION=1.1
conda metapackage acme-unified ${VERSION} --build-number ${BUILD}  \
    --dependencies "cdat_info ==${UVCDAT_VERSION}" \
"distarray ==${UVCDAT_VERSION}" \
"cdms2 ==${UVCDAT_VERSION}" \
"cdtime ==${UVCDAT_VERSION}" \
"cdutil ==${UVCDAT_VERSION}" \
"genutil ==${UVCDAT_VERSION}" \
"vtk-cdat ==7.1.0.${UVCDAT_VERSION}" \
"dv3d ==${UVCDAT_VERSION}" \
"vcs ==${UVCDAT_VERSION}" \
"vcsaddons ==${UVCDAT_VERSION}" \
"thermo ==${UVCDAT_VERSION}" \
"wk ==${UVCDAT_VERSION}" \
"vistrails ==${UVCDAT_VERSION}" \
"xmgrace ==${UVCDAT_VERSION}" \
"hdf5tools ==${UVCDAT_VERSION}" \
"asciidata ==${UVCDAT_VERSION}" \
"binaryio ==${UVCDAT_VERSION}" \
"cssgrid ==${UVCDAT_VERSION}" \
"dsgrid ==${UVCDAT_VERSION}" \
"lmoments ==${UVCDAT_VERSION}" \
"natgrid ==${UVCDAT_VERSION}" \
"ort ==${UVCDAT_VERSION}" \
"regridpack ==${UVCDAT_VERSION}" \
"shgrid ==${UVCDAT_VERSION}" \
"trends ==${UVCDAT_VERSION}" \
"zonalmeans ==${UVCDAT_VERSION}" \
"cdp ==1.1.0" \
"acme_diags ==v0.1b" \
"cibots ==0.2" \
"output_viewer ==1.2.2" \
"xarray ==0.9.5" \
"dask ==0.15.2" \
"nco ==4.6.8" \
"lxml ==3.8.0" \
"sympy ==1.1.1" \
"pyproj ==1.9.5.1" \
"pytest ==3.2.2" \
"shapely  ==1.6.1" \
"cartopy  ==0.15.1" \
"progressbar ==2.3" \
"matplotlib" \
"basemap" \
"jupyter" \
"nb_conda" \
"ipython" \
"bottleneck ==1.2.1" \
"netcdf4 ==1.2.9"
