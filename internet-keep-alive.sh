#!/bin/ash

# RUN THIS EVERY 2 MINS !!!! @cron

DIR=$( cd $(dirname $0) ; pwd -P )
log_file="$DIR/log.txt"

# echo "$(date) Checking the internet connection" >> $log_file

OFFLINE_COUNT=$(cat $log_file | tail -10 | grep OFFLINE | wc -l)
echo "LAST 10 TESTS OFFLINE: $OFFLINE_COUNT"

# EXECs
SH_DNS_TESTS="$DIR/dns-test.sh"
SH_RESTART_INTERFACE="$DIR/restart-interface.sh"
SH_RESTART_ROUTER="$DIR/restart-router.sh"

# exec
`$SH_DNS_TESTS`

# deal with the result
if [ $? -eq 1 ]; then
   echo "OFFLINE"
   echo "$(date) OFFLINE > RESTARTING INTERFACE" >> $log_file

   if [[ "$OFFLINE_COUNT" -ge 10 ]]; then
      echo ">> Restarting router.."
      $SH_RESTART_ROUTER
   else
      echo ">> Restarting interface.."
      $SH_RESTART_INTERFACE
   fi
else
   echo "ONLINE"
   echo "$(date) ONLINE" >> $log_file
fi
