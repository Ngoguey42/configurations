/!\ Now look at tezos's readme (new switch, depexts, make build-deps, make)

### From scratch, for logs branch

```bash
git checkout --track tarides/logs # Need remote
opam switch create 4.09.1
cd ~/Downloads
bash install-deps.sh # need the 2 files
```

```
The packages you requested declare the following system dependencies. Please make sure they are installed before retrying:
    hidapi lmdb
```

```bash
brew install hidapi
```

```
Warning: The post-install step did not complete successfully
You can try again using:
  brew postinstall hidapi
```

```bash
brew install lmdb
bash install-deps.sh # again

cd
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup toolchain install 1.44.0 # This version was required when I installed it a month ago on linux
rustup default 1.44.0

cd ~/r/tezos
./scripts/install_build_deps.rust.sh

# There are many libs to downgrade in order to make properly
opam install ppx_deriving_yojson
opam install irmin-pack=2.3.0
opam install data-encoding=0.2
opam install resto-cohttp=0.5
opam install lwt-canceler=0.2
opam install ff=0.4.0

make

# When running from macos in february
export TEZOS_NODE_DIR=/Users/nico/tz/data0; mkdir -p $TEZOS_NODE_DIR; ./tezos-node run 2>&1 | tee $TEZOS_NODE_DIR.txt | ack -v '("(Add|Find|Mem|Mem_tree|Remove)"|fold over data)'

# When running from comanche in april
export TEZOS_NODE_DIR=/data/ngoguey/data5; rm -rf $TEZOS_NODE_DIR $TEZOS_NODE_DIR.txt; mkdir -p $TEZOS_NODE_DIR; make && ./tezos-node run --rpc-addr localhost:4245 --net-addr localhost:4246 2>&1 | tee $TEZOS_NODE_DIR.txt | grep -Ev '("(Add|Find|Mem|Mem_tree|Remove)"|fold over data)'


```

### For up to date master branch
```bash
# need to stay on irmin-pack 2.3
opam install lwt-exit ppx_inline_test resto-acl irmin-mem=2.3.0 resto-cohttp-self-serving-client
opam update lwt-canceler data-encoding

```
