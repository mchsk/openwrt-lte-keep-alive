#!/bin/ash

# This file is responsible for DNS check.

# requires netcat package w kernel support (make menuconfig @openwrt)

ip=8.8.8.8
n=4

# -------
online=0
for i in `seq 1 $n`;
        do
                nc -G 2 -z $ip 53
                RETVAL=$?
				if [ $RETVAL -eq 0 ]; then
					online=1
				fi
        done
if [ $online -eq 1 ]; then
    # echo "xDNS ping online" -> exit 0
    exit 0
else
    # echo "xDNS ping offline" -> exit 1
    exit 1
fi
