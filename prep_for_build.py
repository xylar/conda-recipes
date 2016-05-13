#!/usr/bin/env python
import argparse
import sys
import glob
import time


l = time.localtime()
today = "%s.%s.%s" % (l.tm_year, l.tm_mon, l.tm_mday)

parser = argparse.ArgumentParser(
        description='Cleanup your anaconda server',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-b", "--branch", default="master",
                    help="branch to use on uvcdat repo")
parser.add_argument(
    "-B",
    "--build",
    default="UVCDAT",
    help="name of this build")

parser.add_argument("-v", "--version", default=today,
                    help="which version are we building")

parser.add_argument("-f","--features", nargs="*",
        help="features to be enabled",default=[])


args = parser.parse_args(sys.argv[1:])
print args.features


files = glob.glob("*/meta.yaml.in")
for fnm in files:
    f = open(fnm)
    s = f.read()
    f.close()
    s = s.replace("@UVCDAT_BRANCH@", args.branch)
    s = s.replace("@BUILD_NAME@", args.build)
    s = s.replace("@VERSION@", args.version)
    ## Now we deal with features
    lines=[]
    features_used = set()
    for l in s.split("\n"):
        print l
        addline = True
        for f in args.features:
            if l.find("!{%s}" % f)>-1: # skip for this feature
                addline = False
            elif l.find("{%s}" % f)>-1:
                features_used.add(f)
            elif l.find("{%s}"%f)==-1 and l.find("{")>-1: # other feature but NOT this one line
                addline = False
        if addline:
            ## Sanitize the features out of the line
            while l.find("!{")>-1:
                print "found a neg"
                i = l.find("!{")
                j=l[i:].find("}")
                l=l[:i]+l[i+j+1:]
            while l.find("{")>-1:
                print "found a feat",l
                i = l.find("{")
                j=l[i:].find("}")
                l=l[:i]+l[i+j+1:]
            lines.append(l)
    f = open(fnm[:-3], "w")
    for l in lines:
        ## Is it a name line?
        if l.find("name:")>-1:
            sp = l.split("name:")
            sp[-1] = "-".join([sp[-1]]+list(features_used))
            print >> f, "name:".join(sp)
        else:
            print >> f, l
    f.close()
