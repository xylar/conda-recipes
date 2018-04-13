from __future__ import print_function
from subprocess import Popen, PIPE
import os
import sys
import shlex

def run_cmd(cmd, verbose=False):
    if verbose:
        print("Executing :",cmd)
    p = Popen(shlex.split(cmd), stdout=PIPE, stderr=PIPE)
    o,e = p.communicate()
    return o,e

if sys.platform == "darwin":
    conda_os = "osx-64"
else:
    conda_os = "linux-64"

conda_pkgs = os.path.abspath(os.path.join(os.environ.get("CONDA_EXE"),"..","..","pkgs"))
# Get list of package we are using
pkgs, err = run_cmd("conda list", verbose=True)
for l in pkgs.split("\n")[2:-1]:
    sp = l.split()
    name = sp[0]
    version = sp[1]
    build = sp[2]
    tarname = "{}-{}-{}.tar.bz2".format(name,version,build)
    tarball = os.path.join(conda_pkgs,tarname)
    print("looking at:",tarball,os.path.exists(tarball))
    if os.path.exists(tarball):
        o,e = run_cmd("anaconda upload {} -u cdat-forge".format(tarball))
        print("OUT:",o)
        print("Err:",e)
print(sys.prefix)
print(conda_pkgs)
