#My config files

##Emacs
##### Some emacs functions

##At school Macos

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
```
---
---
#### New mac
##### Managed Software Center
1. spectacle, spotify
2. excel, slack, docker
3. blender, gimp, XQuartz

##### shell
```sh
cd /nfs/2014/n/ngoguey/goinfre
git clone https://github.com/Ngoguey42/mkgen
git clone https://github.com/Ngoguey42/configurations
cd configurations ; git pull origin master
git submodule init
git submodule update
cp dotemacs.el ~/.emacs
cp dotminttyrc ~/.minttyrc
cp dotzshrc.sh ~/.zshrc
cp dotocamlinit.ml ~/.ocamlinit
mkdir -p ~/Library/Caches/Homebrew/ /tmp/ngobrewtmp /tmp/ngobrewcache
. ~/.zshrc
# rm -rf "$HOME/Library/Application Support/Google/"

```
---
---
#### Nuke brew and opam, reinstall
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
---
---
#### Misc
```sh
rm -f /tmp/slock /tmp/lock ~/.opam/lock ~/.opam/system/lock; touch /tmp/slock; touch /tmp/lock; ln -s /tmp/lock ~/.opam/lock; ln -s /tmp/slock ~/.opam/system/lock
```
---
---
#### Cog (python required in brew)
```sh
(type cog || type cog.py) || (cd; curl -O https://pypi.python.org/packages/source/c/cogapp/cogapp-2.4.tar.gz && tar -zxvf cogapp-2.4.tar.gz && cd cogapp-2.4 && python3 setup.py install && cd && rm -rf cogapp-2.4 cogapp-2.4.tar.gz)

```

## At home Cygwin

##### mintty setup
- shortcut: `C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico  /bin/zsh --login`
- font: consolas, pt8

## At home Linux
