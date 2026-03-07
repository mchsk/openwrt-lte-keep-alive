# LTE Keep-Alive for OpenWrt

A lightweight connectivity watchdog for OpenWrt routers with LTE/WWAN modems. When the connection drops, it restarts the interface. If restarts keep failing, it reboots the router.

Built for routers in hard-to-reach locations — cabins, garages, remote sites — where manual intervention is not an option.

## How it works

A single daemon checks connectivity by pinging multiple DNS servers (8.8.8.8, 1.1.1.1, 9.9.9.9 by default). If **any** target responds, the connection is healthy.

On failure:

| Consecutive failures | Action |
|---|---|
| 3 | Restart the WAN interface (`ifdown` / `ifup`) |
| 6 | Restart the interface again |
| 9 | Reboot the router |

All thresholds, targets, and intervals are configurable via UCI.

## Requirements

- OpenWrt 23.05 or later (tested on 25.12.0)
- No extra packages needed — uses busybox `ping`

## Quick install

SSH into your router and run:

```sh
wget -q -O /tmp/install.sh https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/install.sh && sh /tmp/install.sh
```

Then edit the config to match your interface name:

```sh
vi /etc/config/lte-keepalive
```

Start the service:

```sh
service lte-keepalive start
```

## Manual install

```sh
# Copy the files
scp lte-keepalive root@router:/usr/bin/lte-keepalive
scp lte-keepalive.init root@router:/etc/init.d/lte-keepalive
scp lte-keepalive.config root@router:/etc/config/lte-keepalive

# On the router
chmod +x /usr/bin/lte-keepalive /etc/init.d/lte-keepalive
service lte-keepalive enable
service lte-keepalive start
```

## Configuration

The config lives at `/etc/config/lte-keepalive`. All values have sensible defaults.

```
config keepalive 'main'
    option enabled '1'

    # Network interface to monitor
    option interface 'wwan'

    # Space-separated IPs to ping (any response = online)
    option ping_targets '8.8.8.8 1.1.1.1 9.9.9.9'

    # ICMP packets per target
    option ping_count '3'

    # Seconds to wait for a ping reply
    option ping_timeout '5'

    # Seconds between checks
    option check_interval '120'

    # Restart interface after this many consecutive failures
    option restart_threshold '3'

    # Reboot after this many consecutive failures
    option reboot_threshold '9'

    # Seconds to pause during interface restart
    option restart_delay '15'
```

### Common interface names

| Protocol | Typical interface name |
|---|---|
| QMI | `wwan` or `wwan0` |
| NCM | `wwan` |
| ModemManager | `wwan0` or `lte` |
| MBIM | `wwan` |
| 3G/PPP | `3g-wan` |

Check your interface name with `uci show network` or in LuCI under **Network > Interfaces**.

## Logs

All events go to syslog. View them with:

```sh
logread -e lte-keepalive
```

Sample output:

```
lte-keepalive: Started: interface=wwan targets='8.8.8.8 1.1.1.1 9.9.9.9' interval=120s
lte-keepalive: Connectivity check failed (1/9)
lte-keepalive: Connectivity check failed (2/9)
lte-keepalive: Connectivity check failed (3/9)
lte-keepalive: Restarting interface 'wwan' (failure #3)
lte-keepalive: Connectivity restored after 4 failure(s)
```

## Service management

```sh
service lte-keepalive start     # Start the watchdog
service lte-keepalive stop      # Stop it
service lte-keepalive restart   # Restart (picks up config changes)
service lte-keepalive enable    # Start on boot
service lte-keepalive disable   # Don't start on boot
```

## Uninstall

```sh
wget -q -O /tmp/uninstall.sh https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/uninstall.sh && sh /tmp/uninstall.sh
```

Or manually:

```sh
service lte-keepalive stop
service lte-keepalive disable
rm /usr/bin/lte-keepalive /etc/init.d/lte-keepalive
```

The config at `/etc/config/lte-keepalive` is preserved during uninstall.

## Migrating from v1

If you used the old version (multiple `.sh` scripts with cron), remove the old files and cron entry:

```sh
# Remove old cron entry
crontab -l | grep -v internet-keep-alive | crontab -

# Remove old script files
rm -f internet-keep-alive.sh dns-test.sh restart-interface.sh restart-router.sh log.txt
```

Then follow the install instructions above.

## File layout

```
/usr/bin/lte-keepalive           Main daemon script
/etc/init.d/lte-keepalive        procd service definition
/etc/config/lte-keepalive        UCI configuration
```

## License

MIT
