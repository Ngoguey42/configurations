export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ZSH CONFIG
zstyle ':completion:*:*:emacs:*:*files' ignored-patterns '*.o' '*.cmx' '*.cmi' '*.cmo'
export ZSH_THEME_GIT_PROMPT_PREFIX="%{\e[01;34m%}%{\e[31m%}"
export ZSH_THEME_GIT_PROMPT_CLEAN="%{\e[34m%}"
export ZSH_THEME_GIT_PROMPT_DIRTY="%{\e[33m%}"

# CONFIG FILES EDITION
alias zshconf="e $NGOCONF_PATH/zsh_conf.sh"
alias matrix="source ~/.zshrc"
alias econf="e $NGOCONF_PATH/my_config.el"

# FILES EXPLORATION
MYEXTENSIONS="cpp|hpp|c|h|php|tpp|ml|mli|vert|frag|geom|tesc|tese|glsl|xml|lua|py|R|dart|sh|html|css"
alias cloc='cloc --force-lang="C++",tpp --force-lang="HLSL",glsl --force-lang="HLSL",frag --force-lang="HLSL",geom --force-lang="HLSL",tese --force-lang="HLSL",tesc --force-lang="HLSL",vert'
alias wccool='_(){ cat $@ | ack -v "^\s*(//|/\*|\*)"| ack -v "^\s*$" | wc; }; _'

# OCAML
alias o="rlwrap --prompt-colour=green ocaml"
alias of="rlwrap --prompt-colour=green ocaml -init "
alias oc="ocamlopt.opt"
alias ocl="
printf '\033[31m' ;rm -r ./*.cmi && echo '\033[32mrm ./*.cmi'
printf '\033[31m' ;rm -r ./*.cmo && echo '\033[32mrm ./*.cmo'
printf '\033[31m' ;rm -r ./*.cmx && echo '\033[32mrm ./*.cmx'
printf '\033[31m' ;rm -r ./*.o && echo '\033[32mrm ./*.o'
printf '\033[0m'"
alias oclr="
printf '\033[31m' ;rm -r **/*.cmi && echo '\033[32mrm **/*.cmi'
printf '\033[31m' ;rm -r **/*.cmo && echo '\033[32mrm **/*.cmo'
printf '\033[31m' ;rm -r **/*.cmx && echo '\033[32mrm **/*.cmx'
printf '\033[31m' ;rm -r **/*.o && echo '\033[32mrm **/*.o'
printf '\033[0m'"
alias ok='ocamlopt graphics.cmxa -i *.ml && ocamlopt graphics.cmxa *.ml && ocl && ./a.out'
alias okt='rr ; ocamlopt.opt *.ml && printf "\033[33m" && ocamlopt -i *.ml && printf "\033[0m" && time ./a.out && rm a.out && ocl'
alias oktf='rr ; ocamlfind ocamlcp *.ml -package yojson -package core -thread -linkpkg && printf "\033[33m" && ocamlfind ocamlc -i *.ml -package yojson -package core -thread -linkpkg && printf "\033[0m" && time ./a.out && rm a.out && ocl'
alias oktfna='rr ; ocamlfind ocamloptp *.ml -package yojson -package core -thread -linkpkg && printf "\033[33m" && ocamlfind ocamlc -i *.ml -package yojson -package core -thread -linkpkg && printf "\033[0m" && time ./a.out && rm a.out && ocl'

# GIT RELATED
export USER="ngoguey"
export MAIL="ngoguey@airware.com"
# export MAIL="ngoguey@student.42.fr"
alias gitals="git add \`git ls-files\` ; git status"
alias gitls="git ls-files"
alias gitac="git add \`ls -1 **/*.($MYEXTENSIONS)\` ; git status"
alias gitpom="git pull origin master"
alias gits="git status"
alias gitcm="git commit -m"
alias gitcmf="git commit -F"
alias gitck="git checkout"
alias gitf="git fetch ; git status"
alias gitcl="git clean -xn"
alias gitclF="git clean -xf"
alias gitcld="git clean -xdn"
alias gitcldF="git clean -xdf"
alias groot='git rev-parse --show-toplevel'

# MISC
alias makevar='make -pn nosuchrule 2>/dev/null | grep -A1 "^# makefile"| grep -v "^#\|^--" | sort | uniq'
alias scopcog="
cog.py -I conf -rU include/configuration/cog_enums.h
cog.py -I conf -rU include/configuration/cog_meshfill.h
cog.py -I conf -rU srcs/configuration/cog_loadconf1.c
cog.py -I conf -rU srcs/configuration/cog_loadconf2.c
cog.py -I conf -rU srcs/configuration/cog_meshfill1.c
cog.py -I conf -rU srcs/configuration/cog_meshfill2.c
"
alias lret="echo $?"
alias save="pwd | cat > ~/.save_pwd"
alias go="cd \`cat ~/.save_pwd\` ; clear"
alias rr="
printf '\033[31m' ;rm **/*~ 2>/dev/null && echo '\033[32mrm **/*~'
printf '\033[31m' ;rm **/\#* && echo '\033[32mrm **/\#*'
printf '\033[31m' ;rm **/*.stackdump && echo '\033[32mrm **/*.stackdump'
printf '\033[31m' ;rm **/nohup.out && echo '\033[32mrm **/nohup.out'
printf '\033[31m' ;rm **/.\#* && echo '\033[32mrm **/.\#*'
printf '\033[31m' ;rm -r **/.DS_Store && echo '\033[32mrm **/.DS_Store'
printf '\033[31m' ;rm -r **/*.dSYM && echo '\033[32mrm **/*.dSYM'
printf '\033[0m'"
alias ch="chmod 644 \`ls -1d *.($MYEXTENSIONS)\` ; chmod 644 \`ls -1d *.h\`; chmod 744 Makefile ; chmod 644 auteur ; l"
alias chr="chmod 644 \`ls -1d **/*.($MYEXTENSIONS)\` ; chmod 744 Makefile ; chmod 644 auteur ; lr"

mywhere() {
    f(){
	for var in "$@"
	do
	    echo '********************'
	    if ! whence $var 1>/dev/null; then
		echo "$var not found"
		continue
	    fi

	    whence_asv=()
	    whence -aSv $var 2>/dev/null | while read line ; do
		whence_asv+=($line)
	    done

	    whence_a=()
	    whence -a $var | while read line ; do
		whence_a+=($line)
	    done

	    for ((i=1;i<=${#whence_a[@]};i++)); do
		p="${whence_a[$i]}"
		desc="${whence_asv[$i]}"
		v=$($p --version 2>&1 | grep -o '[0-9][^ \t]*\.[^ \t]*[0-9]' | tr '\n' '/')
		echo "$desc ($v)"
	    done
	done
    }

    f pub dart2js \
      ocaml ocamlc opam \
      pip pip3 python python3 ipython conda \
      R rScript \
      emacs emacs25 e \
      brew

    echo '********************'
}

# SHLVL ********************************************************************* **
if [[ $SHLVL -ge 2 ]]; then
    CHARS=`printf '+%.0s' {1..$(($SHLVL - 1))}`
    export PROMPT="$CHARS $PROMPT"
fi

# LOCATION SPECIFIC ********************************************************* **
UNAME=`uname | cut -c1-6`

alias dumpsizeof="sh $NGOCONF_PATH/dump_sizeof.sh" #TODO: improve
if [ "$UNAME" = "Linux" ]
then
    alias spotify="nohup spotify &"
    EDITOR="/usr/bin/emacs25 -nw"
    export PATH="`/usr/bin/python -u $NGOCONF_PATH/clean_path.py`"
    source activate redbird
    alias termvert6="nohup terminator -b -l vert6 &"
    alias termvert2="nohup terminator -b -l vert2 &"
    alias termhoriz6="nohup terminator -b -l horiz6 &"
    alias l="ls -gohFG --color"
    alias open='gnome-open 2>/dev/null'
fi

if [ "$UNAME" = "CYGWIN" ]
then
    # export DISABLE_AUTO_TITLE=true
    EDITOR="emacs"
    alias open="cygstart.exe"
    alias clear='printf "\033c"'
    alias l="ls -gohFG --color"
    export PATH="`/usr/bin/python -u $NGOCONF_PATH/clean_path.py`"

    export CAML_LD_LIBRARY_PATH="$HOME/.opam/system/lib/stublibs:/cygdrive/c/OCaml/lib/stublibs"
    export MANPATH="$HOME/.opam/system/man:$MANPATH"
    export CAMLP4LIB="C:/OCaml/lib/camlp4"
    # . /home/Ngo/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
    # eval `opam config env`
    alias pub="/cygdrive/c/tools/dart-sdk/bin/pub.bat"
    alias dart2js="/cygdrive/c/tools/dart-sdk/bin/dart2js.bat"
    alias ipython="winpty ipython"
    alias ocaml="winpty ocaml"
fi

if [ "$UNAME" = "Darwin" ]
then
    alias l="ls -gohFG"

    # TODO: check those 3 lines under macos
    export C_INCLUDE_PATH="$HOME/.brew/include:$HOME/.brew/include/freetype2"
    export CPLUS_INCLUDE_PATH="$HOME/.brew/include:$HOME/.brew/include/freetype2"
    export LIBRARY_PATH="$HOME/.brew/lib"

    alias tig="~/.brew/bin/tig/"
    EDITOR="emacs"
    export PATH="$HOME/.brew/bin:$NGOCONF_ROOT/mkgen:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
    export HOMEBREW_TEMP="/tmp/ngobrewtmp"
    export HOMEBREW_CACHE="/tmp/ngobrewcache"
    # . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
    # eval `opam config env`
    alias ack="~/.brew/bin/ack"
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk --args 'file://'`pwd`'/' 2>/dev/null"
    alias chromegit="$NGOCONF_PATH/chromegit.sh"
    alias kic='ls -dltu /nfs/z*/*/*/* |  awk  '"'"'{printf "%15s (%s) %3s %2s %s\n", $3, $4, $6, $7, $8}'"'"' | rev | uniq -f4 | rev'
    alias qui='_(){ ldapsearch uid="$1" ; }; _'

    alias cddown="cd ~/Downloads/"
    alias cddesk="cd ~/Desktop/"
    alias cddocs="cd ~/Documents/"

fi

# POST - LOCATION SPECIFIC ************************************************** **
alias e="$EDITOR"

# SSH *********************************************************************** **
export SSH_TIMEOUT_DEFAULT=$((5 * 60))
if [[ -n "$SSH_AGENT_PID" ]]; then

    if [[ -z "$SSHTO" ]]; then # SSHTO aka `ssh time out`
	export SSHTO=$SSH_TIMEOUT_DEFAULT
    fi
    UNAME=`uname | cut -c1-6`
    if [ "$UNAME" = "Darwin" ]
    then
	SSHTO_FORMAT=`date -u -r $SSHTO +"%T"`
    else
	SSHTO_FORMAT=`date -u -d@$SSHTO +"%T"`
    fi

    echo "Enter passphrase valid for ($SSHTO_FORMAT)"
    ssh-add -t $SSHTO || exit

    NOW=`date +%s`
    export SSH_TIMEOUT_THEN=$(($NOW + $SSHTO))
    export PROMPT="\$(sh $NGOCONF_PATH/promptssh.sh) $PROMPT"
fi
