# OpenWRT LTE Keep-alive scripts

![OpenWRT logo](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/openwrt.png)
![How it looks](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/screenshot1.png)

**What is this? Long story short.**<br>
If your `WAN` interface using `WWAN/QMI/NCM/3G protocol` with your modem is working but your connection drops from time to time, you have just found the safe heaven. These scripts make sure your router is online, managing your interface or router itself. You would probably find use of it when you need to have working internet in **locations with difficult access**, e.g. cabin in the woods, garage or your house on Seychelles.

**How it works?**<br>
All the scripts run on [ash](https://www.in-ulm.de/~mascheck/various/ash/) which is the basic shell for OpenWRT.
The main script (`internet-keep-alive.sh`) tries to ping Google DNS servers (8.8.8.8) using Netcat.<br>
- If it fails, it restarts the interface.<br>
- If it fails 4 times in a row, it restarts whole system.<br>
Online/offline results are being logged into `log.txt`, which has a cap of `11000` lines, not to flood the whole space on the device.

**Requirements**<br>
[Netcat](https://openwrt.org/packages/pkgdata/netcat) The TCP/IP Network R/W Utility. The installer installs this package.

**Installation**<br>
1. Log into the router via SSH and go to the directory where you want to keep the script files.<br>
2. Make sure the router is online, then run the installer and follow the instructions:<br>
   `wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/install.sh -O install.sh && chmod +x install.sh && ./install.sh`

Enjoy ❤️🏠📡📶!
