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
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
        -DBUILD_DOCUMENTATION=OFF \
        -DBUILD_TESTING:BOOL=OFF \
        -DVTK_HAS_FEENABLEEXCEPT=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DModule_CommonComputationalGeometry:BOOL=ON \
        -DModule_CommonCore:BOOL=ON \
        -DModule_CommonExecutionModel:BOOL=ON \
        -DModule_CommonMisc:BOOL=ON \
        -DModule_CommonSystem:BOOL=ON \
        -DModule_CommonTransforms:BOOL=ON \
        -DModule_FiltersAMR:BOOL=ON \
        -DModule_FiltersCore:BOOL=ON \
        -DModule_FiltersExtraction:BOOL=ON \
        -DModule_FiltersFlowPaths:BOOL=ON \
        -DModule_FiltersGeneral:BOOL=ON \
        -DModule_FiltersGeneric:BOOL=ON \
        -DModule_FiltersGeometry:BOOL=ON \
        -DModule_FiltersHybrid:BOOL=ON \
        -DModule_FiltersImaging:BOOL=ON \
        -DModule_FiltersModeling:BOOL=ON \
        -DModule_FiltersSelection:BOOL=ON \
        -DModule_FiltersSMP:BOOL=ON \
        -DModule_FiltersSources:BOOL=ON \
        -DModule_FiltersStatistics:BOOL=ON \
        -DModule_FiltersTexture:BOOL=ON \
        -DModule_GeovisCore:BOOL=ON \
        -DModule_ImagingColor:BOOL=ON \
        -DModule_ImagingCore:BOOL=ON \
        -DModule_ImagingGeneral:BOOL=ON \
        -DModule_ImagingMath:BOOL=ON \
        -DModule_ImagingSources:BOOL=ON \
        -DModule_ImagingStencil:BOOL=ON \
        -DModule_InteractionImage:BOOL=ON \
        -DModule_InteractionStyle:BOOL=ON \
        -DModule_InteractionWidgets:BOOL=ON \
        -DModule_IOCore:BOOL=ON \
        -DModule_IOExport:BOOL=ON \
        -DModule_IOGeometry:BOOL=ON \
        -DModule_IOImage:BOOL=ON \
        -DModule_IOImport:BOOL=ON \
        -DModule_RenderingCore:BOOL=ON \
        -DModule_RenderingFreeType:BOOL=ON \
        -DModule_RenderingFreeTypeOpenGL:BOOL=ON \
        -DModule_RenderingImage:BOOL=ON \
        -DModule_RenderingLabel:BOOL=ON \
        -DModule_RenderingOpenGL:BOOL=ON \
        -DModule_RenderingVolume:BOOL=ON \
        -DModule_RenderingVolumeOpenGL:BOOL=ON \
        -DModule_ViewsCore:BOOL=ON \
        -DModule_ViewsGeovis:BOOL=ON \
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
        -DLIBPROJ4_LIBRARIES:FILEPATH=${PREFIX}/lib/libproj${_LINK_LIBRARY_SUFFIX}
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
        -DModule_CommonComputationalGeometry:BOOL=ON \
        -DModule_CommonCore:BOOL=ON \
        -DModule_CommonExecutionModel:BOOL=ON \
        -DModule_CommonMisc:BOOL=ON \
        -DModule_CommonSystem:BOOL=ON \
        -DModule_CommonTransforms:BOOL=ON \
        -DModule_FiltersAMR:BOOL=ON \
        -DModule_FiltersCore:BOOL=ON \
        -DModule_FiltersExtraction:BOOL=ON \
        -DModule_FiltersFlowPaths:BOOL=ON \
        -DModule_FiltersGeneral:BOOL=ON \
        -DModule_FiltersGeneric:BOOL=ON \
        -DModule_FiltersGeometry:BOOL=ON \
        -DModule_FiltersHybrid:BOOL=ON \
        -DModule_FiltersImaging:BOOL=ON \
        -DModule_FiltersModeling:BOOL=ON \
        -DModule_FiltersSelection:BOOL=ON \
        -DModule_FiltersSMP:BOOL=ON \
        -DModule_FiltersSources:BOOL=ON \
        -DModule_FiltersStatistics:BOOL=ON \
        -DModule_FiltersTexture:BOOL=ON \
        -DModule_GeovisCore:BOOL=ON \
        -DModule_ImagingColor:BOOL=ON \
        -DModule_ImagingCore:BOOL=ON \
        -DModule_ImagingGeneral:BOOL=ON \
        -DModule_ImagingMath:BOOL=ON \
        -DModule_ImagingSources:BOOL=ON \
        -DModule_ImagingStencil:BOOL=ON \
        -DModule_InteractionImage:BOOL=ON \
        -DModule_InteractionStyle:BOOL=ON \
        -DModule_InteractionWidgets:BOOL=ON \
        -DModule_IOCore:BOOL=ON \
        -DModule_IOExport:BOOL=ON \
        -DModule_IOGeometry:BOOL=ON \
        -DModule_IOImage:BOOL=ON \
        -DModule_IOImport:BOOL=ON \
        -DModule_RenderingCore:BOOL=ON \
        -DModule_RenderingFreeType:BOOL=ON \
        -DModule_RenderingFreeTypeOpenGL:BOOL=ON \
        -DModule_RenderingImage:BOOL=ON \
        -DModule_RenderingLabel:BOOL=ON \
        -DModule_RenderingOpenGL:BOOL=ON \
        -DModule_RenderingVolume:BOOL=ON \
        -DModule_RenderingVolumeOpenGL:BOOL=ON \
        -DModule_ViewsCore:BOOL=ON \
        -DModule_ViewsGeovis:BOOL=ON \
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
        -DLIBPROJ4_LIBRARIES:FILEPATH=${PREFIX}/lib/libproj${_LINK_LIBRARY_SUFFIX}
fi

make -j4
make install
