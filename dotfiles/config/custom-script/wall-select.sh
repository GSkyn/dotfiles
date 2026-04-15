#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# Find images and format them for rofi
SELECTED=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -printf "%f\n" | \
while read -r file; do
    echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
done | rofi -dmenu -i -show-icons -theme ~/.config/rofi/gruvbox-wall.rasi -p "Wallpaper")

# If a wallpaper was selected, apply it and save the state
if [[ -n "$SELECTED" ]]; then
    # Create a symlink to the chosen wallpaper
    ln -sf "$WALL_DIR/$SELECTED" "$CACHE_FILE"
    
    # Kill the current swaybg instance
    killall swaybg
    
    # Launch the new wallpaper using the symlink
    swaybg -i "$CACHE_FILE" -m fill &
fi
