#!/bin/vbash
# shellcheck disable=all

delete system host-name
set system host-name "${SECRET_VYOS_HOSTNAME}"
set system domain-name "${SECRET_VYOS_DOMAIN}"
set system ipv6 disable-forwarding
set system name-server '203.142.82.222'
set system name-server '203.142.84.222'
set system time-zone 'Asia/Jakarta'

set system sysctl parameter kernel.pty.max value '24000'

set system login user vyos authentication public-keys monosense-okd key "${SECRET_ADMIN_SSH_KEY1}"
set system login user vyos authentication public-keys macbook key "${SECRET_ADMIN_SSH_KEY2}"
