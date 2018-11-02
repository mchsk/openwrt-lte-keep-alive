# OpenWRT LTE Keep-alive scripts

![OpenWRT logo](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/openwrt.png)
![How it looks](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/screenshot1.png)

**What is this? Long story short.**<br>
If you managed to create `WAN` interface on OpenWRT using `WWAN/QMI/NCM/3G protocol` with your modem but your connection drops from time to time, you found the safe heaven now. These scripts make sure your router is online. You would probably find use of it when you need to have working internet in **locations with difficult access**, e.g. cabin in the woods, garage or your house on Seychelles.

**How it works?**<br>
All the scripts run on [ash](https://www.in-ulm.de/~mascheck/various/ash/) which is the basic shell for OpenWRT.
The main script (`internet-keep-alive.sh`) tries to ping Google DNS servers (8.8.8.8).<br>
- If it fails, it restarts the interface.<br>
- If it fails 4 times in a row, it restarts whole system.<br>
Connection tests are being logged in `log.txt`, which has a cap of `11000` lines.

**Requirements**<br>
[Netcat](https://openwrt.org/packages/pkgdata/netcat) The TCP/IP Network R/W Utility. `opkg update && opkg install netcat`

**Installation**<br>
1. Log into the router via SSH and go to the directory where you want to keep the script files.<br>
2. Make sure the router is online, then run the installer:<br>
   `wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/install.sh -O install.sh && chmod +x install.sh && ./install.sh`

Enjoy ❤️🏠📡📶!
