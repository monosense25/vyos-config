#!/bin/vbash
# shellcheck disable=all

set firewall zone VYOS description 'VYOS router zone'
set firewall zone VYOS local-zone
set firewall zone VYOS default-action 'drop'
set firewall zone VYOS from MGMT firewall name 'MGMT-VYOS-v4'
set firewall zone VYOS from HOME firewall name 'HOME-VYOS-v4'
set firewall zone VYOS from IOT firewall name 'IOT-VYOS-v4'
set firewall zone VYOS from INFRA firewall name 'INFRA-VYOS-v4'
set firewall zone VYOS from CCTV firewall name 'CCTV-VYOS-v4'
set firewall zone VYOS from CONTAINERS firewall name 'CONTAINERS-VYOS-v4'
set firewall zone VYOS from WAN firewall name 'WAN-VYOS-v4'

set firewall zone MGMT description 'MGMT zone'
set firewall zone MGMT interface 'bond0'
set firewall zone MGMT default-action 'drop'
set firewall zone MGMT from VYOS firewall name 'VYOS-MGMT-v4'
set firewall zone MGMT from HOME firewall name 'HOME-MGMT-v4'
set firewall zone MGMT from IOT firewall name 'IOT-MGMT-v4'
set firewall zone MGMT from INFRA firewall name 'INFRA-MGMT-v4'
set firewall zone MGMT from CCTV firewall name 'CCTV-MGMT-v4'
set firewall zone MGMT from CONTAINERS firewall name 'CONTAINERS-MGMT-v4'
set firewall zone MGMT from WAN firewall name 'WAN-MGMT'

set firewall zone HOME description 'HOME zone'
set firewall zone HOME interface 'bond0.1612'
set firewall zone HOME default-action 'drop'
set firewall zone HOME from VYOS firewall name 'VYOS-HOME-v4'
set firewall zone HOME from MGMT firewall name 'MGMT-HOME-v4'
set firewall zone HOME from IOT firewall name 'IOT-HOME-v4'
set firewall zone HOME from INFRA firewall name 'INFRA-HOME-v4'
set firewall zone HOME from CCTV firewall name 'CCTV-HOME-v4'
set firewall zone HOME from CONTAINERS firewall name 'CONTAINERS-HOME-v4'
set firewall zone HOME from WAN firewall name 'WAN-HOME'

set firewall zone IOT description 'IOT VLAN zone'
set firewall zone IOT interface 'bond0.1613'
set firewall zone IOT default-action 'drop'
set firewall zone IOT from VYOS firewall name 'VYOS-IOT-v4'
set firewall zone IOT from MGMT firewall name 'MGMT-IOT-v4'
set firewall zone IOT from HOME firewall name 'HOME-IOT-v4'
set firewall zone IOT from INFRA firewall name 'INFRA-IOT-v4'
set firewall zone IOT from CCTV firewall name 'CCTV-IOT-v4'
set firewall zone IOT from CONTAINERS firewall name 'CONTAINERS-IOT-v4'
set firewall zone IOT from WAN firewall name 'WAN-IOT-v4'

set firewall zone INFRA description 'INFRA VLAN zone'
set firewall zone INFRA interface 'bond0.1611'
set firewall zone INFRA default-action 'drop'
set firewall zone INFRA from VYOS firewall name 'VYOS-INFRA-v4'
set firewall zone INFRA from MGMT firewall name 'MGMT-INFRA-v4'
set firewall zone INFRA from HOME firewall name 'HOME-INFRA-v4'
set firewall zone INFRA from IOT firewall name 'IOT-INFRA-v4'
set firewall zone INFRA from CCTV firewall name 'CCTV-INFRA-v4'
set firewall zone INFRA from CONTAINERS firewall name 'CONTAINERS-INFRA-v4'
set firewall zone INFRA from WAN firewall name 'WAN INFRA'

set firewall zone CCTV description 'CCTV VLAN zone'
set firewall zone CCTV interface 'bond0.1614'
set firewall zone CCTV default-action 'drop'
set firewall zone CCTV from VYOS firewall name 'VYOS-CCTV-v4'
set firewall zone CCTV from MGMT firewall name 'MGMT-CCTV-v4'
set firewall zone CCTV from HOME firewall name 'HOME-CCTV-v4'
set firewall zone CCTV from IOT firewall name 'IOT-CCTV-v4'
set firewall zone CCTV from INFRA firewall name 'INFRA-CCTV-v4'
set firewall zone CCTV from CONTAINERS firewall name 'CONTAINERS-CCTV-v4'
set firewall zone CCTV from WAN firewall name 'WAN-CCTV-v4'

set firewall zone CONTAINERS description 'CONTAINERS zone'
set firewall zone CONTAINERS interface 'pod-containers'
set firewall zone CONTAINERS default-action 'drop'
set firewall zone CONTAINERS from VYOS firewall name 'VYOS-CONTAINERS-v4'
set firewall zone CONTAINERS from MGMT firewall name 'MGMT-CONTAINERS-v4'
set firewall zone CONTAINERS from HOME firewall name 'HOME-CONTAINERS-v4'
set firewall zone CONTAINERS from IOT firewall name 'IOT-CONTAINERS-v4'
set firewall zone CONTAINERS from INFRA firewall name 'INFRA-CONTAINERS-v4'
set firewall zone CONTAINERS from CCTV firewall name 'CCTV-CONTAINERS-v4'
set firewall zone CONTAINERS from WAN firewall name 'WAN-CONTAINERS-v4'

set firewall zone WAN description 'WAN zone'
set firewall zone WAN interface 'pppoe0'
set firewall zone WAN default-action 'drop'
set firewall zone WAN from VYOS firewall name 'VYOS-WAN-v4'
set firewall zone WAN from MGMT firewall name 'MGMT-WAN-v4'
set firewall zone WAN from HOME firewall name 'HOME-WAN-v4'
set firewall zone WAN from IOT firewall name 'IOT-WAN-v4'
set firewall zone WAN from INFRA firewall name 'INFRA-WAN-v4'
set firewall zone WAN from CCTV firewall name 'CCTV-WAN-v4'
set firewall zone WAN from CONTAINERS firewall name 'CONTAINERS-WAN-v4'