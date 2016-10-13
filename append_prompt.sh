# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    append_prompt.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/10/13 17:30:07 by ngoguey           #+#    #+#              #
#    Updated: 2016/10/13 17:34:10 by ngoguey          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# export PROMPT="$PROMPT\$(sh $NGOCONF_PATH/append_prompt.sh) "

NOW=`date +%s`
THEN=`date -j -f "%d-%B-%y-%H:%M:%S" $(echo $(date +"%d-%B-%y")"-19:00:00") +%s`
let DIFF=$THEN-$NOW


((sec=DIFF%60, DIFF/=60, min=DIFF%60, hrs=DIFF/60))

if [ $(( $DIFF )) -ge 0 ]; then
	printf "[%d:%02d:%02d]" $hrs $min $sec
fi
