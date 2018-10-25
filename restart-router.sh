#!/bin/ash

# This file is responsible for restarting the router

DIR=$( cd $(dirname $0) ; pwd -P )
log_file="$DIR/log.txt"

echo "$(date) > TOO MANY OFFLINE TRYOUTS" >> $log_file
echo "$(date) > GOING TO REBOOT NOW" >> $log_file
echo "$(date) > NOW!" >> $log_file
echo "$(date) > SORRY FOR ANY INCONVENIENCE." >> $log_file
echo "SH REBOOT"
reboot
