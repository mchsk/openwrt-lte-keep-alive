#!/bin/ash
# This file is responsible for restarting the router using reboot command.
# There is a stratery to write few lines into the log, so that grepping last lines
# returns less occurences of word OFFLINE. Too many occurences actually run this script.

DIR=$( cd $(dirname $0) ; pwd -P )
LOG_FILE="$DIR/log.txt"

echo "$(date) > TOO MANY OFFLINE TRYOUTS" >> $LOG_FILE
echo "$(date) > GOING TO REBOOT NOW" >> $LOG_FILE
echo "$(date) > NOW!" >> $LOG_FILE
echo "$(date) > SORRY FOR ANY INCONVENIENCE." >> $LOG_FILE

echo "SH REBOOT"
reboot
