#!/bin/ash

echo "SH RESTART IFACE"

INTERFACE="wwan"
logger -s "INTERNET KEEP ALIVE SYSTEM: Restarting the LTE interface."

ifdown $INTERFACE
sleep 2
ifup $INTERFACE