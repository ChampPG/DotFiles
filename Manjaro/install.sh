#!/bin/bash

# Check if username is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Resolve full path of the user's home directory
USER_HOME=$(eval echo ~$1)

# Install dependencies
sudo pacman -S neovim python-pynvim kitty zsh lazygit fzf fd

# Create directories if they don't exist
mkdir -p "$USER_HOME/powerlevel10k/"
mkdir -p "$USER_HOME/.config/nvim"
mkdir -p "$USER_HOME/.config/kitty"
mkdir -p "$USER_HOME/.config/zsh"
mkdir -p "$USER_HOME/.config/nvm"
mkdir -p "$USER_HOME/.fonts/"
mkdir -p "$USER_HOME/Pictures/Backgrounds"


# Symlink files to respective directories
ln -s "$PWD/Backgrounds" "$USER_HOME/Pictures/Backgrounds"
ln -s "$PWD/fonts" "$USER_HOME/.fonts/"
ln -s "$PWD/nvm" "$USER_HOME/.config/nvm"
ln -s "$PWD/kitty" "$USER_HOME/.config/kitty"
ln -s "$PWD/nvim/*" "$USER_HOME/.config/nvim/"
ln -s "$PWD/powerlevel10k" "$USER_HOME/powerlevel10k/"
ln -s "$PWD/p10k.zsh" "$USER_HOME/.p10k.zsh"
ln -s "$PWD/zsh_plugins.txt" "$USER_HOME/.zsh_plugins.txt"
ln -s "$PWD/zshrc" "$USER_HOME/.zshrc"

echo "Setup complete!"
