# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    append_prompt.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/10/13 17:30:07 by ngoguey           #+#    #+#              #
#                                                                              #
# **************************************************************************** #

# export PROMPT="$PROMPT\$(sh $NGOCONF_PATH/append_prompt.sh) "

NOW_HOUR=`date +%-H`

if [ -f "$HOME/limit" ]
then
	WHEN_TODAY=`cat $HOME/limit`
elif [ $(( $NOW_HOUR )) -ge 14 ]
then
	WHEN_TODAY='19:00:00'
else
	WHEN_TODAY='12:00:00'
fi

# echo $WHEN_TODAY

UNAME=`uname | cut -c1-6`
NOW=`date +%s`

if [ "$UNAME" = "CYGWIN" ]
then
	THEN=`date --date="$(echo $(date +"%d-%B-%y")" $WHEN_TODAY")" +%s`
else
	THEN=`date -j -f "%d-%B-%y-%H:%M:%S" $(echo $(date +"%d-%B-%y")"-$WHEN_TODAY") +%s`
fi

let DIFF=$THEN-$NOW


if [ $(( $DIFF )) -ge 0 ]
then
	((sec=DIFF%60, DIFF/=60, min=DIFF%60, hrs=DIFF/60))
	printf "[%d:%02d:%02d]" $hrs $min $sec
else
	let DIFF=-$DIFF
	((sec=DIFF%60, DIFF/=60, min=DIFF%60, hrs=DIFF/60))
	printf "[-%d:%02d:%02d]" $hrs $min $sec
fi
