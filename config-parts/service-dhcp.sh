#!/bin/vbash
# shellcheck disable=all

# DHCP Global configs
set service dhcp-server hostfile-update
set service dhcp-server host-decl-name
set service dhcp-server global-parameters 'option omada-address code 138 = ip-address;'
set service dhcp-server dynamic-dns-update
set service dhcp-server global-parameters "key ddnsupdate { algorithm hmac-sha256; secret ${SECRET_BIND_DDNS_KEY}; };"
set service dhcp-server global-parameters "zone monosense.io. { primary 10.11.11.3; key ddnsupdate; }"
set service dhcp-server global-parameters "ddns-domainname &quot;monosense.io.&quot;;"
set service dhcp-server global-parameters "ddns-rev-domainname &quot;in-addr.arpa.&quot;;"
set service dhcp-server global-parameters "zone in-addr.arpa. { primary 10.11.11.3; key ddnsupdate; }"
set service dhcp-server global-parameters "zone 16.172.in-addr.arpa. { primary 10.11.11.3; key ddnsupdate; }"
set service dhcp-server global-parameters "update-optimization false;"

# Management VLAN
set service dhcp-server shared-network-name MANAGEMENT authoritative
set service dhcp-server shared-network-name MANAGEMENT ping-check
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 subnet-parameters 'option omada-address 10.11.11.6;'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 default-router '172.16.10.254'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 lease '86400'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 range 0 start '172.16.10.200'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 range 0 stop '172.16.10.253'
# Static Mapping MGMT
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping core ip-address '172.16.10.1'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping core mac-address '1c:61:b4:95:30:e1'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping poe ip-address '172.16.10.2'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping poe mac-address '30:de:4b:30:fc:30'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping tor01 ip-address '172.16.10.3'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping tor01 mac-address '28:87:ba:b1:3e:0d'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping tor02 ip-address '172.16.10.4'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping tor02 mac-address '28:87:ba:b1:3e:0b'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping iap01 ip-address '172.16.10.8'
set service dhcp-server shared-network-name MANAGEMENT subnet 172.16.10.0/24 static-mapping iap01 mac-address '34:60:f9:93:67:c0'

# INFRA VLAN
set service dhcp-server shared-network-name INFRA authoritative
set service dhcp-server shared-network-name INFRA ping-check
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 default-router '172.16.11.254'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 lease '86400'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 range 0 start '172.16.11.200'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 range 0 stop '172.16.11.253'
# Static Mapping INFRA
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m0 ip-address '172.16.11.10'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m0 mac-address "${SECRET_K8S_M0_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m1 ip-address '172.16.11.11'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m1 mac-address "${SECRET_K8S_M1_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m2 ip-address '172.16.11.12'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m2 mac-address "${SECRET_K8S_M2_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w0 ip-address '172.16.11.13'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w0 mac-address "${SECRET_K8S_W0_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w1 ip-address '172.16.11.14'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w1 mac-address "${SECRET_K8S_W1_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w2 ip-address '172.16.11.15'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w2 mac-address "${SECRET_K8S_W2_MAC}"
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w3 ip-address '172.16.11.16'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w3 mac-address "${SECRET_K8S_W3_MAC}"

# HOME VLAN
set service dhcp-server shared-network-name HOME authoritative
set service dhcp-server shared-network-name HOME ping-check
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 default-router '172.16.12.254'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 lease '86400'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 range 0 start '172.16.12.200'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 range 0 stop '172.16.12.253'
# Static Mapping HOME
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-p30-pro ip-address '172.16.12.100'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-p30-pro mac-address '72:93:59:73:71:e4'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-laptop-wifi ip-address '172.16.12.101'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-laptop-wifi mac-address '9c:2f:9d:9c:e4:fb'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-laptop-eth ip-address '172.16.12.102'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezzel-laptop-eth mac-address ''
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-galaxy-s20 ip-address '172.16.12.103'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-galaxy-s20 mac-address 'f2:42:70:72:49:93'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-laptop-wifi ip-address '172.16.12.104'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-laptop-wifi mac-address '10:b1:df:d4:bb:d1'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-laptop-eth ip-address '172.16.12.105'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 static-mapping ezky-laptop-eth mac-address ''

# IoT VLAN
set service dhcp-server shared-network-name IOT authoritative
set service dhcp-server shared-network-name IOT ping-check
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 default-router '172.16.13.254'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 lease '86400'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 range 0 start '172.16.13.200'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 range 0 stop '172.16.13.253'
# Static Mapping IoT
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em00 ip-address '172.16.13.100'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em00 mac-address '34:94:54:74:7a:52'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em01 ip-address '172.16.13.101'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em01 mac-address '80:7d:3a:32:bc:3d'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em02 ip-address '172.16.13.102'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em02 mac-address 'f4:cf:a2:f6:00:50'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em03 ip-address '172.16.13.103'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em03 mac-address '84:cc:a8:9c:18:ae'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em04 ip-address '172.16.13.104'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em04 mac-address '84:cc:a8:9b:f1:88'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em05 ip-address '172.16.13.105'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em05 mac-address '98:f4:ab:e2:db:ec'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups1-plug ip-address '172.16.13.106'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups1-plug mac-address '10:d5:61:d0:72:ed'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups2-plug ip-address '172.16.13.107'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups2-plug mac-address '24:a1:60:1c:d8:7b'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups3-plug ip-address '172.16.13.108'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups3-plug mac-address '10:d5:61:d1:94:ea'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-water-pump-plug ip-address '172.16.13.109'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-water-pump-plug mac-address '10:d5:61:31:71:e8'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-booster-pump-plug ip-address '172.16.13.110'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-booster-pump-plug mac-address '10:d5:61:30:ff:37'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping masterbedroom-plug ip-address '172.16.13.111'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping masterbedroom-plug mac-address '10:d5:61:ca:92:9a'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping farezzbedroom-plug ip-address '172.16.13.112'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping farezzbedroom-plug mac-address '10:d5:61:d2:61:b9'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-rack-fans-plug ip-address '172.16.13.113'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-rack-fans-plug mac-address '10:d5:61:2f:5b:0d'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping guestroom-led-strip ip-address '172.16.13.114'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping guestroom-led-strip mac-address '40:f5:20:1f:5f:06'

# CCTV VLAN
set service dhcp-server shared-network-name CCTV authoritative
set service dhcp-server shared-network-name CCTV ping-check
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 default-router '172.16.14.254'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 lease '86400'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 range 0 start '172.16.14.200'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 range 0 stop '172.16.14.253'
# Static Mapping CCTV
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping nvr ip-address '172.16.14.100'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping nvr mac-address ''
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc01 ip-address '172.16.14.101'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc01 mac-address ''
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc02 ip-address '172.16.14.102'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc02 mac-address ''
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc03 ip-address '172.16.14.103'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc03 mac-address ''
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc04 ip-address '172.16.14.104'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc04 mac-address ''
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc05 ip-address '172.16.14.105'
set service dhcp-server shared-network-name CCTV subnet 172.16.14.0/24 static-mapping ipc05 mac-address ''
