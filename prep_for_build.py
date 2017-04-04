#!/usr/bin/env python
import argparse
import sys
import glob
import time


l = time.localtime()
today = "%s.%s.%s.{{ GIT_FULL_HASH }}" % (l.tm_year, l.tm_mon, l.tm_mday)

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
    f = open(fnm)
    s = f.read()
    f.close()
    s = s.replace("@UVCDAT_BRANCH@", args.branch)
    s = s.replace("@BUILD_NUMBER@", args.build)
    s = s.replace("@VERSION@", args.version)
    s = s.replace("{{","$$$CRAP$$$")
    # Now we deal with features
    lines = []
    features_used = set()
    for l in s.split("\n"):
        addline = True
        for f in args.features:
            if l.find("!{%s}" % f) > -1:  # skip for this feature
                addline = False
            elif l.find("{%s}" % f) > -1:
                features_used.add(f)
            # other feature but NOT this one line
            elif l.find("{%s}" % f) == -1 and l.find("{") > -1:
                addline = False
        ## Ok now is there a feature on that line that we did not enable
        if l.find(" {")>-1: # feature line
            ft = l.split("{")[1].split("}")[0].strip()
            if not ft in args.features:
                addline = False
        if addline:
            # Sanitize the features out of the line
            while l.find("!{") > -1:
                i = l.find("!{")
                j = l[i:].find("}")
                l = l[:i] + l[i + j + 1:]
            while l.find("{") > -1:
                i = l.find("{")
                j = l[i:].find("}")
                l = l[:i] + l[i + j + 1:]
            lines.append(l)
    f = open(fnm[:-3], "w")
    for l in lines:
        l = l.replace("{{","$$$CRAP$$$")
        # Is it a name line?
        if l.find("name:") > -1:
            sp = l.split("name:")
            original_name = sp[-1].strip()
            sp[-1] = "-".join([sp[-1]] + sorted(list(features_used)))
            mystr = "name:".join(sp).rstrip()
        else:
            mystr = l.rstrip()
        print >> f, mystr.replace("$$$CRAP$$$","{{")
    f.close()
    if len(features_used) > 0:
        featured_packages[original_name] = features_used

already_fixed_names = []
while len(featured_packages.keys()) > 0:
    print "FEATURED PACKAGES", featured_packages

    files = glob.glob("*/meta.yaml")
    packages_renaming = {}
    featured_packages_2 = {}
    for fnm in files:
        f = open(fnm)
        lines = f.readlines()
        f.close()
        found_req = False

        f = open(fnm, "w")

        for l in lines:
            l = l.replace("{{","$$$CRAP$$$")
            # Let's go to the requirements section
            if l.find("requirements:") > -1:
                found_req = True
                print >>f, l.rstrip().replace("$$$CRAP$$$","{{")
                continue
            if not found_req:
                print >>f, l.rstrip().replace("$$$CRAP$$$","{{")
                continue
            # Ok from now on let's see if one of these req is a "featured
            # package"
            wrote_it = False
            for ft in featured_packages.keys():
                # ok it needs this 'featured package'
                if l.find("- %s" % ft) > -1:
                    indx = l.find("- %s" % ft)
                    if indx + 2 + len(ft) >= len(l):
                        continue
                    elif l[indx + 2 + len(ft)].isalnum():
                        continue
                    has_feature = False
                    for F in args.features:
                        if F in l.split("-"):
                            has_feature = True
                            break
                    if has_feature:
                        continue

                    sp = l.split("[")
                    nm = "-".join([ft, ] + sorted(list(featured_packages[ft])))
                    sp2 = sp[0].split("-")
                    sp[0] = sp2[0] + "- " + nm
                    l2 = "[".join(sp)
                    print >>f, l2.rstrip().replace("$$$CRAP$$$","{{")
                    wrote_it = True
                    if fnm not in packages_renaming.keys():
                        packages_renaming[fnm] = set()
                    for F in featured_packages[ft]:
                        packages_renaming[fnm].add(F)
                    break
            if not wrote_it:
                print >>f, l.rstrip().replace("$$$CRAP$$$","{{")
        f.close()

    # print packages_renaming

    for fnm in packages_renaming.keys():
        # print "Post renaming",fnm
        f = open(fnm)
        lines = f.readlines()
        f.close()

        f = open(fnm, "w")

        for l in lines:
            l = l.replace("{{","$$$CRAP$$$")
            if l.find("name:") > -1:
                sp = l.split("name:")
                name = sp[-1].strip()
                sp2 = name.split("-")
                removed = set()
                for ft in args.features:
                    while ft in sp2:
                        removed.add(ft)
                        sp2.remove(ft)
                clean_name = "-".join(sp2)
                # print "cleaned name:",clean_name
                if clean_name not in featured_packages.keys(
                ) and clean_name not in already_fixed_names:
                    featured_packages_2[clean_name] = set(
                        list(removed) +
                        list(
                            packages_renaming[fnm]))
                    already_fixed_names.append(clean_name)
                final_name = "-".join([clean_name, ] +
                                      sorted(list(set(list(removed) +
                                                      list(packages_renaming[fnm])))))
                if final_name != clean_name:
                    print "final name:", final_name, clean_name
                sp[-1] = " " + final_name
                print >>f, "name:".join(sp).rstrip().replace("$$$CRAP$$$","{{")
            else:
                print >>f, l.rstrip().replace("$$$CRAP$$$","{{")

    featured_packages = featured_packages_2
