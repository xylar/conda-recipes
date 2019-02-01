#!/bin/bash

mkdir build
cd build

BUILD_CONFIG=Release
OSNAME=`uname`
CONDA_BUILD_SYSROOT=/opt/MacOSX10.9.sdk

if [ -f "$PREFIX/lib/libOSMesa32${SHLIB_EXT}" ]; then
    VTK_ARGS="${VTK_ARGS} \
        -DVTK_USE_OFFSCREEN:BOOL=ON \
        -DVTK_OPENGL_HAS_OSMESA:BOOL=ON \
        -DOSMESA_INCLUDE_DIR:PATH=${PREFIX}/include \
        -DOSMESA_LIBRARY:FILEPATH=${PREFIX}/lib/libOSMesa32${SHLIB_EXT}"

    if [ ${OSNAME} == Linux ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DCMAKE_CXX_STANDARD_LIBRARIES:PATH=${PREFIX}/lib/libstdc++.so \
            -DVTK_USE_X:BOOL=OFF"
    elif [ ${OSNAME} == Darwin ]; then
        VTK_ARGS="${VTK_ARGS} \
            -DVTK_USE_CARBON:BOOL=OFF \
            -DVTK_USE_COCOA:BOOL=OFF \
            -DCMAKE_OSX_SYSROOT:PATH=${CONDA_BUILD_SYSROOT}"
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
            -DVTK_USE_COCOA:BOOL=ON \
            -DCMAKE_OSX_SYSROOT:PATH=${CONDA_BUILD_SYSROOT}"
    fi
fi

# now we can start configuring
cmake .. -G "Ninja" \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=$BUILD_CONFIG \
    -DCMAKE_PREFIX_PATH:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR:PATH="lib" \
    -DCMAKE_INSTALL_RPATH:PATH="${PREFIX}/lib" \
    -DBUILD_DOCUMENTATION:BOOL=OFF \
    -DBUILD_TESTING:BOOL=OFF \
    -DBUILD_EXAMPLES:BOOL=OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DVTK_WRAP_PYTHON:BOOL=ON \
    -DModule_vtkPythonInterpreter:BOOL=OFF \
    -DVTK_PYTHON_VERSION:STRING="${PY_VER}" \
    -DVTK_HAS_FEENABLEEXCEPT:BOOL=OFF \
    -DModule_vtkRenderingMatplotlib=ON \
    -DVTK_Group_Web:BOOL=ON \
    -DVTK_LEGACY_SILENT:BOOL=ON \
    -DModule_vtkIOFFMPEG:BOOL=ON \
    -DModule_vtkViewsCore:BOOL=ON \
    -DModule_vtkViewsGeovis:BOOL=ON \
    ${VTK_ARGS}

# compile and install
ninja install

# patch the dynamic load libraries
if [ ${PY3K} == 1 ] && [ ${OSNAME} == Darwin ]; then
    echo 'Patching dynamic lookup libraries'
    mv ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib_orig
    mv ${PREFIX}/lib/libvtkRenderingMatplotlibPython36D-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlibPython36D-8.2.1.dylib_orig
    cp ../libvtkRenderingMatplotlib-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib
    cp ../libvtkRenderingMatplotlibPython36D-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlibPython36D-8.2.1.dylib
fi
