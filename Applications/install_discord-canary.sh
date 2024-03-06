#!/bin/bash

#TODO: Add the ability to delete old discord canary for updates
cd /home/ppg/Downloads/

wget 'https://discord.com/api/download/canary?platform=linux&format=tar.gz' -O discord-canary.tar.gz

tar -xvf ./discord-canary.tar.gz
rm ./discord-canary.tar.gz 
sudo mv ./DiscordCanary /opt/discordcanary
sudo ln -s /opt/discordcanary/DiscordCanary /usr/bin/


