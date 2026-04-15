#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 1. Create a quick list of files + their image paths for Rofi
get_walls() {
    for file in "$WALLPAPER_DIR"/*; do
        [ -f "$file" ] || continue
        name=$(basename "$file")
        echo -en "$name\0icon\x1f$file\n"
    done
}

# 2. Run Rofi with a shorter window height
selected=$(get_walls | rofi -dmenu -i -p "󰸉" -show-icons \
    -theme-str 'window { width: 900px; height: 600px; border: 2px; border-color: #eb6f92; background-color: #232136; font: "JetBrainsMono Nerd Font 11"; }' \
    -theme-str 'mainbox { children: [ inputbar, listview ]; background-color: transparent; }' \
    -theme-str 'inputbar { background-color: #2a273f; margin: 15px 20px 10px 20px; padding: 8px; children: [ prompt, entry ]; }' \
    -theme-str 'prompt { text-color: #eb6f92; padding: 0 10px; }' \
    -theme-str 'entry { placeholder: "Search Wallpaper"; placeholder-color: #6e6a86; text-color: #e0def4; horizontal-align: 0.5; }' \
    -theme-str 'listview { columns: 4; lines: 2; spacing: 15px; padding: 0 20px 15px 20px; background-color: transparent; fixed-columns: true; }' \
    -theme-str 'element { orientation: vertical; background-color: transparent; padding: 10px; }' \
    -theme-str 'element-icon { size: 140px; margin: 0; horizontal-align: 0.5; }' \
    -theme-str 'element-text { horizontal-align: 0.5; text-color: #908caa; }' \
    -theme-str 'element selected.normal { background-color: #393552; border: 0 0 4px 0; border-color: #eb6f92; }' \
    -theme-str 'element-text selected.normal { text-color: #e0def4; }')

# 3. If a selection was made, set it with feh
if [ -n "$selected" ]; then
    feh --bg-fill "$WALLPAPER_DIR/$selected"
    
    # Save the choice so it persists after reboot
    echo "feh --bg-fill '$WALLPAPER_DIR/$selected'" > ~/.fehbg
fi
