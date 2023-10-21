<div align="center">

<img src="https://vyos.io/wp-content/themes/vyos_theme/images/main/vyos-logo.svg" align="center" width="144px" height="144px"/>
</div>
<br/>
<p align="center">
  <img src="https://img.shields.io/badge/VyOS_Version-1.4.rolling.202310130306-blue?style=for-the-badge">
  <img src="https://img.shields.io/github/languages/code-size/monosense25/vyos-config?style=for-the-badge">
  <img src="https://img.shields.io/github/last-commit/monosense25/vyos-config/main?style=for-the-badge">
</p>


### VyOS IaC configuration

## :book:&nbsp; Overview

This repository contains my [VyOS](https://docs.vyos.io/en/latest/index.html) configuration in a declarative state.
Everything I have here can be applied to the machine by running [apply-config.sh](./apply-config.sh) script in the machine.

## :computer:&nbsp; Hardware

**Lenovo Thinkcentre M920x**  :
- Core i5-8500 3.0GHz 
- DDR4 2666v 2x16GB
- Intel NVMe 512GB
- 1x1Gbps Intel I219-LM (On Board)
- 2x10Gbps Mellanox Connect-X 3 Pro EN (MCX312B-XCCT)


## :inbox_tray:&nbsp; Quickstart

After installing VyOS in your machine, setup your LAN and WAN interface and make sure it can talk to the internet.
Something like this may do:

```
configure
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth1 address 192.168.10.1/24
set system name-server 1.1.1.1
commit
```

Once you're done, connect your workstation to the `eth1` and set a static IP in the `192.168.10.1/24` range.
Then you can run [bootstrap.sh](./bootstrap.sh) and follow the instruction on your screen:
```
bash <(curl -s https://raw.githubusercontent.com/monosense25/vyos-config/main/bootstrap.sh)
```

The bootstrap script will:

1. Generate SSH keypair in `/config/secrets`.
2. Enable SSH access to itself.
3. Print the `scp` command to send `age` secret key into `/config/secrets` and getting the generated public key.
4. Pulling your repository into `/config` directory.
5. Generate container config files inside [containers](./containers) directory if they have `.bootstrap.tmpl` extension with secrets substituted.
6. Pull container images needed for bootstrap process.
7. Applying `set` commands inside [bootstrap](./bootstrap) directory.

After bootstrapping, you don't need to run it anymore although it should be pretty idempotent.

## :gear:&nbsp; Chore

Everytime you want to change something, do it inside `/config` directory and then run [apply-config.sh](./apply-config.sh) with `-c` flag.
Don't forget to push the changes to your remote repository too.
This will ensure the state of this repository to be the same as the machine configuration.

## :handshake:&nbsp; Thanks

A lot of inspiration in this repository came from:
- [budimanjojo](https://github.com/budimanjojo/vyos-config)
- [bjw-s](https://github.com/bjw-s/vyos-config)
- [scotte](https://github.com/szinn/vyos-config)
