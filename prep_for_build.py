#!/usr/bin/env python
import argparse
import sys
import glob
import time

last_stable = "2.10"
l = time.localtime()
today = "%s.%s.%s.%s.%s.%s.{{ GIT_FULL_HASH }}" % (last_stable, l.tm_year, l.tm_mon, l.tm_mday, l.tm_hour, l.tm_min)

parser = argparse.ArgumentParser(
    description='Cleanup your anaconda server',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-b", "--branch", default="master",
                    help="branch to use on uvcdat repo")
parser.add_argument(
    "-B",
    "--build",
    default="0",
    help="name of this build")

parser.add_argument("-v", "--version", default=today,
                    help="which version are we building")

parser.add_argument("-f", "--features", nargs="*",
                    help="features to be enabled", default=[])


args = parser.parse_args(sys.argv[1:])

featured_packages = {}
files = glob.glob("*/meta.yaml.in")
for fnm in files:
    print fnm
    with open(fnm) as f:
        s = f.read()
    s = s.replace("@UVCDAT_BRANCH@", args.branch)
    s = s.replace("@BUILD_NUMBER@", args.build)
    s = s.replace("@VERSION@", args.version)

    out = []
    for l in s.split("\n"):
        if any([l.find("{{{ %s }}}" % f)>-1 for f in args.features]):
            for f in args.features:
                l = l.replace("{{{ %s }}}" % f,"")
            out.append(l)
        elif l.find("{{{")==-1:  # it's not a unused feature line
            out.append(l)
    with open(fnm[:-3],"w") as f:
        f.write("\n".join(out))
