#!/bin/bash

mkdir build
cd build

BUILD_CONFIG=Release
OSNAME=`uname`

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
    -DVTK_BUILD_DOCUMENTATION:BOOL=OFF \
    -DVTK_BUILD_TESTING:STRING==OFF \
    -DVTK_BUILD_EXAMPLES:BOOL=OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DVTK_LEGACY_SILENT:BOOL=OFF \
    -DVTK_HAS_FEENABLEEXCEPT:BOOL=OFF \
    -DVTK_WRAP_PYTHON:BOOL=ON \
    -DVTK_PYTHON_VERSION:STRING="${PY_VER}" \
    -DVTK_PYTHON_OPTIONAL_LINK:BOOL=ON \
    -DVTK_MODULE_ENABLE_VTK_PythonInterpreter:STRING=NO \
    -DVTK_MODULE_ENABLE_VTK_RenderingMatplotlib:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_IOFFMPEG:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_ViewsCore:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_ViewsGeovis:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_ViewsContext2D:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_PythonContext2D:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_RenderingContext2D:STRING=YES \
    -DVTK_MODULE_ENABLE_VTK_RenderingContextOpenGL2:STRING=YES \
    ${VTK_ARGS}

# compile and install
ninja install

# patch the dynamic load libraries
# if [ ${PY3K} == 1 ] && [ ${OSNAME} == Darwin ]; then
#     echo 'Patching dynamic lookup libraries'
#     mv ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib_orig
#     mv ${PREFIX}/lib/libvtkRenderingMatplotlibPython37D-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlibPython37D-8.2.1.dylib_orig
#     mv ${PREFIX}/lib/libvtkPythonInterpreter-8.2.1.dylib ${PREFIX}/lib/libvtkPythonInterpreter-8.2.1.dylib_orig
#     cp ../libvtkRenderingMatplotlib-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlib-8.2.1.dylib
#     cp ../libvtkRenderingMatplotlibPython36D-8.2.1.dylib ${PREFIX}/lib/libvtkRenderingMatplotlibPython37D-8.2.1.dylib
#     cp ../libvtkPythonInterpreter-8.2.1.dylib ${PREFIX}/lib/libvtkPythonInterpreter-8.2.1.dylib
# fi
