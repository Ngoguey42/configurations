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

- install: spectacles, spotify, blender, office, gimp, sublime, adium

```sh
curl -L http://install.ohmyz.sh | sh
```
Reload xterm
```sh
git config --global credential.helper "cache --timeout=10800"
git config --global core.editor "emacs"
git config --global user.name "Ngoguey42"
git config --global user.email "ngoguey@student.42.fr"
#cd ; git clone https://github.com/Ngoguey42/configurations
cd /goinfre/ngoguey ; git clone https://github.com/Ngoguey42/configurations
cd configurations ; git pull origin master
git submodule init
git submodule update
cp dotemacs.el ~/.emacs
cp dotzshrc.sh ~/.zshrc
cp dotocamlinit ~/.ocamlinit
mkdir -p ~/Library/Caches/Homebrew/ /tmp/ngobrewtmp /tmp/ngobrewcache
echo ' let () =
	try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
		with Not_found -> ()
;;' > ~/.ocamlinit


time (mkdir ~/Library/Caches/Homebrew/ ; brew update ; brew upgrade makemake)

export HOMEBREW_TEMP="/tmp/ngobrewtmp"
export HOMEBREW_CACHE="/tmp/ngobrewcache"
time (rm -rf ~/.brew ~/Library/* /tmp/ngobrewtmp /tmp/ngobrewcache)
time (mkdir -p ~/Library/Caches/Homebrew/ /tmp/ngobrewtmp /tmp/ngobrewcache;)
time (/usr/local/bin/brew update ; rm -rf ~/Library/*)
export BREWTMP="$HOME/.brew/bin/brew"
time ($BREWTMP upgrade --all && $BREWTMP install ack python tree cloc freetype emacs tig julow/tap/makemake rlwrap homebrew/versions/glfw3 && $BREWTMP install ocaml --HEAD && $BREWTMP update && $BREWTMP upgrade --all)

(type cog || type cog.py) || (cd; curl -O https://pypi.python.org/packages/source/c/cogapp/cogapp-2.4.tar.gz && tar -zxvf cogapp-2.4.tar.gz && cd cogapp-2.4 && python setup.py install && cd && rm -rf cogapp-2.4 cogapp-2.4.tar.gz)

```
