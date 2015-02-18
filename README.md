My config files.

curl -L http://install.ohmyz.sh | sh
git clone https://github.com/Ngoguey42/configurations
cd configurations
cp dotemacs ~/.emacs
cp .zshrc ..
git submodule init
git submodule update

brew install ack
brew install emacs
brew install tig




