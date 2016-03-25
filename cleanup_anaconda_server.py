import argparse
import os
import sys

myos="osx-64"
#myos = "linux-64"
package = "*"
channel = "doutriaux1"
buildstring = "UVCDAT"

import glob
pkg = glob.glob(package)
print pkg
for p in glob.glob(package):
    print "PACKAGE:",p
    try:
        f= open(os.path.join(p,"meta.yaml"))
        rd = f.read()
        f.close()
    except:
        continue
    rd = rd[rd.find("name:"):]
    iname = rd.find("\n")
    name = rd[:iname]
    rd = rd[iname:]
    name = name.split()[-1]
    print "name:",name
    rd = rd[rd.find("version:"):]
    iversion = rd.find("\n")
    version = rd[:iversion].split()[-1]
    version="master"
    print version
    rd=rd[rd.find("string:"):]
    ibuild = rd.find("\n")
    build=rd[:ibuild].split()[-1]
    print "build:",build
    cmd = "anaconda remove -f %s/%s/%s/%s/%s-%s-%s.tar.bz2" % (channel,name,version,myos,name,version,build)
    print cmd
    os.system(cmd)
