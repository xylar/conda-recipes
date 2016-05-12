#!/usr/bin/env python
import argparse
import os
import sys

parser = argparse.ArgumentParser(
        description='Manage your anaconda packages',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

if os.uname()[0] == "Linux":
    def_os = "linux-64"
else:
    def_os = "osx-64"

parser.add_argument(
    "-o",
    "--os",
    default=def_os,
    help="OS from which you want to cleanup the binaries")

parser.add_argument(
    "-p",
    "--packages",
    default="*",
    help="Packages to cleanup",
    nargs="*")

parser.add_argument(
    "-c",
    "--channel",
    default=os.getlogin(),
    help="channel/organization to cleanup/upload")

parser.add_argument("-B", "--build", default=None, help="Build to use")

parser.add_argument(
    "-v",
    "--version",
    default=None,
    help="Version to use, or use meta.yaml to figure out")
parser.add_argument("-l", "--label", default=None, help="Label to use")

parser.add_argument(
    "-u",
    "--upload",
    default=False,
    action="store_true",
    help="upload packages (default is remove)")
parser.add_argument(
    "-r",
    "--remove",
    default=False,
    action="store_true",
    help="also remove from local conda")

args = parser.parse_args(sys.argv[1:])

myos = args.os
pkg = args.packages
channel = args.channel
build = args.build
version = args.version
if args.label is not None:
    channel = "%s/label/%s" % (channel, args.label)

if pkg == "*":
    import glob
    pkg = glob.glob(pkg)

for p in pkg:
    if args.upload:
        print "Uploading up", p, "to organization", channel, "os", myos
    else:
        print "Cleaning up", p, "from channel", channel, "os", myos
    if args.version!="all" and args.os != "all":
        try:
            f = open(os.path.join(p, "meta.yaml"))
            rd = f.read()
            f.close()
        except:
            continue
        rd = rd[rd.find("name:"):]
        iname = rd.find("\n")
        name = rd[:iname]
        rd = rd[iname:]
        name = name.split()[-1]
        if args.build is None:
            rd2 = rd[rd.find("string:"):]
            ibuild = rd2.find("\n")
            build = rd2[:ibuild].split()[-1]
        else:
            build = args.build
    else:
        name = p
        build = "all"
    print "name:", name
    print "RD:",rd
    if args.version is None:
        print rd.find("version:")
        rd = rd[rd.find("version:"):]
        iversion = rd.find("\n")
        version = rd[:iversion].split()[-1]
    else:
        version = args.version
    print "\tversion:", version
    if version =="all":
        version = "*"
    print "\tbuild:", build
    if args.upload:
        cmd = "anaconda upload -u %s" % args.channel
        if args.label is not None:
            cmd += " -l %s" % args.label
        cmd += " %s/conda-bld/%s/%s-%s-%s.tar.bz2" % (
            sys.prefix, myos, name, version, build)
    else:
        if myos=="all":
            myos="*"
        if myos=="*" and version=="*":
            cmd = "anaconda remove -f %s/%s" % (
                channel, name)
        else:
            cmd = "anaconda remove -f %s/%s/%s/%s/%s-%s-%s.tar.bz2" % (
                channel, name, version, myos, name, version, build)
    print "\tExecuting:", cmd
    os.system(cmd)
    if args.remove:
        cmd = "conda remove %s" % name
        os.system(cmd)
