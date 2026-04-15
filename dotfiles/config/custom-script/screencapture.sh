#!/usr/bin/env bash

# Create directory if it doesn't exist
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# File name with timestamp
FILE="$DIR/screenshot_$(date +'%Y%m%d_%H%M%S').png"

# Select region and take screenshot
# -g "$(slurp)" allows mouse selection
# wl-copy puts it in clipboard
# notify-send triggers your Mako notification
if grim -g "$(slurp)" "$FILE"; then
    wl-copy < "$FILE"
    notify-send "Screenshot Captured" "Saved to ~/Pictures/Screenshots and copied to clipboard." -i "$FILE"
else
    notify-send "Screenshot Canceled" "No area was selected."
fi
