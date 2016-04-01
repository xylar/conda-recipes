#!/usr/bin/env python
import argparse
import os
import sys
import glob

parser = argparse.ArgumentParser(description='Cleanup your anaconda server')

parser.add_argument("-b","--branch",default="master")
parser.add_argument("-n","--name",default="master")

args = parser.parse_args(sys.argv[1:])

files = glob.glob("*/meta.yaml.in")
for fnm in files:
    f=open(fnm)
    s = f.read()
    f.close()
    s = s.replace("@UVCDAT_BRANCH@",args.branch)
    s = s.replace("@BUILD_NAME@",args.branch)
    f=open(fnm[:-3],"w")
    print >> f,s
    f.close()

