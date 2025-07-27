#!/bin/sh /etc/rc.common

USE_PROCD=1 # 声明使用 procd 管理服务
START=99
STOP=15
PROG_PATH=/root/mihomo/mihomo
CONF_PATH=/root/mihomo/

start_service() { # 必须使用 start_service 而非 start
  procd_open_instance
  procd_set_param command "$PROG_PATH" -d "$CONF_PATH"
  procd_set_param respawn  # 进程崩溃后自动重启
  procd_set_param stdout 1 # 重定向标准输出到系统日志
  procd_set_param stderr 1 # 重定向错误输出到系统日志
  procd_close_instance
}

stop_service() { # 必须使用 stop_service 而非 stop
  echo "Stopping mihomo..."
  kill $(ps | grep "$PROG_PATH" | grep -v 'grep' | awk '{print $1}') || true
}

restart() {
  stop_service
  start_service
  echo "Restarted mihomo"
}
