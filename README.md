
<br/>

----
----

## At school `Macos`

#### New home
##### Macos
- keyboard
- mouse
- session lock

##### Iterm 2
- keyboard with keypad
- command-left, command-right

##### shell
```sh
curl -L http://install.ohmyz.sh | sh
git config --global credential.helper "cache --timeout=10800"
git config --global core.editor "emacs"
git config --global user.name "Ngoguey42"
git config --global user.email "ngoguey@student.42.fr"
/usr/local/bin/brew update
/usr/local/bin/brew update
~/.brew/bin/brew update
~/.brew/bin/brew update
~/.brew/bin/brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/ecc7bdd8435ec3965ac7095efdead3bb49f378ed/Formula/emacs.rb ack tree cloc tig tmux python3 libyaml
~/.brew/bin/brew update
~/.brew/bin/brew update
~/.brew/bin/pip3 install tmuxp


#sh -c "$(curl -fsSL https://raw.githubusercontent.com/kube/42homebrewfix/master/install.sh)"
```

----
----

#### New mac
##### Managed Software Center
1. spectacle, spotify
2. excel, slack, docker
3. blender, gimp, XQuartz

##### shell
```sh
cd /Volumes/Storage/goinfre/ngoguey
git clone https://github.com/Ngoguey42/mkgen
git clone https://github.com/Ngoguey42/configurations
cd configurations ; git pull origin master
git submodule init
git submodule update
cp dotemacs.el ~/.emacs
cp dotminttyrc.conf ~/.minttyrc
cp dotocamlinit.ml ~/.ocamlinit
cp dotzshrc.sh ~/.zshrc
mkdir -p ~/Library/Caches/Homebrew/ /tmp/ngobrewtmp /tmp/ngobrewcache
. ~/.zshrc
cd; ln -s /Users/Shared
```

##### Misc
```
# rm -rf "$HOME/Library/Application Support/Google/"
nohup "/Applications/Spotify.app/Contents/MacOS/Spotify"&
```

<br/>

----
----

## At home `Cygwin`

#### Windows install
- chocolatey
- cygwin64

#### Install cygwin setup x86_64
- zsh
- tree
- tig
- rlwrap
- nc
- make
- mintty
- "gcc-core"+"gcc-g++" same version
- mingw64?
- emacs 25
- curl
- ncurses
- wget
- git

<br/>

- coreutils
- binutils
- pkg-config
- terminfo
- openssh
- openssl
- tar

#### Chocolatey (choco list --local-only)
- choco install dart-sdk
- choco install python3

#### Manual (`./configure && make && make install`)
- ack https://beyondgrep.com/
- winpty https://github.com/rprichard/winpty required for ipython
- ocaml? todo
- opencv? todo

#### pip (use virtualenv?)
- pip install ipython ipython jupyter numpy pandas
- numpy
 - "numpy+mkl" (Intel® Math Kernel Library) is required for scipy
 - http://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy
 - 120MB !!!
 - pip install PATHTOFILE
- scipy
 - http://stackoverflow.com/questions/28190534/windows-scipy-install-no-lapack-blas-resources-found
 - http://www.lfd.uci.edu/~gohlke/pythonlibs/#scipy
 - 12MB
 - pip install PATHTOFILE
- pip install pyreadline?

#### opam
- todo

<br/>

----
----

## At home `Linux`
- todo

<br/>

----
----

## DEPRECATED

#### Nuke brew and opam, reinstall (DEPRECATED)
```sh
export HOMEBREW_TEMP="/tmp/""$USER""brewtmp"
export HOMEBREW_CACHE="/tmp/""$USER""brewcache"
time (
export BREWTMP="$HOME/.brew/bin/brew"
export OPAMTMP="$HOME/.brew/bin/opam"
rm -rf ~/.brew ~/Library/* $HOMEBREW_TEMP $HOMEBREW_CACHE ~/.opam; echo "RM done"
mkdir -p ~/Library/Caches/Homebrew/ $HOMEBREW_TEMP $HOMEBREW_CACHE; echo "MKDIR done"
/usr/local/bin/brew update ; rm -rf ~/Library/*; echo "init done"

$BREWTMP upgrade --all
$BREWTMP install --build-from-source ocaml
$BREWTMP install rlwrap opam
$BREWTMP install ack tree cloc tig emacs julow/tap/makemake
$BREWTMP install freetype homebrew/versions/glfw3 python3
$BREWTMP update && $BREWTMP update && $BREWTMP upgrade --all

$OPAMTMP init -n
~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true ; eval `opam config env`
$OPAMTMP switch 4.02.3
~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true ; eval `opam config env`
$OPAMTMP install -y core yojson
)
```

##### Lock problems (DEPRECATED)
```sh
rm -f /tmp/slock /tmp/lock ~/.opam/lock ~/.opam/system/lock; touch /tmp/slock; touch /tmp/lock; ln -s /tmp/lock ~/.opam/lock; ln -s /tmp/slock ~/.opam/system/lock
```

##### Cog (python required in brew) (DEPRECATED)
```sh
(type cog || type cog.py) || (cd; curl -O https://pypi.python.org/packages/source/c/cogapp/cogapp-2.4.tar.gz && tar -zxvf cogapp-2.4.tar.gz && cd cogapp-2.4 && python3 setup.py install && cd && rm -rf cogapp-2.4 cogapp-2.4.tar.gz)
```
