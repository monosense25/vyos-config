; Make sure to update the epoch time in the SOA records so coreDNS picks up the changes automatically
; https://www.epochconverter.com/

; SOA Records
$TTL 3600
$ORIGIN monosense.io
@ 3600 IN SOA vg.monosense.io. vg.monosense.io. (
  1697718828         ; serial number (epoch timestamp)
  7200               ; refresh period
  3600               ; retry period
  1209600            ; expire time
  3600               ; minimum ttl
)

; NS Records
@                           IN  NS  vg.monosense.io.

; MANAGEMENT bond0
core                        IN  A   172.16.10.1
poe                         IN  A   172.16.10.2
tor01                       IN  A   172.16.10.3
tor02                       IN  A   172.16.10.4
bsw01                       IN  A   172.16.10.5
oap01                       IN  A   172.16.10.6
oap02                       IN  A   172.16.10.7
iap01                       IN  A   172.16.10.8
iap02                       IN  A   172.16.10.9
vg-ipmi                     IN  A   172.16.10.10
wlc                         IN  A   172.16.10.11
san-ipmi                    IN  A   172.16.10.12
vg                          IN  A   172.16.10.254

; INFRA bond0.1611
san                         IN  A   172.16.11.1
s3                          IN  A   172.16.11.2
csi                         IN  A   172.16.11.3
m910q01                     IN  A   172.16.11.4
m910q02                     IN  A   172.16.11.5
m910q03                     IN  A   172.16.11.6
;
k8s-m0                      IN  A   172.16.11.10
k8s-m1                      IN  A   172.16.11.11
k8s-m2                      IN  A   172.16.11.12
k8s-w0                      IN  A   172.16.11.13
k8s-w1                      IN  A   172.16.11.14
k8s-w2                      IN  A   172.16.11.15
k8s-w3                      IN  A   172.16.11.16

; HOME bond0.1612
; start from .100-199

; IOT bond0.1613
; start from .100-199
em00                        IN  A   172.16.13.100
em01                        IN  A   172.16.13.101
em02                        IN  A   172.16.13.102
em03                        IN  A   172.16.13.103
em04                        IN  A   172.16.13.104
em05                        IN  A   172.16.13.105
office-ups1-plug            IN  A   172.16.13.106
office-ups2-plug            IN  A   172.16.13.107
office-ups3-plug            IN  A   172.16.13.108
backyard-water-pump-plug    IN  A   172.16.13.109
backyard-booster-pump-plug  IN  A   172.16.13.110
masterbedroom-plug          IN  A   172.16.13.111
farezzbedroom-plug          IN  A   172.16.13.112
office-rack-fans-plug       IN  A   172.16.13.113
guestroom-led-strip         IN  A   172.16.13.114


; CCTV bond0.1614
; start from .100-199
nvr                         IN  A   172.16.14.100
ipc01                       IN  A   172.16.14.101 
ipc02                       IN  A   172.16.14.102
ipc03                       IN  A   172.16.14.103
icp04                       IN  A   172.16.14.104
ipc05                       IN  A   172.16.14.105

; CONTAINERS
adguard                     IN  A   10.11.11.2
ns1                         IN  A   10.11.11.3
cluster-0                   IN  A   10.11.11.4
ns                          IN  A   10.11.11.5
omada                       IN  A   10.11.11.6
oneconnect                  IN  A   10.11.11.7
onepass                     IN  A   10.11.11.8

; SERVICES / CILIUM K8S LB NON VLAN
nginx-ingress               IN  A   10.11.10.1
vector                      IN  A   10.11.10.2
plex                        IN  A   10.11.10.3

; CNAME

; WIREGUARD

