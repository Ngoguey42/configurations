`>My config files...

<BR>

* f1 input debug minimal code (adaptative c cpp php)
* f5 import class from .cpp's .hpp
* shift-f5 import class from any hpp
* f8 c-main ac/av
* shift-f8 c-main void
* f9 new var/function with indentation
* f10 hpp/cpp file initialization

<BR>
Installation process from scratch (at school)

- install: spectacles, spotify, blender, office, gimp, sublime3

```sh
# Install config on new home

curl -L http://install.ohmyz.sh | sh
# Reload iterm2
git config --global credential.helper "cache --timeout=10800"
git config --global core.editor "emacs"
git config --global user.name "Ngoguey42"
git config --global user.email "ngoguey@student.42.fr"


# Install config on new mac

cd /nfs/2014/n/ngoguey/goinfre
git clone https://github.com/Ngoguey42/mkgen
git clone https://github.com/Ngoguey42/configurations
cd configurations ; git pull origin master
git submodule init
git submodule update
cp dotemacs.el ~/.emacs
cp dotzshrc.sh ~/.zshrc
cp dotocamlinit ~/.ocamlinit
mkdir -p ~/Library/Caches/Homebrew/ /tmp/ngobrewtmp /tmp/ngobrewcache
# Reload iterm2
# rm -rf "$HOME/Library/Application Support/Google/"


# Nuke brew and opam, reinstall

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



# install cog with python installed through brew

(type cog || type cog.py) || (cd; curl -O https://pypi.python.org/packages/source/c/cogapp/cogapp-2.4.tar.gz && tar -zxvf cogapp-2.4.tar.gz && cd cogapp-2.4 && python3 setup.py install && cd && rm -rf cogapp-2.4 cogapp-2.4.tar.gz)

```
