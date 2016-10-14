# path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.


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
MYEXTENSIONS="cpp|hpp|c|h|php|tpp|ml|mli|vert|frag|geom|tesc|tese|glsl|xml|lua|py"
alias l="ls -gohFG"

alias cloc='cloc --force-lang="C++",tpp --force-lang="HLSL",glsl --force-lang="HLSL",frag --force-lang="HLSL",geom --force-lang="HLSL",tese --force-lang="HLSL",tesc --force-lang="HLSL",vert'

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
export MAIL="ngoguey@student.42.fr"
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
export PROMPT="$PROMPT\$(sh $NGOCONF_PATH/append_prompt.sh) "
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

alias psi='ps | grep -v zsh | grep -v emacs'

alias ev="type emacs; echo ; emacs -version ; echo"


# LOCATION SPECIFIC
UNAME=`uname | cut -c1-6`

alias dumpsizeof="sh $NGOCONF_PATH/dump_sizeof.sh" #TODO: improve

if [ "$UNAME" = "Linux" ]
then
	nm2(){
	nm $@ | grep ' [^tT] ' | cut -c 10- | sort | uniq
	}
	alias spotify="nohup spotify &"
	alias e="/usr/bin/emacs -nw"
	alias makemake="python ~/makemake/old/makemake.py"
	alias termvert6="nohup terminator -b -l vert6 &"
	alias termvert2="nohup terminator -b -l vert2 &"
	alias termhoriz6="nohup terminator -b -l horiz6 &"
	export PATH="$HOME/.linuxbrew/bin:$PATH"
	export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
	export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

fi

if [ "$UNAME" = "CYGWIN" ]
then
	nm2(){
	nm $@ | grep ' [^tT] ' | cut -c 10- | sort | uniq
	}
	# alias e='$NGOCONF_PATH/notepadpp.sh'
	export DISABLE_AUTO_TITLE=true
	alias e="emacs"
	alias open="cygstart.exe"
	alias makemake="python ~/makemake/old/makemake.py"
	alias clear='printf "\033c"'
	alias l="ls -gohFG --color"
	export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/flexdll-bin-0.34:$PATH"
	# export CYGWIN_OCAML_PREFIX="/home/Ngo/ocaml"
	# export CYGWIN_OPAM_PREFIX="/home/Ngo/opam"
	export OCAMLLIB="/lib/ocaml"
	# export PATH=$CYGWIN_OCAML_PREFIX/bin:$PATH #Just temporarily, since once OPAM is installed you switch to MinGW OCaml.
	# export PATH=$CYGWIN_OPAM_PREFIX/bin:$PATH
	# . /home/Ngo/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
	# export OPAM_ROOT=$(cygpath -m $HOME/.opam/4.03.0+beta2)
	alias ackf="ack \"^[\t\# ].*[a-z0-9_]+\(\""
	alias acki="ack \"^\#[\t ]*include[\t ]+\<\""
	alias pub="/cygdrive/c/tools/dart-sdk/bin/pub.bat"
	alias dart2js="/cygdrive/c/tools/dart-sdk/bin/dart2js.bat"
fi

if [ "$UNAME" = "Darwin" ]
then
	nm2(){
	nm $@ | grep ' [^tT] ' | cut -c 18- | sort | uniq
	}


	# TODO: check those 3 lines under macos
	export C_INCLUDE_PATH="$HOME/.brew/include:$HOME/.brew/include/freetype2"
	export CPLUS_INCLUDE_PATH="$HOME/.brew/include:$HOME/.brew/include/freetype2"
	export LIBRARY_PATH="$HOME/.brew/lib"

	alias tig="~/.brew/bin/tig/"
	alias e="emacs"
	export PATH="$HOME/.brew/bin:$NGOCONF_ROOT/mkgen:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
	export HOMEBREW_TEMP="/tmp/ngobrewtmp"
	export HOMEBREW_CACHE="/tmp/ngobrewcache"
	. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
	eval `opam config env`
	alias ack="~/.brew/bin/ack"
	alias ackf="~/.brew/bin/ack \"^[\t\# ].*[a-z0-9_]+\(\""
	alias acki="~/.brew/bin/ack \"^\#[\t ]*include[\t ]+\<\""
	alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk --args 'file://'`pwd`'/' 2>/dev/null"
	alias chromegit="$NGOCONF_PATH/chromegit.sh"
	alias kic='ls -dltu /nfs/z*/*/*/* |  awk  '"'"'{printf "%15s (%s) %3s %2s %s\n", $3, $4, $6, $7, $8}'"'"' | rev | uniq -f4 | rev'
	alias qui='_(){ ldapsearch uid="$1" ; }; _'

	# Load Homebrew Fix script
	source $HOME/.brew_fix.zsh

	alias cddown="cd ~/Downloads/"
	alias cddesk="cd ~/Desktop/"
	alias cddocs="cd ~/Documents/"

fi
