meta_str = """
conda metapackage uvcdat 2.6.1 --build-string UVCDAT -d 'asciidata ==2.6' 'basemap' 'binaryio ==2.6' 'cdat_info ==2.6.1' 'cdms2 ==2.6.1' 'cdtime ==2.6.1' 'cdutil ==2.6' 'clapack ==3.2.1' 'cmor ==2.9.2' 'cssgrid ==2.6.1' 'distarray ==2.6' 'dsgrid ==2.6' 'dv3d ==2.6' 'esg ==2.6' 'esmf ==ESMF_6_3_0rp1_ESMP_01' 'eztemplate ==2.6' 'ffmpeg ==2.7.0' 'g2clib ==1.4.0b' 'genutil ==2.6' 'hdf5tools ==2.6' 'jasper ==1.900.1' 'lapack ==3.4.2' 'libcdms ==2.6.1' 'libcf ==1.0.beta11' 'libnetcdf ==4.3.3.1' 'libpng ==1.6.17' 'lmoments ==2.6.1' 'natgrid ==2.6' 'ort ==2.6.1' 'ossuuid ==1.6.2' 'pydebug ==2.6' 'regrid2 ==2.6.1' 'regridpack ==2.6.1' 'shgrid ==2.6.1' 'spherepack ==2.6.1' 'thermo ==2.6' 'trends ==2.6' 'udunits2 ==2.2.17' 'unidata ==2.6' 'vcs ==2.6' 'uvcmetrics' 'vcsaddons ==2.6' 'vistrails ==master' 'vtk ==7.1.0.2.6' 'wk ==2.6' 'x264 ==20151006.2245' 'xmgrace ==2.6' 'yasm ==1.2.0' 'zonalmeans ==2.6.1' 'pyqt ==4.11.3' 'gfortran' 'ipython' 'requests'
"""

f=open("uvcdat/meta.yaml")
found_run = False
packages = []
pin_versions = True
for l in f.xreadlines():
    if l.find("run:")>1:
        found_run=True
        continue
    if not found_run:
        continue

    sp=l.split()
    if len(sp)==0 or not sp[0]=="-":
        continue
    nm = sp[1]
    print sp
    if pin_versions:
        try:
            ver = sp[2]
        except:
            ver = ""
    else:
        ver = ""
    packages.append("%s %s" % (nm,ver))

print "conda metapackage uvcdat 2.6.1 -d 'ipython' 'requests' %s" % " ".join(["'%s'"%p.strip() for p in packages])

f.close()

