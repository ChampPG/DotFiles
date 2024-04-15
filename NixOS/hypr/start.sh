#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpapers
swww img ~/DotFiles/backgrounds/catppuccin_triangle.png &

# Waybar
waybar &
