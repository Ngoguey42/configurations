# **************************************************************************** #
#                                                                              #
#                                                                              #
#    clean_path.py                                                             #
#                                                                              #
#    By: ngoguey <ngoguey@airware.com>                                         #
#                                                                              #
#    Created: 2017/04/14 21:04:24 by ngoguey                                   #
#    Updated: 2017/05/08 10:21:41 by ngoguey                                   #
#                                                                              #
# **************************************************************************** #

import subprocess, sys, os, collections

home = os.environ['HOME']
uname_transform = lambda n: n[0:5].upper()
uname = uname_transform(subprocess.check_output(["uname"]).decode('ascii'))
confdir = os.environ['NGOCONF_PATH']

# 1. ************************************************************************ **
# If present is removed
blacklist = set([
    '/cygdrive/c/Python36/Scripts',
    '/cygdrive/c/Python36',
    '/flexdll-bin-0.34',
])

# 2. ************************************************************************ **
# Present or not, those will be first, in list order
if uname == uname_transform('CYGWIN'):
    head = [
        # Languages ********************************************************* **
        # OCaml
        home + '/.opam/system/bin',
        '/usr/x86_64-w64-mingw32/sys-root/mingw/bin/',
        '/cygdrive/c/OCaml/bin',

        # Python
        '/cygdrive/c/Anaconda3',
        '/cygdrive/c/Anaconda3/Scripts',
        '/cygdrive/c/Anaconda3/Library/bin',

        # Attempt cuda 1
        # '/cygdrive/c/Anaconda3/DLLs',
        # '/cygdrive/c/Anaconda3/pkgs/cudatoolkit-8.0-3/DLLs',
        # '/cygdrive/c/Anaconda3/pkgs/cudnn-6.0-0/Library/lib/x64',
        # '/cygdrive/c/Anaconda3/pkgs/cudnn-6.0-0/Library/bin',

        # Attempt cuda 2
        '/cygdrive/c/CUDA8/bin',
        '/cygdrive/c/CUDA8/extras/CUPTI/libx64',
        '/cygdrive/c/CUDA8/lib/x64',


        # Misc
        '/cygdrive/c/R/bin',
        '/cygdrive/c/tools/dart-sdk/bin',
        '/cygdrive/c/ProgramData/Oracle/Java/javapath',
        # Soft ************************************************************** **
        # '/cygdrive/c/Program Files/Git/mingw64/bin/',
        '/cygdrive/c/ProgramData/chocolatey/bin',
        '/cygdrive/c/Program Files/Docker Toolbox',
        # Cygwin ************************************************************ **
        '/usr/local/bin',
        '/usr/bin',
        '/bin',
        '/sbin',
        '/usr/sbin',
        # Scripts *********************************************************** **
        confdir + '/scripts',
    ]
elif uname == uname_transform('LINUX'):
    head = [
        # Languages ********************************************************* **
        # Python
        home + '/anaconda3/bin',

        # Soft ************************************************************** **
        # Linux ************************************************************* **
        home + '/bin',
        home + '/.local/bin',
        '/usr/local/sbin',
        '/usr/local/bin',
        '/usr/sbin',
        '/usr/bin',
        '/sbin',
        '/bin',
        '/usr/games',
        '/usr/local/games',
        '/snap/bin',
        # Scripts *********************************************************** **
        confdir + '/scripts',
    ]
elif uname == uname_transform('DARWIN'):
    head = [
        # Languages ********************************************************* **
        # Python

        # Soft ************************************************************** **
        home + '/.brew/bin',

        # Macos ************************************************************* **
        '/usr/bin',
        '/bin',
        '/usr/sbin',
        '/sbin',
        '/usr/local/bin',
        '/usr/local/munki',
        '/opt/X11/bin',

        # Scripts *********************************************************** **
        confdir + '/scripts',
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
