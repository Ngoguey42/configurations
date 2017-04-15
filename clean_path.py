# **************************************************************************** #
#                                                                              #
#                                                                              #
#    clean_path.py                                                             #
#                                                                              #
#    By: ngoguey <ngoguey@airware.com>                                         #
#                                                                              #
#    Created: 2017/04/14 21:04:24 by ngoguey                                   #
#    Updated: 2017/04/15 13:50:05 by ngoguey                                   #
#                                                                              #
# **************************************************************************** #

import subprocess, sys, os, collections

home = os.environ['HOME']

# 1. ************************************************************************ **
# If present is removed
blacklist = set([
    '/cygdrive/c/Python36/Scripts',
    '/cygdrive/c/Python36',
    '/flexdll-bin-0.34',
])

# 2. ************************************************************************ **
# Present or not, those will be first, in list order
head = [
    # Languages ************************************************************* **
    # OCaml
    home + '/.opam/system/bin',
    '/usr/x86_64-w64-mingw32/sys-root/mingw/bin/',
    '/cygdrive/c/OCaml/bin',

    # Python
    '/cygdrive/c/Anaconda3',
    '/cygdrive/c/Anaconda3/Scripts',
    '/cygdrive/c/Anaconda3/Library/bin',

    # Misc
    '/cygdrive/c/R/bin',
    '/cygdrive/c/tools/dart-sdk/bin',
    '/cygdrive/c/ProgramData/Oracle/Java/javapath',
    # Soft ****************************************************************** **
    '/cygdrive/c/ProgramData/chocolatey/bin',
    '/cygdrive/c/Program Files/Docker Toolbox',
    # Cygwin **************************************************************** **
    '/usr/local/bin',
    '/usr/bin',
    '/bin',
    '/sbin',
    '/usr/sbin',
]

# 3. ************************************************************************ **
# All other will be appended to the path

# CODE ********************************************************************** **
def unique(self):
    """http://stackoverflow.com/a/480227/4952173"""
    seen = set()
    return [x for x in self if not (x in seen or seen.add(x))]

def create_tail_inplace(l):
    """Create tail, keeping it ordered as in original PATH"""
    l = unique(l)
    s = set(l)
    s -= blacklist
    s -= set(head)
    return [x for x in l if x in s]

l = os.environ['PATH'].split(':')
tail = create_tail_inplace(l)
newpath = ':'.join(head + tail)

sys.stdout.write(newpath)
