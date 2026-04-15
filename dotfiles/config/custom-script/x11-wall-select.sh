#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"

# Find images and format them for rofi
SELECTED=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -printf "%f\n" | \
while read -r file; do
    echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
done | rofi -dmenu -i -show-icons -theme ~/.config/rofi/gruvbox-wall.rasi -p "Wallpaper")

# If a selection was made, set it with feh
if [[ -n "$SELECTED" ]]; then
    # feh automatically sets the wallpaper and generates a perfect ~/.fehbg file
    feh --bg-fill "$WALL_DIR/$SELECTED"
fi
