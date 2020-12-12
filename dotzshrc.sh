# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dotzshrc.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/15 08:34:15 by ngoguey           #+#    #+#              #
#                                                                              #
# **************************************************************************** #

UNAME=`uname | cut -c1-6`

if [ "$UNAME" = "Darwin" ]
then
    export NGOCONF_ROOT="/Volumes/Storage/goinfre/ngoguey"
# elif [ "$UNAME" = "Linux" ]
# then
# elif [ "$UNAME" = "CYGWIN" ]
# then
else
    export NGOCONF_ROOT=$HOME
fi

export NGOCONF_PATH="$NGOCONF_ROOT/configurations"

source $NGOCONF_PATH/zsh_conf.sh

# opam configuration
test -r /home/nico/.opam/opam-init/init.zsh && . /home/nico/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nico/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nico/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nico/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nico/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
