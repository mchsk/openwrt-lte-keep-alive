#!/bin/sh
# Installer for lte-keepalive on OpenWrt 25.x
set -e

REPO_RAW="https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master"

log() { echo ">> $1"; }

log "Installing lte-keepalive..."

log "Downloading main script"
wget -q -O /usr/bin/lte-keepalive "$REPO_RAW/lte-keepalive"
chmod +x /usr/bin/lte-keepalive

log "Downloading init script"
wget -q -O /etc/init.d/lte-keepalive "$REPO_RAW/lte-keepalive.init"
chmod +x /etc/init.d/lte-keepalive

if [ ! -f /etc/config/lte-keepalive ]; then
	log "Downloading default config"
	wget -q -O /etc/config/lte-keepalive "$REPO_RAW/lte-keepalive.config"
else
	log "Config already exists at /etc/config/lte-keepalive — skipping"
fi

log "Enabling service"
/etc/init.d/lte-keepalive enable

log ""
log "Installed. Edit the config to match your setup:"
log "  vi /etc/config/lte-keepalive"
log ""
log "Then start the service:"
log "  service lte-keepalive start"
log ""
log "Check logs with:"
log "  logread -e lte-keepalive"
