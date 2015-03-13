My config files...


Emacs bindings:

* C-t swap line UP
* C-^ swap line DOWN

<BR>

* f1 input debug minimal code (adaptative c cpp php)
* f3 minimal function
* f7 cpp getters
* shift-f7 hpp getters
* f8 c-main ac/av
* shift-f8 c-main void
* f9 coplien minimal code cpp
* f10 coplien minimal code hpp

<BR>

* \<kp-7\> dup-line
* \<kp-6\> TOUNSET
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

- curl -L http://install.ohmyz.sh | sh
- cd ; git clone https://github.com/Ngoguey42/configurations
- cd configurations
- cp dotemacs ~/.emacs
- cp dotzshrc ~/.zshrc
- git submodule init
- git submodule update
- brew install ack
- brew install emacs
- brew install tig
- (install bitnami mamp)

