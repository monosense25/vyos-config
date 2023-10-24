#!/bin/vbash
# shellcheck disable=all

set container network containers description 'Network for containers'
set container network containers prefix '10.11.11.0/24'

# adguardhome
set container name adguar cap-add 'net-bind-service'
set container name adguard image 'docker.io/adguard/adguardhome:v0.107.39'
set container name adguard memory '0'
set container name adguard network CONTAINERS address '10.11.11.2'
set container name adguard restart 'on-failure'
set container name adguard shared-memory '0'
set container name adguard volume config source '/config/containers/adguard/config'
set container name adguard volume config destination '/opt/adguardhome/conf'
set container name adguard volume config mode 'rw'
set container name adguard volume work source '/config/containers/adguard/work'
set container name adguard volume work destination '/opt/adguardhome/work'
set container name adguard volume work mode 'rw'

# bind
set container name bind cap-add 'net-bind-service'
set container name bind environment TZ value 'Asia/Jakarta'
set container name bind image 'docker.io/internetsystemsconsortium/bind9:9.19'
set container name bind command '/usr/sbin/named -4 -f -c /etc/bind/named.conf -u bind'
set container name bind memory '0'
set container name bind network containers address '10.11.11.3'
set container name bind restart 'on-failure'
set container name bind shared-memory '0'
set container name bind volume config destination '/etc/bind'
set container name bind volume config source '/config/containers/bind/config'
set container name bind volume config mode 'ro'
set container name bind volume cache source '/tmp/bind/cache'
set container name bind volume cache destination '/var/cache/bind'
set container name bind volume cache mode 'rw'

# haproxy-k8s-api
set container name haproxy-k8s-api image 'docker.io/library/haproxy:2.8.3'
set container name haproxy-k8s-api environment TZ value 'Asia/Jakarta'
set container name haproxy-k8s-api memory '0'
set container name haproxy-k8s-api network containers address '10.11.11.4'
set container name haproxy-k8s-api restart 'on-failure'
set container name haproxy-k8s-api shared-memory '0'
set container name haproxy-k8s-api volume config source '/config/containers/haproxy/config/haproxy.cfg'
set container name haproxy-k8s-api volume config destination '/usr/local/etc/haproxy/haproxy.cfg'
set container name haproxy-k8s-api volume config mode 'ro'

# dnsdist
set container name dnsdist cap-add 'net-bind-service'
set container name dnsdist environment TZ value 'Asia/Jakarta'
set container name dnsdist image 'docker.io/powerdns/dnsdist-18:1.8.2'
set container name dnsdist arguments '--log-timestamps'
set container name dnsdist memory '0'
set container name dnsdist network containers address '10.11.11.5'
set container name dnsdist restart 'on-failure'
set container name dnsdist shared-memory '0'
set container name dnsdist volume config source '/config/containers/dnsdist/config/dnsdist.conf'
set container name dnsdist volume config destination '/etc/dnsdist/dnsdist.conf'
set container name dnsdist volume config mode 'ro'

# omada
set container name omada environment TZ value 'Asia/Jakarta'
set container name omada image 'docker.io/mbentley/omada-controller:5.12'
set container name omada memory '0'
set container name omada network containers address '10.11.11.6'
set container name omada restart 'on-failure'
set container name omada shared-memory '0'
set container name omada volume data destination '/opt/tplink/EAPController/data'
set container name omada volume data mode 'rw'
set container name omada volume data source '/config/containers/omada/data'
set container name omada volume logs destination '/opt/tplink/EAPController/logs'
set container name omada volume logs mode 'rw'
set container name omada volume logs source '/config/containers/omada/logs'


# cloudflare-ddns
set container name cloudflare-ddns allow-host-networks
set container name cloudflare-ddns environment CF_API_TOKEN value "${SECRET_CLOUDFLARE_DDNS_TOKEN}"
set container name cloudflare-ddns environment DOMAINS value "${SECRET_CLOUDFLARE_DDNS_DOMAINS}"
set container name cloudflare-ddns environment IP4_PROVIDER value 'local'
set container name cloudflare-ddns environment IP6_PROVIDER value 'none'
set container name cloudflare-ddns environment PGID value '1000'
set container name cloudflare-ddns environment PUID value '1000'
set container name cloudflare-ddns environment TZ value 'Asia/Jakarta'
set container name cloudflare-ddns environment UPDATE_CRON value '@every 2m'
set container name cloudflare-ddns image 'docker.io/favonia/cloudflare-ddns:1.10.1'
set container name cloudflare-ddns memory '0'
set container name cloudflare-ddns restart 'on-failure'
set container name cloudflare-ddns shared-memory '0'

# node-exporter
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.6.1'
set container name node-exporter memory '0'
set container name node-exporter allow-host-networks
set container name node-exporter restart 'on-failure'
set container name node-exporter shared-memory '0'
set container name node-exporter volume procfs source '/proc'
set container name node-exporter volume procfs destination '/host/proc'
set container name node-exporter volume procfs mode 'ro'
set container name node-exporter volume rootfs source '/'
set container name node-exporter volume rootfs destination '/host/rootfs'
set container name node-exporter volume rootfs mode 'ro'
set container name node-exporter volume sysfs source '/sys'
set container name node-exporter volume sysfs destination '/host/sys'
set container name node-exporter volume sysfs mode 'ro'

# speedtest-exporter
set container name speedtest-exporter image 'ghcr.io/miguelndecarvalho/speedtest-exporter:v3.5.4'
set container name speedtest-exporter memory '0'
set container name speedtest-exporter allow-host-networks
set container name speedtest-exporter restart 'on-failure'
set container name speedtest-exporter shared-memory '0'

# udp-broadcast-relay-mdns
set container name udp-broadcast-relay-mdns allow-host-networks
set container name udp-broadcast-relay-mdns cap-add 'net-raw'
set container name udp-broadcast-relay-mdns environment CFG_DEV value 'bond0.1611;bond0.1613'
set container name udp-broadcast-relay-mdns environment CFG_ID value '2'
set container name udp-broadcast-relay-mdns environment CFG_MULTICAST value '224.0.0.251'
set container name udp-broadcast-relay-mdns environment CFG_PORT value '5353'
set container name udp-broadcast-relay-mdns environment SEPARATOR value ';'
set container name udp-broadcast-relay-mdns image 'ghcr.io/onedr0p/udp-broadcast-relay-redux:1.0.27'
set container name udp-broadcast-relay-mdns memory '0'
set container name udp-broadcast-relay-mdns restart 'on-failure'
set container name udp-broadcast-relay-mdns shared-memory '0'

