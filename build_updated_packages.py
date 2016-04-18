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

files = glob.glob("*/meta.yaml.in")

args = parser.parse_args(sys.argv[1:])

if not os.path.exists(args.git_sources):
    raise RuntimeError,"git repo directory does not exists: %s" % args.git_sources

cmd = "git fetch --all;" 
def run_cmd(cmd):
    sub = subprocess.Popen(shlex.split(cmd),cwd=args.git_sources)
    sub.wait()
    try:
        o = sub.stdout.readlines()
    except:
        o = "No output"
    try:
        e = sub.stderr.readlines()
    except:
        e = "no err"
    print "OUT:",o
    print "ERR:",e

run_cmd(cmd)
if args.branch is not None:
    cmd+="git checkout %s" % args.branch
    run_cmd(cmd)


for f in files:
    print f
    sp = f.split("/")
    bnm = "/".join(sp[:-1]+["build.sh"])
    print "Build fie name:",bnm
    bld = open(bnm)
    b = bld.read().split("cd Packages")[1].split()[0][1:]
    print "package dir:",b
    p= f.split("/")[0]
    cmd += "git diff HEAD 'HEAD@{%i %s ago}' -- Packages/%s ;" % (args.delta,args.units,b)
    print "CMD:",cmd
