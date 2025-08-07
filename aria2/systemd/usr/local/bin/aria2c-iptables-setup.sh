#!/bin/sh

DSCP_MARK=2
logger "[aria2c] Applying iptables rules for aria2 user..."

iptables -t mangle -C OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp $DSCP_MARK 2>/dev/null || \
iptables -t mangle -A OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp $DSCP_MARK

ip6tables -t mangle -C OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp $DSCP_MARK 2>/dev/null || \
ip6tables -t mangle -A OUTPUT -m owner --uid-owner aria2 -j DSCP --set-dscp $DSCP_MARK
