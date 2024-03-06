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

# Function to move existing files to .bak directory
move_to_backup() {
    local file_path="$1"
    if [ -e "$file_path" ]; then
        mv "$file_path" "$file_path.bak"
        echo "Moved $file_path to $file_path.bak"
    fi
}

# File directory or file exists move to backup
move_to_backup "$USER_HOME/powerlevel10k/"
move_to_backup "$USER_HOME/.config/nvim"
move_to_backup "$USER_HOME/.config/kitty"
move_to_backup "$USER_HOME/.config/zsh"
move_to_backup "$USER_HOME/.config/nvm"
move_to_backup "$USER_HOME/.fonts/fonts"
move_to_backup "$USER_HOME/Pictures/Backgrounds"
move_to_backup "$USER_HOME/.zshrc"
move_to_backup "$USER_HOME/.zsh_plugins.txt"
move_to_backup "$USER_HOME/.p10k.zsh"

# Create directories if they don't exist
#mkdir -p "$USER_HOME/powerlevel10k/"
#mkdir -p "$USER_HOME/.config/nvim"
#mkdir -p "$USER_HOME/.config/kitty"
#mkdir -p "$USER_HOME/.config/zsh"
#mkdir -p "$USER_HOME/.config/nvm"
mkdir -p "$USER_HOME/.fonts/"
#mkdir -p "$USER_HOME/Pictures/Backgrounds"

# Symlink files to respective directories
ln -s "$PWD/Backgrounds" "$USER_HOME/Pictures/"
ln -s "$PWD/fonts" "$USER_HOME/.fonts/"
ln -s "$PWD/nvm" "$USER_HOME/.config/"
ln -s "$PWD/kitty" "$USER_HOME/.config/"
ln -s "$PWD/nvim/*" "$USER_HOME/.config/"
ln -s "$PWD/powerlevel10k" "$USER_HOME/"
ln -s "$PWD/p10k.zsh" "$USER_HOME/.p10k.zsh"
ln -s "$PWD/zsh_plugins.txt" "$USER_HOME/.zsh_plugins.txt"
ln -s "$PWD/zshrc" "$USER_HOME/.zshrc"

echo "Setup complete!"
