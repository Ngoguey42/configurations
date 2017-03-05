# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dotzshrc.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/15 08:34:15 by ngoguey           #+#    #+#              #
#    Updated: 2017/03/05 15:05:17 by ngoguey          ###   ########.fr        #
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
