#!/bin/bash

mkdir build
cd build

if [ `uname` == Linux ]; then
    CC=gcc
    CXX=g++
    PY_LIB="libpython${PY_VER}.so"

    cmake .. \
        -DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
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
        -DModule_vtkFiltersSMP:BOOL=ON \
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
        -DVTK_WRAP_PYTHON=ON \
        -DPYTHON_EXECUTABLE=${PYTHON} \
        -DPYTHON_INCLUDE_PATH=${PREFIX}/include/python${PY_VER} \
        -DPYTHON_LIBRARY=${PREFIX}/lib/${PY_LIB} \
        -DVTK_INSTALL_PYTHON_MODULE_DIR=${SP_DIR} \
        -DModule_vtkRenderingMatplotlib=ON \
        -DVTK_USE_X=ON \
        -DVTK_Group_Web:BOOL=ON \
        -DLIBPROJ4_INCLUDE_DIR:PATH=${PREFIX}/include \
        -DLIBPROJ4_LIBRARIES:FILEPATH=${PREFIX}/lib/libproj.so \
        -DVTK_RENDERING_BACKEND=OpenGL \
        -DVTK_USE_SYSTEM_ZLIB:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBXML2:BOOL=ON \
        -DVTK_USE_SYSTEM_HDF5:BOOL=ON \
        -DVTK_USE_SYSTEM_NETCDF:BOOL=ON \
        -DVTK_USE_SYSTEM_FREETYPE:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBPROJ4:BOOL=ON \
        -DVTK_Group_Rendering:BOOL=OFF \
        -DVTK_Group_StandAlone:BOOL=OFF \
        -DVTK_LEGACY_SILENT:BOOL=ON

fi

if [ `uname` == Darwin ]; then
    CC=gcc
    CXX=g++
    PY_LIB="libpython${PY_VER}.dylib"

    cmake .. \
        -DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DVTK_REQUIRED_OBJCXX_FLAGS='' \
        -DVTK_USE_CARBON=OFF \
        -DVTK_USE_COCOA=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_INSTALL_RPATH:STRING="$PREFIX/lib" \
        -DBUILD_DOCUMENTATION=OFF \
        -DBUILD_TESTING=OFF \
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
        -DModule_vtkFiltersSMP:BOOL=ON \
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
        -DVTK_WRAP_PYTHON=ON \
        -DPYTHON_EXECUTABLE=${PYTHON} \
        -DPYTHON_INCLUDE_PATH=${PREFIX}/include/python${PY_VER} \
        -DPYTHON_LIBRARY=${PREFIX}/lib/${PY_LIB} \
        -DVTK_INSTALL_PYTHON_MODULE_DIR=${SP_DIR} \
        -DModule_vtkRenderingMatplotlib=ON \
        -DVTK_USE_X=OFF \
        -DVTK_Group_Web:BOOL=ON \
        -DLIBPROJ4_INCLUDE_DIR:PATH=${PREFIX}/include \
        -DLIBPROJ4_LIBRARIES:FILEPATH=${PREFIX}/lib/libproj.dylib \
        -DVTK_RENDERING_BACKEND=OpenGL \
        -DVTK_USE_SYSTEM_ZLIB:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBXML2:BOOL=ON \
        -DVTK_USE_SYSTEM_HDF5:BOOL=ON \
        -DVTK_USE_SYSTEM_NETCDF:BOOL=ON \
        -DVTK_USE_SYSTEM_LIBPROJ4:BOOL=ON \
        -DVTK_Group_Rendering:BOOL=OFF \
        -DVTK_Group_StandAlone:BOOL=OFF \
        -DVTK_LEGACY_SILENT:BOOL=ON
fi

make -j4
make install
