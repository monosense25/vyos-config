#!/bin/vbash
# shellcheck disable=all

set interfaces ethernet eth5 hw-id '98:fa:9b:19:be:d9'
set interfaces ethernet eth1 hw-id 'a0:36:9f:59:64:48'
set interfaces ethernet eth2 hw-id 'a0:36:9f:59:64:49'
set interfaces ethernet eth3 hw-id 'a0:36:9f:59:64:4a'
set interfaces ethernet eth4 hw-id 'a0:36:9f:59:64:4b'

set interfaces bonding bond0 address '172.16.10.254/24'
set interfaces bonding bond0 description 'MGMT'
set interfaces bonding bond0 hash-policy 'layer2'
set interfaces bonding bond0 member interface 'eth1'
set interfaces bonding bond0 member interface 'eth2'
set interfaces bonding bond0 member interface 'eth3'
set interfaces bonding bond0 member interface 'eth4'
set interfaces bonding bond0 mode '802.3ad'
set interfaces bonding bond0 vif 1611 address '172.16.11.254/24'
set interfaces bonding bond0 vif 1611 description 'INFRA'
set interfaces bonding bond0 vif 1611 mtu '1500'
set interfaces bonding bond0 vif 1612 address '172.16.12.254/24'
set interfaces bonding bond0 vif 1612 description 'HOME'
set interfaces bonding bond0 vif 1612 mtu '1500'
set interfaces bonding bond0 vif 1613 address '172.16.13.254/24'
set interfaces bonding bond0 vif 1613 description 'IoT'
set interfaces bonding bond0 vif 1613 mtu '1500'
set interfaces bonding bond0 vif 1614 address '172.16.14.254/24'
set interfaces bonding bond0 vif 1614 description 'CCTV'
set interfaces bonding bond0 vif 1614 mtu '1500'