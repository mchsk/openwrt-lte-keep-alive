#!/bin/sh
# Uninstaller for lte-keepalive
set -e

log() { echo ">> $1"; }

log "Stopping service"
/etc/init.d/lte-keepalive stop 2>/dev/null || true

log "Disabling service"
/etc/init.d/lte-keepalive disable 2>/dev/null || true

log "Removing files"
rm -f /usr/bin/lte-keepalive
rm -f /etc/init.d/lte-keepalive

log ""
log "Uninstalled. Config preserved at /etc/config/lte-keepalive"
log "To remove config: rm /etc/config/lte-keepalive"
