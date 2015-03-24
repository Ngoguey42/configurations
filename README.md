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

- cd ; git clone https://github.com/Ngoguey42/configurations
- cd configurations
- git submodule init
- git submodule update
- cp dotemacs ~/.emacs
- brew install emacs

- cp dotzshrc ~/.zshrc
- curl -L http://install.ohmyz.sh | sh
- brew install ack
- brew install tig
- (install bitnami mamp)
- (install spectacles)
