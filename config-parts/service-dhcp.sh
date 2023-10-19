#!/bin/vbash
# shellcheck disable=all

# DHCP Global configs
set service dhcp-server hostfile-update
set service dhcp-server host-decl-name
set service dhcp-server global-parameters 'option omada-address code 138 = ip-address;'
set service dhcp-server dynamic-dns-update
set service dhcp-server global-parameters "key ddnsupdate { algorithm hmac-md5; secret ${SECRET_BIND_DDNS_KEY}; };"
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

set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m0 ip-address '172.16.11.10'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m0 mac-address '${SECRET_K8S_M0_MAC}'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m1 ip-address '172.16.11.11'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m1 mac-address '${SECRET_K8S_M1_MAC}'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m2 ip-address '172.16.11.12'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-m2 mac-address '${SECRET_K8S_M2_MAC}'

set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w0 ip-address '172.16.11.13'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w0 mac-address '${SECRET_K8S_W0_MAC}'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w1 ip-address '172.16.11.14'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w1 mac-address '${SECRET_K8S_W1_MAC}'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w2 ip-address '172.16.11.15'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w2 mac-address '${SECRET_K8S_W2_MAC}'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w3 ip-address '172.16.11.16'
set service dhcp-server shared-network-name INFRA subnet 172.16.11.0/24 static-mapping k8s-w3 mac-address '${SECRET_K8S_W3_MAC}'

# HOME VLAN
set service dhcp-server shared-network-name HOME authoritative
set service dhcp-server shared-network-name HOME ping-check
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 default-router '172.16.12.254'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 lease '86400'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 name-server '10.11.11.5'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 range 0 start '172.16.12.200'
set service dhcp-server shared-network-name HOME subnet 172.16.12.0/24 range 0 stop '172.16.12.253'

# IoT VLAN
set service dhcp-server shared-network-name IOT authoritative
set service dhcp-server shared-network-name IOT ping-check
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 default-router '172.16.13.254'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 domain-name 'monosense.io'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 lease '86400'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 name-server '10.11.11.2'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 range 0 start '172.16.13.200'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 range 0 stop '172.16.13.253'

# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em00 ip-address '172.16.13.1'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em00 mac-address '34:94:54:74:7a:52'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em01 ip-address '172.16.13.2'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em01 mac-address '80:7d:3a:32:bc:3d'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em02 ip-address '172.16.13.3'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em02 mac-address 'f4:cf:a2:f6:00:50'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em03 ip-address '172.16.13.4'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em03 mac-address '84:cc:a8:9c:18:ae'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em04 ip-address '172.16.13.5'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em04 mac-address '84:cc:a8:9b:f1:88'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em05 ip-address '172.16.13.6'
# set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping em05 mac-address '98:f4:ab:e2:db:ec'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups1-plug ip-address '172.16.13.7'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups1-plug mac-address '10:d5:61:d0:72:ed'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups2-plug ip-address '172.16.13.8'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups2-plug mac-address '24:a1:60:1c:d8:7b'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups3-plug ip-address '172.16.13.9'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-ups3-plug mac-address '10:d5:61:d1:94:ea'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-water-pump-plug ip-address '172.16.13.10'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-water-pump-plug mac-address '10:d5:61:31:71:e8'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-booster-pump-plug ip-address '172.16.13.11'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping backyard-booster-pump-plug mac-address '10:d5:61:30:ff:37'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping masterbedroom-plug ip-address '172.16.13.12'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping masterbedroom-plug mac-address '10:d5:61:ca:92:9a'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping farezzbedroom-plug ip-address '172.16.13.13'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping farezzbedroom-plug mac-address '10:d5:61:d2:61:b9'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-rack-fans-plug ip-address '172.16.13.14'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping office-rack-fans-plug mac-address '10:d5:61:2f:5b:0d'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping guestroom-led-strip ip-address '172.16.13.15'
set service dhcp-server shared-network-name IOT subnet 172.16.13.0/24 static-mapping guestroom--led-strip mac-address '40:f5:20:1f:5f:06'


# LAN
set service dhcp-server shared-network-name LAN authoritative
set service dhcp-server shared-network-name LAN ping-check
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 default-router '10.1.0.1'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 start '10.1.0.200'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 stop '10.1.0.254'

set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap01 ip-address '10.1.0.21'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap01 mac-address '44:d9:e7:fc:21:f9'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap02 ip-address '10.1.0.22'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap02 mac-address 'fc:ec:da:b6:27:87'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap03 ip-address '10.1.0.23'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap03 mac-address 'e0:63:da:ac:d4:3e'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap04 ip-address '10.1.0.24'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap04 mac-address '80:2a:a8:d3:0b:b3'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch01 ip-address '10.1.0.11'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch01 mac-address '70:a7:41:f3:c8:92'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch02 ip-address '10.1.0.12'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch02 mac-address '68:d7:9a:3c:b0:75'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch03 ip-address '10.1.0.13'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch03 mac-address '74:83:c2:0c:19:90'

# Trusted VLAN
set service dhcp-server shared-network-name TRUSTED authoritative
set service dhcp-server shared-network-name TRUSTED ping-check
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 default-router '10.1.2.1'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 domain-name 'bjw-s.casa'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 lease '86400'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 range 0 start '10.1.2.200'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 range 0 stop '10.1.2.254'

set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-ipad ip-address '10.1.2.32'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-ipad mac-address '54:62:e2:53:72:1b'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-iphone ip-address '10.1.2.31'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-iphone mac-address '24:5e:48:98:39:1c'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-macbook ip-address '10.1.2.21'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bernd-macbook mac-address 'f8:4d:89:7a:db:8b'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping eva-ipad ip-address '10.1.2.35'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping eva-ipad mac-address 'aa:ab:96:ce:f8:03'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-ipad ip-address '10.1.2.34'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-ipad mac-address '94:bf:2d:f0:3f:c3'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-iphone ip-address '10.1.2.33'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-iphone mac-address '8c:98:6b:a9:18:cb'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-macbook ip-address '10.1.2.22'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping manyie-macbook mac-address '8c:85:90:18:42:38'

# Video VLAN
set service dhcp-server shared-network-name VIDEO authoritative
set service dhcp-server shared-network-name VIDEO ping-check
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 default-router '10.1.4.1'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 domain-name 'bjw-s.casa'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 lease '86400'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 range 0 start '10.1.4.200'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 range 0 stop '10.1.4.254'

set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 static-mapping driveway-camera-doorbell ip-address '10.1.4.12'
set service dhcp-server shared-network-name VIDEO subnet 10.1.4.0/24 static-mapping driveway-camera-doorbell mac-address 'ec:71:db:88:50:f8'
