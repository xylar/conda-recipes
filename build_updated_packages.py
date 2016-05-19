#!/usr/bin/env python

import glob
import argparse
import os
import sys
import subprocess
import shlex


parser = argparse.ArgumentParser(
    description='Build changed packages',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-g", "--git-sources", default="/git/uvcdat")
parser.add_argument(
    "-d",
    "--delta",
    help="delta to look back in git history to figure out Packages to update",
    default=1,
)
parser.add_argument(
    "-u",
    "--units",
    help="units for delta",
    choices=[
        "days",
        "hours",
        "months",
        "years",
        "tag",
        "date"],
    default="days")
parser.add_argument(
    "-v",
    "--version",
    help="name of version to use, default to today's date",
    default=None)
parser.add_argument(
    "-b",
    "--branch",
    help="git branch to use, default to current",
    default=None)
parser.add_argument(
    "-V",
    "--verbose",
    action="store_true",
    default=False,
    help="verbose output")

try:
    user_login = os.getlogin()
except:
    print "COULD NOT figure out your username"
    user_login = "some_user"

parser.add_argument(
    "-c",
    "--channel",
    default=user_login,
    help="channel to cleanup")

parser.add_argument("-B", "--build", default=None, help="Build to use")

parser.add_argument("-l", "--label", default=None, help="Label to use")

files = glob.glob("*/meta.yaml.in")

args = parser.parse_args(sys.argv[1:])


def run_cmd(cmd, cwd=None):
    if cwd is None:
        cwd = args.git_sources
    if args.verbose:
        print "running:", cmd, "in directory", cwd
    sub = subprocess.Popen(
        shlex.split(cmd),
        cwd=cwd,
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE)
    sub.wait()
    try:
        o = sub.stdout.readlines()
    except:
        o = "No output"
    try:
        e = sub.stderr.readlines()
    except:
        e = "no err"
    if args.verbose:
        if len(o) == 0:
            print "OUT OK"
        else:
            print "OUT:", o
    if args.verbose:
        if len(e) == 0:
            print "ERR OK"
        else:
            print "ERR:", e
    return len(o), len(e)

if not os.path.exists(args.git_sources):
    raise RuntimeError(
        "git repo directory does not exists: %s" %
        args.git_sources)

cmd = "git fetch --all"
run_cmd(cmd)

# Preping the meta files
cmd = "./prep_for_build.py"

if args.branch is not None:
    cmd += " -b %s" % args.branch

if args.build is not None:
    cmd += "-B %s" % args.build

if args.version is not None:
    cmd += "-v %s" % args.version

run_cmd(cmd, os.getcwd())


if args.branch is not None:
    cmd = "git checkout %s" % args.branch
    run_cmd(cmd)

run_cmd("git pull")

changed = False
for f in files:
    sp = f.split("/")
    bnm = "/".join(sp[:-1] + ["build.sh"])
    bld = open(bnm)
    try:
        b = bld.read().split("cd Packages")[1].split()[0][1:]
    except:
        b = sp[0]
    print "package:", b
    p = f.split("/")[0]
    last_commit_format = "'HEAD@{%s}'"
    if args.units not in ["tag", "date"]:
        last_commit_format = last_commit_format % ( "%%s %s ago" % args.units )
    elif args.units == "tag":
        last_commit_format = "%s"
    last_commit = last_commit_format % args.delta
    cmd = "git diff --dirstat HEAD %s -- Packages/%s" % (
        last_commit, b)
    if args.verbose:
        print "CMD:", cmd
    changes, errors = run_cmd(cmd)

    if changes > 0:
        changed = True
        print "\tChanged"
        cmd = "conda build %s" % sp[0]
        run_cmd(cmd,os.getcwd())
        cmd = "python manage_anaconda_packages.py -l %s -c %s -p %s" % (args.label, args.channel, sp[0])
        run_cmd(cmd,os.getcwd())
        cmd = "python manage_anaconda_packages.py -u -l %s -c %s -p %s" % (args.label, args.channel, sp[0])
        run_cmd(cmd,os.getcwd())

if changed:
    cmd = "conda build cdat_info"
    run_cmd(cmd,os.getcwd())
    cmd = "python manage_anaconda_packages.py -l %s -c %s -p cdat_info" % (args.label, args.channel)
    run_cmd(cmd,os.getcwd())
    cmd = "python manage_anaconda_packages.py -u -l %s -c %s -p cdat_info" % (args.label, args.channel)
    run_cmd(cmd,os.getcwd())
