#!/usr/bin/env python

from optparse import OptionParser

parser = OptionParser()
parser.add_option("-p", "--prefixes", dest="prefixes")
parser.add_option("-s", "--suffixes", dest="suffixes")
parser.add_option("-c", "--current-version", dest="current_version")


def bump(current_version, prefixes, suffixes):

    found_prefix = ''
    found_suffix = ''

    found_version = current_version
    for p in prefixes:
        if current_version.startswith(p):
            found_prefix = p
            found_version = found_version[len(p):]

    for s in suffixes:
        if current_version.endswith(s):
            found_suffix = s
            found_version = found_version[:-len(s)]

    parts = found_version.split('.')

    pos = -1
    parts[pos] = str(int(parts[pos]) + 1)

    return "{}{}{}".format(found_prefix, ".".join(parts), found_suffix)


if __name__ == '__main__':
    (options, args) = parser.parse_args()

    prefixes = []
    if options.prefixes:
        prefixes = options.prefixes.split(',')

    suffixes = []
    if options.suffixes:
        suffixes = options.suffixes.split(',')

    current_version = options.current_version

    print(bump(current_version=current_version, prefixes=prefixes, suffixes=suffixes))





