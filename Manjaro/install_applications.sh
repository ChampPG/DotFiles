#TODO Figure out what applications I need installed

# discord discord-canary telegram syncthing nfs-common obsidian 
# kali tools (john, hashcat, nmap, burp)

# Standard installed
sudo pacman -S discord telegram-desktop syncthing \
  nfs-utils obsidian torbrowser-launcher wireguard-tools nmap \
  python3 python-virtualenv curl wget 


cd /home/ppg/Downloads/

wget 'https://discord.com/api/download/canary?platform=linux&format=tar.gz' -O discord-canary.tar.gz

tar -xvf ./discord-canary.tar.gz
rm ./discord-canary.tar.gz 
sudo mv ./DiscordCanary /opt/discordcanary
sudo ln -s /opt/discordcanary/DiscordCanary /usr/bin/

