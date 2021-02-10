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

export NGOCONF_ROOT=$HOME

export NGOCONF_PATH="$NGOCONF_ROOT/configurations"

source $NGOCONF_PATH/zsh_conf.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nico/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/nico/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/nico/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/nico/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

