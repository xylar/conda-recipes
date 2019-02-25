#!/usr/bin/env python                                                                                              
import argparse
import os
import sys
import re
import subprocess
import shlex
import traceback

parser = argparse.ArgumentParser(
    description='remove your anaconda pkgs',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-c", "--channel", help="conda channel, ex: cdat/label/unstable")
parser.add_argument("-p", "--packages", help="conda packages, ex: 'thermo cdutil'",
                    default=None)
parser.add_argument("-R", "--regex", default=None,
                    help="regex to match with version, ex: '.*2016.*', '.*(2016|2017).*'")

parser.add_argument("-d", "--dryrun", default=False, action="store_true",
                    help="dry run do not actually do anything, just list out the packages")

args = parser.parse_args(sys.argv[1:])

channel = args.channel
packages = args.packages
regex = args.regex
if regex:
    regex = re.compile(args.regex.replace("\!","!"))

regex=args.regex
dryrun = args.dryrun

print("args, channel: {c}".format(c=channel))
print("args, packages: {p}".format(p=packages))
print("args, regex: {r}".format(r=regex))
print("args, dryrun: {d}".format(d=dryrun))

def match_regex(my_string):
    m = regex.match(my_string)
    return m is not None


def run_command(cmd, join_stderr=True, shell_cmd=False, verbose=True, cwd=None):
    if verbose:
        print("CMD: {c}".format(c=cmd))
    if isinstance(cmd, str):
        cmd = shlex.split(cmd)

    if join_stderr:
        stderr_setting = subprocess.STDOUT
    else:
        stderr_setting = subprocess.PIPE

    if cwd is None:
        current_wd = os.getcwd()
    else:
        current_wd = cwd

    P = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=stderr_setting,
        bufsize=0, cwd=current_wd, shell=shell_cmd)
    out = []
    while P.poll() is None:
        read = P.stdout.readline().rstrip()
        decoded_str = read.decode('utf-8')
        out.append(decoded_str)
        if verbose == True:
            print(decoded_str)

    ret_code = P.returncode
    return(ret_code, out)

def get_packages(channel, packages, regex, older_than):

    cmd = "conda search --override -c {c}".format(c=channel)
    pkgs = []
    ret_code, out = run_command(cmd, True, False, True)
    for p in out:
        include_pkg = False
        if packages:
            m = re.search(r"^{pkgs}\s+\S+\s+\S+\s+\S+".format(pkgs=packages), p)
            if m:
                include_pkg = True
        if regex:
            m1 = re.match(r"^\S+\s+{r}\s+\S+\s+\S+".format(r=regex), p)
            if m1:
                include_pkg = True

        if include_pkg:
            if older_than:
                # check if it satisfies time contraint if specified
                m2 = re.(r"^\S+\s+(\S+)\s+\S+\s+\S+", p)
                version = m2.group(1)
                print("xxx version: {v}".format(v=version))
            else:
                pkgs.append(p)


    return pkgs



def do_remove(pkgs):

    for p in pkgs:        
        m = re.match(r'(\S+)\s+(\S+)\s+(\S+)\s+(\S+)', p)
        pkg = m.group(1)
        version = m.group(2)
        channel = m.group(4)
        m1 = re.match(r'(\S+)/\S+/\S+', channel)
        channel_name = m1.group(1)
        pkg_to_remove = "{c}/{p}/{v}".format(c=channel_name,
                                             p=pkg,
                                             v=version)
        print("Going to remove: {p}".format(p=pkg_to_remove))

def check_if_pkg_satisfies_constraint(pkg_version, older_than):
    

#pkgs = get_packages(channel, packages, regex)

#if args.dryrun:
#    sys.exit(0)

#do_remove(pkgs)

my_str = "8.0.2018.07.30.22.03.g70b6163 py36_0"
m = re.match(r'.*.(\d+).(\d+).(\d+).\d+.\d+.\S+\s+', my_str)
if m:
    year = m.group(1)
    month = m.group(2)
    day = m.group(3)
    print("xxx year: {y}, month: {m}, day: {d}".format(y=year,
                                                       m=month,
                                                       d=day))



# python ./remove_anaconda_pkgs.py -c cdat/label/linatest  -R ".*(2018|2019).*"
