#!/usr/bin/env python
import argparse
import os
import sys
import glob
import time


l = time.localtime()
today = "%s.%s.%s" % (l.tm_year,l.tm_mon,l.tm_mday)

parser = argparse.ArgumentParser(description='Cleanup your anaconda server',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-b","--branch",default="master",help="branch to use on uvcdat repo")
parser.add_argument("-B","--build",default="UVCDAT",help="name of this build")
parser.add_argument("-v","--version",default=today,help="which version are we building")

args = parser.parse_args(sys.argv[1:])

files = glob.glob("*/meta.yaml.in")
for fnm in files:
    f=open(fnm)
    s = f.read()
    f.close()
    s = s.replace("@UVCDAT_BRANCH@",args.branch)
    s = s.replace("@BUILD_NAME@",args.build)
    s = s.replace("@VERSION@",args.version)
    f=open(fnm[:-3],"w")
    print >> f,s
    f.close()

