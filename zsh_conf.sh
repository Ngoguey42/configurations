# ZSH CONFIG
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)
source $ZSH/oh-my-zsh.sh
zstyle ':completion:*:*:emacs:*:*files' ignored-patterns '*.o' '*.cmx' '*.cmi' '*.cmo'
export ZSH_THEME_GIT_PROMPT_PREFIX="%{\e[01;34m%}%{\e[31m%}"
export ZSH_THEME_GIT_PROMPT_CLEAN="%{\e[34m%}"
export ZSH_THEME_GIT_PROMPT_DIRTY="%{\e[33m%}"
autoload -U colors && colors
export HISTSIZE=200000

# CONFIG FILES EDITION
alias zshconf="e $NGOCONF_PATH/zsh_conf.sh"
alias matrix="source ~/.zshrc"
alias econf="e $NGOCONF_PATH/my_config.el"
alias ebconf="e $NGOCONF_PATH/my_bindings.el"
alias eeconf="e $NGOCONF_PATH/my_ecaml/plugin.ml"

# OCAML

# GIT RELATED
export USER="ngoguey"
export MAIL="ngoguey@student.42.fr"
# export MAIL="ngoguey@airware.com"
alias gitals="git add \`git ls-files\` ; git status"
alias gits="git status"
alias gitcm="git commit -m"
alias gitck="git checkout"
alias gitcl="git clean -xn"
alias gitclF="git clean -xf"
alias gitcld="git clean -xdn"
alias gitcldF="git clean -xdf"
alias groot='git rev-parse --show-toplevel'

# MISC
alias rr="
printf '\033[31m' ;rm **/*~ 2>/dev/null && echo '\033[32mrm **/*~'
printf '\033[31m' ;rm **/\#* && echo '\033[32mrm **/\#*'
printf '\033[31m' ;rm **/*.stackdump && echo '\033[32mrm **/*.stackdump'
printf '\033[31m' ;rm **/nohup.out && echo '\033[32mrm **/nohup.out'
printf '\033[31m' ;rm **/.\#* && echo '\033[32mrm **/.\#*'
printf '\033[31m' ;rm -r **/.DS_Store && echo '\033[32mrm **/.DS_Store'
printf '\033[31m' ;rm -r **/*.dSYM && echo '\033[32mrm **/*.dSYM'
printf '\033[0m'"

alias ocamldepdot="ocaml unix.cma $NGOCONF_PATH/scripts/ocamldep-dot.ml"
alias persp_of_yaml="python3 $NGOCONF_PATH/scripts/persp_of_yaml.py"
alias sed_hashes="python3 $NGOCONF_PATH/scripts/sed_hashes.py"

# LIBRARIES CONF ************************************************************ **
export PYTEST_ADDOPTS="--color=yes"

__conda_setup="$($HOME/anaconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# function opam_info {
#     test -r ~/.opam/opam-init/init.zsh && opam switch show --safe 2>/dev/null | sed 's|.*/|*|'
# }
# test -r ~/.opam/opam-init/init.zsh && export PS1="{\$(opam_info)} $PS1" || true

# SHLVL ********************************************************************* **
if [[ $SHLVL -ge 2 ]]; then
    CHARS=`printf '+%.0s' {1..$(($SHLVL - 1))}`
    export PS1="$CHARS $PS1"
fi

# LOCATION SPECIFIC ********************************************************* **
UNAME=`uname | cut -c1-6`
if uname -r | grep -i microsoft >/dev/null
then
    UNAME="WSL"
fi

if [ "$UNAME" = "WSL" ] # *************************************************** **
then
    EDITOR="/usr/bin/emacs26 -nw"
    alias l="ls -gohFG --color"
    open(){
	explorer.exe `wslpath -aw $1`
    }
fi

if [ "$UNAME" = "Linux" ] # ************************************************* **
then
    alias spotify="nohup spotify &"
    EDITOR="/usr/bin/emacs -nw"
    export PATH="`/usr/bin/python -u $NGOCONF_PATH/scripts/clean_path.py`"

    alias termvert6="nohup terminator -b -l vert6 &"
    alias termvert2="nohup terminator -b -l vert2 &"
    alias termhoriz6="nohup terminator -b -l horiz6 &"
    alias l="ls -gohFG --color"
    alias open='xdg-open 2>/dev/null'

    export D=/media/ngoguey/Donnees
    export TS_CHAFFINCH=$D/ngoguey/ts_chaffinch
    export NEST_HOME=$HOME/nest

    export PATH=/usr/local/cuda-10.0/bin:$HOME/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

    export QT_STYLE_OVERRIDE=gtk2 # To silence `QGtkStyle could not resolve GTK` warning
fi

if [ "$UNAME" = "CYGWIN" ] # ************************************************ **
then
    # export DISABLE_AUTO_TITLE=true
    EDITOR="emacs"
    alias open="cygstart.exe"
    alias clear='printf "\033c"'
    alias l="ls -gohFG --color"
    export PATH="`/usr/bin/python -u $NGOCONF_PATH/scripts/clean_path.py`"

    alias subl='/cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe'
    # alias git="/cygdrive/c/Program\ Files/Git/mingw64/bin/git"

    function sudo {
    	cygstart --action=runas "$@"
    }

    function sudocmd {
    	cygstart --action=runas cmd /C "$@"
    }

    function repairperms {
	V=$(pwd -P)
	V=$(cygpath -w $V)
	sudocmd "takeown /F "$V" /R /A /D Y & icacls "$V" /reset /T /C /L /Q & icacls "$V" /grant "$USERNAME":(OI)(CI)F"
    }

fi

if [ "$UNAME" = "Darwin" ] # ************************************************ **
then
    alias l="ls -gohFG"
    EDITOR="emacs"
    export PATH="`/usr/bin/python -u $NGOCONF_PATH/scripts/clean_path.py`"
fi

# POST - LOCATION SPECIFIC ************************************************** **
alias e="$EDITOR"
export EDITOR="$EDITOR"

# SSH *********************************************************************** **
# Preprend to prompt the life time of the zsh-agent spawned using `ssh-agent zsh`
function promptssh {
    NOW="$(date +%s)"
    DELTA=$(($SSH_TIMEOUT_THEN - $NOW))
    if [ $DELTA -ge 0 ]; then
	UNAME=`uname | cut -c1-6`
	if [ "$UNAME" = "Darwin" ]
	then
	    DELTA_FORMAT=`date -u -r $DELTA +"%T"`
	else
	    DELTA_FORMAT=`date -u -d@$DELTA +"%T"`
	fi
	echo %{$fg[red]%}$DELTA_FORMAT%{$reset_color%}
    else
	echo %{$fg[red]%}timeout%{$reset_color%}
    fi
}

export SSH_TIMEOUT_DEFAULT=$((5 * 60))
export SSH_FILE_DEFAULT='id_rsa'
if [[ -n "$SSH_AGENT_PID" ]]; then
    kill -0 $SSH_AGENT_PID 2>/dev/null 1>/dev/null
    if [[ $? -eq 0 ]]; then

	# export SSH_PARENT_PID=`ps -p $SSH_AGENT_PID -o ppid= | xargs`
	export SSH_PARENT_PID=`ps -p $SSH_AGENT_PID -f | tail -n1 | awk '{ print $3 }'`
	# export SSH_PARENT_NAME=`ps -p $SSH_PARENT_PID -o comm= | xargs`
	if ps -p $SSH_PARENT_PID | grep zsh >/dev/null ; then
	# if [ "$SSH_PARENT_NAME" = "zsh" ]; then

            if [[ -z "$SSHTO" ]]; then # SSHTO aka `ssh time out`
		export SSHTO=$SSH_TIMEOUT_DEFAULT
            fi
            if [[ -z "$SSHFILENAME" ]]; then # SSHTO aka `ssh file`
		export SSHFILE="$HOME/.ssh/$SSH_FILE_DEFAULT"
            else
		export SSHFILE="$HOME/.ssh/$SSHFILENAME"
            fi
            UNAME=`uname | cut -c1-6`
            if [ "$UNAME" = "Darwin" ]
            then
		SSHTO_FORMAT=`date -u -r $SSHTO +"%T"`
            else
		SSHTO_FORMAT=`date -u -d@$SSHTO +"%T"`
            fi

            echo "Enter passphrase for $SSHFILE valid for ($SSHTO_FORMAT)"
            ssh-add -t $SSHTO $SSHFILE || exit

            NOW=`date +%s`
            export SSH_TIMEOUT_THEN=$(($NOW + $SSHTO))
            export PS1="\$(promptssh) $PS1"
	fi
    fi
fi
