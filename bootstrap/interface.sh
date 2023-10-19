#!/bin/vbash
# shellcheck disable=all

set interfaces ethernet eth0 hw-id '98:fa:9b:36:b1:0c'
set interfaces ethernet eth1 hw-id 'ec:0d:9a:02:85:30'
set interfaces ethernet eth2 hw-id 'ec:0d:9a:02:85:31'

set interfaces bonding bond0 address '172.16.10.254/24'
set interfaces bonding bond0 description 'MGMT'
set interfaces bonding bond0 hash-policy 'layer2'
set interfaces bonding bond0 member interface 'eth1'
set interfaces bonding bond0 member interface 'eth2'
set interfaces bonding bond0 mode '802.3ad'
set interfaces bonding bond0 mtu '9014'
set interfaces bonding bond0 vif 1616 description 'WAN'
set interfaces bonding bond0 vif 1616 mtu '1508'