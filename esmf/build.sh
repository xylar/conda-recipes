export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
export ESMF_DIR=`pwd`"/esmf"
export ESMP_source="ESMP"
export ESMF_PTHREADS="OFF"
export ESMF_OS=`uname -s`

export ESMF_COMPILER="gfortran"
export ESMF_ABI="64"
if [ `uname` == Darwin ]; then
    export ESMF_OPENMP "OFF"
else
    export ESMF_OPENMP "ON"
fi
export ESMF_INSTALL=${PREFIX}
# ESMF_COMM env variable, choices are openmpi, mpiuni, mpi, mpich2, or mvapich2
ESMF_COMM="mpiuni"

ESMF_MOAB="OFF"
ESMF_ARRAYLITE="TRUE"
cd esmf
make  -j
make install
cd ../ESMP
${PYTHON} generateESMP_Config.py

cat > ESMP.patch << EOF
--- a/ESMP_LoadESMF.py  2014-01-14 10:00:22.000000000 -0500
+++ b/ESMP_LoadESMF.py  2014-01-14 10:40:57.000000000 -0500
@@ -64,6 +64,14 @@
 #      esmfmk = c[2]

   try:
+
+    # If we are not dealing with an absolute path treat it a relative to the
+    # current Python module.
+    if not os.path.isabs(esmfmk):
+      # Get the directory for this module
+      rel_dir = os.path.dirname(os.path.realpath(__file__))
+      esmfmk = os.path.abspath(os.path.join(rel_dir, esmfmk))
+
     MKFILE = open(esmfmk, 'r')
   except:
     raise IOError("File not found\n  %s") % esmfmk
@@ -72,11 +80,12 @@
   libsdir = 0
   esmfos = 0
   esmfabi = 0
+
+  libsdir = os.path.dirname(esmfmk)
+
 #  MKFILE = open(esmfmk,'r')
   for line in MKFILE:
-    if 'ESMF_LIBSDIR' in line:
-      libsdir = line.split("=")[1]
-    elif 'ESMF_OS:' in line:
+    if 'ESMF_OS:' in line:
       esmfos = line.split(":")[1]
     elif 'ESMF_ABI:' in line:
       esmfabi = line.split(":")[1]
EOF
patch -p1 src/ESMP_LoadESMF.py ESMP.patch
#${PYTHON} setup.py install
