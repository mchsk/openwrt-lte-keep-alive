# OpenWRT LTE Keep-alive scripts

![OpenWRT logo](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/openwrt.png)
![How it looks](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/assets/screenshot1.png)

**What is this? Long story short.**<br>
If you managed to create `WAN` interface on OpenWRT using `WWAN/QMI/NCM/3G protocol` with your modem and your connection drops from time to time, you found the safe heaven now. This is useful if you want to make sure the internet is working in **locations with difficult access**, e.g. cabins in the woods.

**How it works?**<br>
All the scripts run on [ash](https://www.in-ulm.de/~mascheck/various/ash/) which is the basic shell for OpenWRT.
The main script (`internet-keep-alive.sh`) tries to ping Google DNS servers.<br>
- If it fails, it restarts the interface.<br>
- If it fails 4 times in a row, it restarts whole system.<br>
Connection tests are beibg logged in `log.txt`.

**Requirements**<br>
[Netcat](https://openwrt.org/packages/pkgdata/netcat) The TCP/IP Network R/W Utility. `opkg update && opkg install netcat`

**Installation**<br>
1. Download the `sh scripts` into the same directory on the router (wget/curl/sftp)
2. Make them executable `chmod +x *.sh`
3. Add reference to the main script into `cron`. You can access the cron using `crontab -e`.<br>
  Example:<br>
  `*/2 * * * * /root/internet-keep-alive/internet-keep-alive.sh`<br>
  (runs every 2 minutes, with scripts in the `/root/internet-keep-alive/` directory.
4. **Important** by default the script restarts the `wwan` interface. You might need to edit this in the [restart-interface.sh](https://github.com/mchsk/openwrt-lte-keep-alive/blob/master/restart-interface.sh) script. It should match the interface of your modem.

Enjoy ❤️🏠📡📶!
