#!/bin/sh /etc/rc.common

START=99
STOP=15
PROG_PATH=/root/mihomo/mihomo
CONF_PATH=/root/mihomo/config.yaml

start() {
  echo "Starting mihomo..."
  ($PROG_PATH -f $CONF_PATH) &
}

stop() {
  echo "Stopping mihomo..."
  kill $(ps | grep "$PROG_PATH" | grep -v 'grep' | awk '{print $1}') || true
}

restart() {
  stop
  start
  echo "Restarted mihomo"
}
