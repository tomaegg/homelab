#!/bin/sh

set -eux

iptables -t mangle -A OUTPUT -m owner --uid-owner 1026 -j DSCP --set-dscp 2
ip6tables -t mangle -A OUTPUT -m owner --uid-owner 1026 -j DSCP --set-dscp 2