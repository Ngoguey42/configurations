# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconf="e ~/configurations/zsh_conf.sh"
alias matrix="source ~/.zshrc"
alias econf="emacs ~/configurations/my_config.el"

alias cddown="cd ~/Downloads/"
alias cddesk="cd ~/Desktop/"
alias cddocs="cd ~/Documents/"

alias cdapache="cd /nfs/zfs-student-3/users/2014/ngoguey/mamp/apache2/conf/bitnami/"
alias cdapps="cd /nfs/zfs-student-3/users/2014/ngoguey/mamp/apps/"
alias cdmamp="cd /nfs/zfs-student-3/users/2014/ngoguey/mamp"
alias cdas="cd /nfs/zfs-student-3/users/2014/ngoguey/mamp/apps/Awesome_Starship_Battles/htdocs"

alias nvcc="/usr/local/cuda/bin/nvcc"
alias wcc="gcc -Wall -Werror -Wextra"
alias wpp="clang++ -Wall -Werror -Wextra"
alias e="emacs"
alias lret="echo $?"

alias save="pwd | cat > ~/.save_pwd"
alias go="cd \`cat ~/.save_pwd\` ; clear"

alias grepclasses="grep -h 'class ' **/*.hpp | grep -v ';'"
alias vg="~/bin/valgrind/bin/valgrind"

alias l="ls -gohFG"
alias lsc="ls -gohGF **/*.(cpp|hpp|c|h|php|tpp) 1>&1 1>&2 |
wc ; wc **/*.(cpp|hpp|c|h|php|tpp) |
tail -n 1"

alias lscs="ls -gohGFS **/*.(cpp|hpp|c|h|php|tpp) 1>&1 1>&2 |
wc ; wc **/*.(cpp|hpp|c|h|php|tpp) |
tail -n 1"


alias rr="rm **/*~; rm **/\#* ;rm **/*.stackdump; rm **/.\#*"
alias rrlft="(rr) ; (cd includes && rr) ; (cd srcs && rr) ; (cd srcs/printf && rr)"

alias ch="chmod 644 \`ls -1d *.(c|cpp|hpp|tpp)\` ; chmod 644 \`ls -1d *.h\`; chmod 744 Makefile ; chmod 644 auteur ; ls -lFhG"

alias makej="make fclean ; make -j"
alias makejl="make -C libft/ fclean ; make -C libft/ -j"
alias makeja="makejl ; makej"

alias makejg="make fclean ; make -j g"
alias makejgl="make -C libft/ fclean ; make -C libft/ -j g"
alias makejga="makejgl ; makejg"

alias kic='ls -dltu /nfs/z*/*/*/* |  awk  '"'"'{printf "%15s (%s) %3s %2s %s\n", $3, $4, $6, $7, $8}'"'"' | rev | uniq -f4 | rev'
alias qui='_(){ ldapsearch uid="$1" ; }; _'

alias findman='_(){
echo -e "Looking for /usr/share/man/man*/$1.*:";
ls -godFGhSd /usr/share/man/man*/$1.*;
echo -e "\nExtented, looking for /usr/share/man/man*/*$1.*:";
ls -godFGhSd /usr/share/man/man*/*$1*;
}; _'

alias findlib='_(){
ack $@ libft/includes/libft.h /usr/include/*.h
}; _'

alias ppxt='_(){
echo "<$1 $2 | $3 >$4"
echo "<$1 `echo $2` | `echo $3` >$4
echo -e "\n./pipex \"$1\" \"$2\"  \"$3\" \"$4\""
./pipex "$1" "$2" "$3" "$4"
}; _'

export MAIL="ngoguey@student.42.fr"
alias tig="~/.brew/bin/tig/"
alias gitals="git add \`git ls-files\` ; git status"
alias gitls="git ls-files"
alias gitac="git add \`ls -1 **/*.(cpp|hpp|c|h|php|tpp)\` ; git status"
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

#sh nm.sh binnary
#nm $@ | grep ' [^tT] ' | cut -c 18- | sort
alias nm2="sh /nfs/sgoinfre/goinfre/Misc/nm.sh"

#ps interessant
alias psi='ps | grep -v zsh | grep -v emacs'

alias sht='_(){

echo "SH:" 
env -i sh -c $@ 1>sht1 2>sht2
echo -n "\033[33m"
cat sht1
echo -n "\033[31m"
cat sht2
echo -n "\033[0m"

echo "MSH:"
touch log.txt
exec 5>./log.txt
env -i ./ft_minishell2 -c $@ 1>sht1 2>sht2
echo -n "\033[33m"
cat sht1
echo -n "\033[31m"
cat sht2
echo  "\033[0mLOG:"
cat log.txt
exec 5>&-

rm -f sht1
rm -f sht2 
rm -f log.txt


};_'

alias headervalidity='for i in *.[hc]
do
echo $i
cat $i | head -n 4 | tail -n 1 | cut -c 6- | cut -c -30
done'

alias sigmsh='_(){
kill -$1 $(ps | grep -v "grep" | grep "ft_minishell1" | cut -c -5)
};_'

alias kmsh="\`sigmsh KILL\`"
alias chp="chmod 755 *.php"

alias mysql="/nfs/zfs-student-3/users/2014/ngoguey/mamp/mysql/bin/mysql"
alias mysqlu="/nfs/zfs-student-3/users/2014/ngoguey/mamp/mysql/bin/mysql -uroot -p"

alias mampr="sh /nfs/zfs-student-3/users/2014/ngoguey/mamp/ctlscript.sh restart"
alias mampu="sh /nfs/zfs-student-3/users/2014/ngoguey/mamp/ctlscript.sh status"
alias mamp="sh /nfs/zfs-student-3/users/2014/ngoguey/mamp/ctlscript.sh"

alias sfmlenv='export DYLD_FRAMEWORK_PATH=`pwd`"/SFML/Frameworks"'
export DYLD_FRAMEWORK_PATH='/nfs/zfs-student-3/users/2014/ngoguey/ft_gkrellm/SFML/Frameworks'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk --args 'file://'`pwd`'/' 2>/dev/null"

alias php="php"
# alias php="~/mamp/php/bin/php"

UNAME=`uname | cut -c1-6`

if [ "$UNAME" = "CYGWIN" ]
then
	alias open="cygstart.exe"
	alias clear='printf "\033c"'
	export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
	alias ackf="ack \"^[\t\# ].*[a-z0-9_]+\(\""
	alias acki="ack \"^\#[\t ]*include[\t ]+\<\""
	alias syncgithub='
	cd; mkdir -p sync; cd sync; 
	chmod 755 *
	export reponame="proj14_algo_lem-in";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj13_graph_nibbler";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="piscine_ocaml";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="ocamltest";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="configurations";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj01_algo_libft";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj10_algo_pushswap";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="ftconstexpr";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="vanilla_addons";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="piscine_cpp";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj12_unix_philosophers";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="ft_minishop";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="ft_retro";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="piscine_php";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="ft_gkrellm";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="tests_cpp";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="Awesome_Starship_Battles";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj04_graph_fdf";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="c_exams";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="gnl_testdir";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj08_unix_sh";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="libftasm_testdir";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj11_algo_libftasm";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj06_graph_fractol";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj05_algo_printf";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj03_unix_ls";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj09_graph_wolf3d";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="proj02_algo_getnextline";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	export reponame="libft_testdir";	echo "######SAVING PROJECT: "$reponame; (cd $reponame 2>/dev/null && (git pull origin master || echo "could not pull")) || git clone https://github.com/Ngoguey42/$reponame
	chmod 000 *
	unset reponame
	'
else
	export PATH="/nfs/zfs-student-3/users/2014/ngoguey/mamp/php/bin:/nfs/zfs-student-3/users/2014/ngoguey/.brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
	alias ack="~/.brew/bin/ack"
	alias ackf="~/.brew/bin/ack \"^[\t\# ].*[a-z0-9_]+\(\""
	alias acki="~/.brew/bin/ack \"^\#[\t ]*include[\t ]+\<\""
fi


