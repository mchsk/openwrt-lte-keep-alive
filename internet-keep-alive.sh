#!/bin/ash
# The main script file. I recommend putting into cron, e.g.:
# */2 * * * * /root/internet-keep-alive/internet-keep-alive.sh

DIR=$( cd $(dirname $0) ; pwd -P )
LOG_FILE="$DIR/log.txt"

OFFLINE_COUNT=$(cat $LOG_FILE | tail -4 | grep OFFLINE | wc -l)
OFFLINE_COUNT_TRESHOLD=4

SH_DNS_TESTS="$DIR/dns-test.sh"
SH_RESTART_INTERFACE="$DIR/restart-interface.sh"
SH_RESTART_ROUTER="$DIR/restart-router.sh"

LINES_MAX=11000
LINES_MIN=6000
LINES_COUNT=$(wc -l $LOG_FILE | awk '{print $1}')

# if the log files gets huge, strip it, keep last LINES_MIN lines
if [[ "$LINES_COUNT" -ge "$LINES_MAX" ]]; then
   echo "$(tail -$LINES_MIN $LOG_FILE)" > $LOG_FILE
fi

# DNS test, it's result defines the ONLINE/OFFLINE state
`$SH_DNS_TESTS`

if [ $? -eq 1 ]; then
   echo "Ooops, we're offline!"
   echo "$(date) OFFLINE > RESTARTING INTERFACE" >> $LOG_FILE

   if [[ "$OFFLINE_COUNT" -ge "$OFFLINE_COUNT_TRESHOLD" ]]; then
      echo ">> Restarting router.."
      $SH_RESTART_ROUTER
   else
      echo ">> Restarting interface.."
      $SH_RESTART_INTERFACE
   fi
else
   echo "We're okay!"
   echo "$(date) ONLINE" >> $LOG_FILE
fi
