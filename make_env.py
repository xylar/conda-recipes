#!/usr/bin/env python
from __future__ import print_function
import testsrunner

args = {
'VERSION':"8.0",
'CDMS_VERSION':"3.0.1",
'VERSION_EXTRA':"",
'BUILD':"1",
'OPERATOR':">=",
'CDMS_OPERATOR':">",
'PY3_VERSION':"<",
}
pkgs = '"cdat_info {OPERATOR}{VERSION}" "distarray {OPERATOR}2.12.2" "cdms2 {CDMS_OPERATOR}{CDMS_VERSION}" "cdtime {OPERATOR}{CDMS_VERSION}" "cdutil {OPERATOR}{VERSION}" "genutil {OPERATOR}{VERSION}" "vtk-cdat {OPERATOR}8.0.1.{VERSION}" "dv3d {OPERATOR}{VERSION}" "vcs {OPERATOR}{VERSION}" "vcsaddons {OPERATOR}{VERSION}" "thermo {OPERATOR}{VERSION}" "wk {OPERATOR}{VERSION}" matplotlib basemap ipython jupyter nb_conda flake8 autopep8 spyder eofs windspharm cibots cdp output_viewer esmpy scipy'.format(**args)
pkgs = '"cdat_info {OPERATOR}{VERSION}" "distarray {OPERATOR}2.12.2" "cdms2 {CDMS_OPERATOR}{CDMS_VERSION}" "cdtime {OPERATOR}{CDMS_VERSION}" "cdutil {OPERATOR}{VERSION}" "genutil {OPERATOR}{VERSION}" "vtk-cdat {OPERATOR}8.0.1.{VERSION}" "dv3d {OPERATOR}{VERSION}" "vcs {OPERATOR}{VERSION}" "vcsaddons {OPERATOR}{VERSION}" "thermo {OPERATOR}{VERSION}" "wk {OPERATOR}{VERSION}" matplotlib basemap ipython jupyter nb_conda flake8 autopep8'.format(**args)
pkgs = pkgs.split()
operators = ["<",">","="]
indices = []
for i,p in enumerate(pkgs):
    if p[0] in operators:
        indices.append(i)
        pkgs[i-1] = pkgs[i-1]+" {}".format(p)
for i in indices[::-1]:
    pkgs.pop(i)
print("pkg",pkgs)
while len(pkgs)>1:
    cmd = "conda create -n blah --dry-run -c cdat/label/nightly -c conda-forge -c cdat {}".format(" ".join(pkgs))
    print("COMMAND:",cmd)
    out = testsrunner.run_command(cmd, verbosity=0)[-1]
    for l in out:
        if "ffmpeg" in l:
            sp = l.split()
            ffmpeg_version = int(sp[1].split(".")[0])
            print("\tFFMPEG VERSION:",ffmpeg_version)
            if ffmpeg_version == 4:
                print("\t\tGOOD")
                sys.exit(0)
            else:
                print("\t\tStill bad")
    pkgs.pop(-1)

