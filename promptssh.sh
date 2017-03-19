
NOW=`date +%s`
DELTA=$(($SSH_TIMEOUT_THEN - $NOW))

if [ $DELTA -ge 0 ]; then
    UNAME=`uname | cut -c1-6`
    if [ "$UNAME" = "Darwin" ]
    then
	DELTA_FORMAT=`date -u -r $DELTA +"%T"`
    else
	DELTA_FORMAT=`date -u -d@$DELTA +"%T"`
    fi
    printf "\033[31m$DELTA_FORMAT\033[0m"
else
    printf "\033[31mtimeout\033[0m"
fi
