#!/bin/vbash
# shellcheck disable=all

set service ssh disable-password-authentication
set service ssh port '22'
set service ntp server ntp.bsn.go.id prefer
set service ntp server time.google.com
set service ntp server time.cloudflare.com
set service ntp listen-address '172.16.10.254'

# LAN2 DHCP server
set service dhcp-server shared-network-name LAN2 authoritative
set service dhcp-server shared-network-name LAN2 ping-check
set service dhcp-server shared-network-name LAN2 subnet 192.168.20.0/24 default-router '192.168.20.1'
set service dhcp-server shared-network-name LAN2 subnet 192.168.20.0/24 lease '86400'
set service dhcp-server shared-network-name LAN2 subnet 192.168.20.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name LAN2 subnet 192.168.20.0/24 range 0 start '192.168.20.50'
set service dhcp-server shared-network-name LAN2 subnet 192.168.20.0/24 range 0 stop '192.168.20.199'
