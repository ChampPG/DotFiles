#!/bin/bash

#TODO: Figure out what applications I need installed

# discord discord-canary telegram syncthing nfs-common obsidian 
# kali tools (john, hashcat, nmap, burp)

# Standard installed
sudo pacman -S discord telegram-desktop syncthing \
  nfs-utils obsidian torbrowser-launcher wireguard-tools nmap \
  python3 python-virtualenv curl wget github-cli

# cd /opt
# sudo git clone https://aur.archlinux.org/yay-git.git
# sudo chown -R $1:$1 ./yay-git
# cd yay-git
# sudo pacman -S --needed base-devel
# makepkg -si
#
