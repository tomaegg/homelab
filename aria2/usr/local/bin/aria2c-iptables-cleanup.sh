#!/bin/sh

logger "[aria2c] Cleaning up iptables rules for aria2 user..."

iptables -t mangle -D OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp 2 2>/dev/null
ip6tables -t mangle -D OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp 2 2>/dev/null
