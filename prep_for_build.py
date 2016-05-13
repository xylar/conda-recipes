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

featured_packages = {}
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
                i = l.find("!{")
                j=l[i:].find("}")
                l=l[:i]+l[i+j+1:]
            while l.find("{")>-1:
                i = l.find("{")
                j=l[i:].find("}")
                l=l[:i]+l[i+j+1:]
            lines.append(l)
    f = open(fnm[:-3], "w")
    for l in lines:
        ## Is it a name line?
        if l.find("name:")>-1:
            sp = l.split("name:")
            original_name = sp[-1].strip()
            sp[-1] = "-".join([sp[-1]]+sorted(list(features_used)))
            print >> f, "name:".join(sp).rstrip()
        else:
            print >> f, l.rstrip()
    f.close()
    if len(features_used)>0:
        featured_packages[original_name]=features_used

while len(featured_packages.keys())>0:
    print "FEATURED PACKAGES",featured_packages

    files = glob.glob("*/meta.yaml")
    packages_renaming = {}
    featured_packages_2 = {}
    for fnm in files:
        print "Post analysing",fnm
        f = open(fnm)
        lines = f.readlines()
        f.close()
        found_req = False

        f = open(fnm, "w")

        for l in lines:
            ## Let's go to the requirements section
            if l.find("requirements:")>-1:
                found_req = True
                print >>f, l.rstrip()
                print "found req section"
                continue
            if not found_req:
                print >>f, l.rstrip()
                continue
            ## Ok from now on let's see if one of these req is a "featured package"
            wrote_it = False
            for ft in featured_packages.keys():
                if l.find("- %s" %ft)>-1:  # ok it needs this 'featured package'
                    l2=l.replace("- %s" % ft, "- %s" % "-".join([ft,]+sorted(list(featured_packages[ft]))))
                    print >>f, l2.rstrip()
                    print "replaced requirement %s in package %s" % (ft,fnm)
                    wrote_it = True
                    if fnm not in packages_renaming.keys():
                        packages_renaming[fnm] = set()
                    for F in featured_packages[ft]:
                        packages_renaming[fnm].add(F)
                    break
            if not wrote_it:
                print >>f,l.rstrip()
        f.close()

    print packages_renaming


    for fnm in packages_renaming.keys():
        print "Post renaming",fnm
        f = open(fnm)
        lines = f.readlines()
        f.close()

        f = open(fnm, "w")

        for l in lines:
            if l.find("name:")>-1:
                sp = l.split("name:")
                name = sp[-1].strip()
                print "in name:",name
                sp2 = name.split("-")
                removed = []
                for ft in args.features:
                    if ft in sp2:
                        removed.append(ft)
                        sp2.remove(ft)
                clean_name = "-".join(sp2)
                print "cleaned name:",clean_name
                if not clean_name in featured_packages.keys():
                    featured_packages_2[clean_name]=set(removed+list(packages_renaming[fnm]))
                final_name = "-".join([clean_name,]+sorted(removed+list(packages_renaming[fnm])))
                print "final name:",final_name
                sp[-1]=" "+final_name
                print >>f, "name:".join(sp).rstrip()
            else:
                print >>f, l.rstrip()

    print "ok new ones:",featured_packages_2
    raw_input("press enter")
    featured_packages = featured_packages_2
