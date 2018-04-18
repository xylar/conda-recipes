#!/bin/bash

mkdir build
cd build
env
CONDA_LST=`conda list`
OSNAME=`uname`
if [[ ${CONDA_LST}'y' == *'openmpi'* ]]; then
    export CC=mpicc
    export CXX=mpicxx
    export LC_RPATH="${PREFIX}/lib"
    export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib
    MPI_ARGS="-DVTK_USE_MPI:BOOL=ON"
else
    if [ ${OSNAME} == Linux ]; then
        # To make sure we get the correct g++
        #export LD_LIBRARY_PATH=${PREFIX}/lib:${LIBRARY_PATH}
        #export CC=${CC}" -Wl,-rpath=${PREFIX}/lib"
        #export CXX=${CXX}" -Wl,-rpath=${PREFIX}/lib"
        export CXXFLAGS="${CXXFLAGS} -I/usr/include -I/usr/include/x86_64-linux-gnu"
        export CPPFLAGS="${CPPFLAGS} -I/usr/include -I/usr/include/x86_64-linux-gnu"
        export CFLAGS="${CFLAGS} -I/usr/include -I/usr/include/x86_64-linux-gnu"
        export LDFLAGS="-L/usr/lib/x86_64-linux-gnu -lm"
    fi
    MPI_ARGS=""
fi
if [ ${PY3K} != 0 ]; then
    PYVER_SHORT=3
    PY_LIB="libpython${PY_VER}m${SHLIB_EXT}"
else
    PYVER_SHORT=2
    PY_LIB="libpython${PY_VER}${SHLIB_EXT}"
fi

SIX="-DVTK_USE_SYSTEM_SIX:BOOL=ON"

echo "PYLIB: "${PY_LIB}

COMMON_ARGS="-DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=\"${PREFIX}\" \
        -DCMAKE_INSTALL_RPATH:STRING=\"${PREFIX}/lib\" \
        -DBUILD_DOCUMENTATION=OFF \
        -DBUILD_TESTING:BOOL=OFF \
        -DVTK_HAS_FEENABLEEXCEPT=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DModule_vtkCommonComputationalGeometry:BOOL=ON \
        -DModule_vtkCommonCore:BOOL=ON \
        -DModule_vtkCommonExecutionModel:BOOL=ON \
        -DModule_vtkCommonMisc:BOOL=ON \
        -DModule_vtkCommonSystem:BOOL=ON \
        -DModule_vtkCommonTransforms:BOOL=ON \
        -DModule_vtkFiltersAMR:BOOL=ON \
        -DModule_vtkFiltersCore:BOOL=ON \
        -DModule_vtkFiltersExtraction:BOOL=ON \
        -DModule_vtkFiltersFlowPaths:BOOL=ON \
        -DModule_vtkFiltersGeneral:BOOL=ON \
        -DModule_vtkFiltersGeneric:BOOL=ON \
        -DModule_vtkFiltersGeometry:BOOL=ON \
        -DModule_vtkFiltersHybrid:BOOL=ON \
        -DModule_vtkFiltersImaging:BOOL=ON \
        -DModule_vtkFiltersModeling:BOOL=ON \
        -DModule_vtkFiltersSelection:BOOL=ON \
        -DModule_vtkFiltersSMP:BOOL=OFF \
        -DModule_vtkFiltersSources:BOOL=ON \
        -DModule_vtkFiltersStatistics:BOOL=ON \
        -DModule_vtkFiltersTexture:BOOL=ON \
        -DModule_vtkGeovisCore:BOOL=ON \
        -DModule_vtkImagingColor:BOOL=ON \
        -DModule_vtkImagingCore:BOOL=ON \
        -DModule_vtkImagingGeneral:BOOL=ON \
        -DModule_vtkImagingMath:BOOL=ON \
        -DModule_vtkImagingSources:BOOL=ON \
        -DModule_vtkImagingStencil:BOOL=ON \
        -DModule_vtkInteractionImage:BOOL=ON \
        -DModule_vtkInteractionStyle:BOOL=ON \
        -DModule_vtkInteractionWidgets:BOOL=ON \
        -DModule_vtkIOCore:BOOL=ON \
        -DModule_vtkIOExport:BOOL=ON \
        -DModule_vtkIOExportOpenGL:BOOL=ON \
        -DModule_vtkIOGeometry:BOOL=ON \
        -DModule_vtkIOImage:BOOL=ON \
        -DModule_vtkIOImport:BOOL=ON \
        -DModule_vtkRenderingCore:BOOL=ON \
        -DModule_vtkRenderingFreeType:BOOL=ON \
        -DModule_vtkRenderingFreeTypeOpenGL:BOOL=ON \
        -DModule_vtkRenderingImage:BOOL=ON \
        -DModule_vtkRenderingLabel:BOOL=ON \
        -DModule_vtkRenderingOpenGL:BOOL=ON \
        -DModule_vtkRenderingVolume:BOOL=ON \
        -DModule_vtkRenderingVolumeOpenGL:BOOL=ON \
        -DModule_vtkViewsCore:BOOL=ON \
        -DModule_vtkViewsGeovis:BOOL=ON \
        -DModule_vtkIOFFMPEG:BOOL=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DModule_AutobahnPython:BOOL=ON \
        -DVTK_WRAP_PYTHON=ON \
        -DPYTHON_MAJOR_VERSION=${PYVER_SHORT} \
        -DPYTHON_EXECUTABLE=${PYTHON} \
        -DPYTHON_INCLUDE_PATH=${PREFIX}/include/python${PY_VER} \
        -DPYTHON_LIBRARY=${PREFIX}/lib/${PY_LIB} \
        -DVTK_INSTALL_PYTHON_MODULE_DIR=${SP_DIR} \
        -DModule_vtkRenderingMatplotlib=ON \
        -DVTK_Group_Web:BOOL=ON \
        -DLIBPROJ4_INCLUDE_DIR:PATH=${PREFIX}/include \
        -DVTK_RENDERING_BACKEND=OpenGL \
        -DVTK_USE_SYSTEM_ZLIB:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBXML2:BOOL=ON \
        -DVTK_USE_SYSTEM_HDF5:BOOL=ON \
        -DVTK_USE_SYSTEM_NETCDF:BOOL=ON \
        -DVTK_USE_SYSTEM_FREETYPE:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBPROJ4:BOOL=ON \
        -DVTK_Group_Rendering:BOOL=ON \
        -DVTK_Group_StandAlone:BOOL=OFF \
        -DVTK_LEGACY_SILENT:BOOL=ON\
        ${SIX}"


VTK_ARGS="\
    -DCMAKE_OSX_DEPLOYMENT_TARGET=10.12 \
    -DVTK_REQUIRED_OBJCXX_FLAGS='' \
    -DLIBPROJ4_LIBRARIES:FILEPATH=${PREFIX}/lib/libproj${SHLIB_EXT}"

if [[ ${CONDA_LST}'y' == *'mesalib'* ]]; then
    VTK_ARGS="${VTK_ARGS} \
        -DVTK_USE_OFFSCREEN:BOOL=ON \
        -DVTK_OPENGL_HAS_OSMESA:BOOL=ON \
        -DOSMESA_INCLUDE_DIR:PATH=${PREFIX}/include \
        -DOSMESA_LIBRARY:FILEPATH=${PREFIX}/lib/libOSMesa32${SHLIB_EXT}"

    if [ ${OSNAME} == Linux ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DVTK_USE_X:BOOL=OFF"
    elif [ ${OSNAME} == Darwin ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DVTK_USE_CARBON:BOOL=OFF \
            -DVTK_USE_COCOA:BOOL=OFF"
    fi
else
    VTK_ARGS="${VTK_ARGS} \
        -DVTK_USE_OFFSCREEN:BOOL=OFF \
        -DVTK_OPENGL_HAS_OSMESA:BOOL=OFF"
    if [ ${OSNAME} == Linux ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DVTK_USE_X:BOOL=ON"
    elif [ ${OSNAME} == Darwin ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DVTK_USE_CARBON:BOOL=OFF \
            -DVTK_USE_COCOA:BOOL=ON"
    fi
fi
COMMAND="cmake .. \
    ${COMMON_ARGS} \
    ${VTK_ARGS} \
    ${MPI_ARGS}"
echo $COMMAND
eval ${COMMAND}

make -j${CPU_COUNT}
make install
