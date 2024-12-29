#!/bin/bash

# Path to the folder containing wallpapers
WALLPAPER_FOLDER="$HOME/Downloads/Wallpaper"

# Path to Hyprpaper configuration file
HYPERPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# Check if the wallpaper folder exists
if [[ ! -d "$WALLPAPER_FOLDER" ]]; then
    echo "Wallpaper folder not found: $WALLPAPER_FOLDER"
    exit 1
fi

# Get a random wallpaper from the folder
RANDOM_WALLPAPER=$(find "$WALLPAPER_FOLDER" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)

# Check if a wallpaper was found
if [[ -z "$RANDOM_WALLPAPER" ]]; then
    echo "No wallpapers found in folder: $WALLPAPER_FOLDER"
    exit 1
fi

hyprctl hyprpaper unload all

# Update Hyprpaper configuration
echo -e "preload = $RANDOM_WALLPAPER\nwallpaper = ,$RANDOM_WALLPAPER" > "$HYPERPAPER_CONFIG"

# Restart Hyprpaper to apply changes
pkill hyprpaper
hyprpaper &

echo "Random wallpaper set: $RANDOM_WALLPAPER"
