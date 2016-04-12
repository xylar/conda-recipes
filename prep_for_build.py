#!/usr/bin/env python
import argparse
import os
import sys
import glob

parser = argparse.ArgumentParser(description='Cleanup your anaconda server')

parser.add_argument("-b","--branch",default="master")
parser.add_argument("-n","--name",default="master")
parser.add_argument("-v","--version",default=None)

args = parser.parse_args(sys.argv[1:])

if args.version is None:
    l = time.localtime()
    args.version = "%s.%s.%s" % (l.tm_year,l.tm_mon,l.tm_mday)

files = glob.glob("*/meta.yaml.in")
for fnm in files:
    f=open(fnm)
    s = f.read()
    f.close()
    s = s.replace("@UVCDAT_BRANCH@",args.branch)
    s = s.replace("@BUILD_NAME@",args.name)
    s = s.replace("@VERSION@",args.version)
    f=open(fnm[:-3],"w")
    print >> f,s
    f.close()

