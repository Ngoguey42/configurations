
NOW=`date +%s`
DELTA=$(($SSH_TIMEOUT_THEN - $NOW))

if [ $DELTA -ge 0 ]; then
    # UNAME=`uname | cut -c1-6`
    DELTA_FORMAT=`date -u -d@$DELTA +"%T"`
    printf "\033[31m$DELTA_FORMAT\033[0m"
else
    printf "\033[31mtimeout\033[0m"
fi
