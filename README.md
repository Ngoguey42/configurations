My config files...


Emacs shortcuts:

* C-t swap line UP
* C-^ swap line DOWN

<BR>

* f1 input debug minimal code (adaptative c cpp php)
* f5 import class from .cpp's .hpp
* shift-f5 import class from any hpp
* f8 c-main ac/av
* shift-f8 c-main void
* f9 new var/function with indentation
* f10 hpp/cpp file initialization

<BR>

* \<kp-7\> dup-line
* \<kp-1\> cutline
* \<kp-0\> pasteline
* 
* \<kp-8\> replace-string
* \<kp-9\> goto-line
* 
* \<kp-5\> web-mode comment
* \<kp-6\> comment region(without web-mode)
* \<kp-3\> comment line(without web-mode)
* 
* \<kp-divide\> indent whole buffer
* \<kp-substract\> jump paragraph forward
* \<kp-add\> jump paragraph forward

Installation process from scratch (at school)


- (install spectacles)

- curl -L http://install.ohmyz.sh | sh

Reload xterm

- git config --global credential.helper "cache --timeout=10800"
- git config --global user.name "Ngoguey42"
- git config --global user.email "ngoguey@student.42.fr"
- cd ; git clone https://github.com/Ngoguey42/configurations
- cd configurations
- git submodule init
- git submodule update
- cp dotemacs ~/.emacs
- cp dotzshrc ~/.zshrc

- time (rm -rf ~/.brew && rm -rf ~/Library/Caches/Homebrew/ && brew update && brew upgrade --all && mkdir ~/Library/Caches/Homebrew/ && brew install ack && brew install homebrew/versions/glfw3 && brew install nasm && brew install sdl2 && brew install sfml && brew install emacs && brew install tig && brew update && brew upgrade --all)
- time (rm -rf ~/.brew && rm -rf ~/Library/Caches/Homebrew/ && brew update && brew upgrade --all && mkdir ~/Library/Caches/Homebrew/ && brew install ack emacs tig julow/tap/makemake && brew update && brew upgrade --all)
- time (rm -rf ~/.brew && rm -rf ~/Library/Caches/Homebrew/ && brew update && brew upgrade --all && mkdir ~/Library/Caches/Homebrew/ && brew install ack emacs tig julow/tap/makemake python homebrew/versions/glfw3 && brew update && brew upgrade --all)
