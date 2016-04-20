#!/usr/bin/env python

import glob
import argparse
import os
import sys
import subprocess
import shlex


parser = argparse.ArgumentParser(description='Build packages that have changed')
parser.add_argument("-g","--git-sources",default="/git/uvcdat")
parser.add_argument("-d","--delta",help="delta to look back in git history to figure out Packages to update",default=1,type=int)
parser.add_argument("-u","--units",help="units for delta",choices=["days","hours","months","years"],default="days")
parser.add_argument("-v","--version",help="name of version to use, default to today's date",default=None)
parser.add_argument("-b","--branch",help="git branch to use, default to current",default=None)
parser.add_argument("-V","--verbose",action="store_true",default=False,help="verbose output")
parser.add_argument(
    "-c",
     "--channel",
     default=os.getlogin(),
     help="channel to cleanup")

parser.add_argument("-B", "--build", default=None, help="Build to use")

parser.add_argument("-v", "--version", default=None, help="Version to use")
parser.add_argument("-l", "--label", default=None, help="Label to use")

files = glob.glob("*/meta.yaml.in")

args = parser.parse_args(sys.argv[1:])

def run_cmd(cmd):
    sub = subprocess.Popen(shlex.split(cmd),cwd=args.git_sources,stderr=subprocess.PIPE,stdout=subprocess.PIPE)
    sub.wait()
    try:
        o = sub.stdout.readlines()
    except:
        o = "No output"
    try:
        e = sub.stderr.readlines()
    except:
        e = "no err"
    if args.verbose: print "OUT:",len(o)
    if args.verbose: print "ERR:",len(e)
    return len(o)+len(e)

if not os.path.exists(args.git_sources):
    raise RuntimeError,"git repo directory does not exists: %s" % args.git_sources

cmd = "git fetch --all" 

# Preping the meta files
cmd = "prep_for_build.py"

if args.branch is not None:
    cmd += " -b %s" % args.branch

if args.build is not None:
    cmd += "-B "%s args.build

if args.version is not None:
    cmd+= "-v %s" % args.version

run_cmd(cmd)


run_cmd(cmd)
if args.branch is not None:
    cmd="git checkout %s" % args.branch
    run_cmd(cmd)

run_cmd("git pull")

for f in files:
    sp = f.split("/")
    bnm = "/".join(sp[:-1]+["build.sh"])
    bld = open(bnm)
    try:
        b = bld.read().split("cd Packages")[1].split()[0][1:]
    except:
        b= sp[0]
    print "package:",b
    p= f.split("/")[0]
    cmd = "git diff --dirstat HEAD 'HEAD@{%i %s ago}' -- Packages/%s" % (args.delta,args.units,b)
    if args.verbose: print "CMD:",cmd
    changes = run_cmd(cmd)
    if changes>0:
        print "\tChanged"
        cmd = "conda build %s" % sp[0]
        run_cmd(cmd)
        
