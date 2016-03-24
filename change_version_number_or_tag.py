import os
import glob
import argparse
import sys

files = glob.glob("*/meta.yaml")

parser = argparse.ArgumentParser(description='Sets cdat version to use')
parser.add_argument("-v","--version",default="master")
parser.add_argument("-d","--dry-run",action="store_true",default=False)
args = parser.parse_args(sys.argv[1:])
version = args.version

f=open("cdat_info/meta.yaml")
for l in f.xreadlines():
    if l.find("version:")>-1:
        current_version = l.split()[1]

if current_version == version:
    print "Current version is already %s, aborting" % (version)
    sys.exit()
print "Converting cdat tag from %s to %s" % (current_version,version)
        
for fnm in files:
    print "META File:",f
    lines = []
    f = open(fnm)
    found = False
    for l in f.xreadlines():
        if l.find("version:")>-1:
            nl = l.replace(current_version,version)
            found = True
        else:
            nl = l
        lines.append(nl)
    f.close()
    if found:
        print "Found the string, replaced it",args.dry_run
        if not args.dry_run:
            f = open(fnm,"w")
            print >> f, "\n".join(lines)
            f.close()
        else:
            print "Would replace version in:",fnm

print "Done"
