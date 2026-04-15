#!/usr/bin/env bash

# Use cliphist to list items, rofi to select, and cliphist to decode/copy
cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi -p "Clipboard" | cliphist decode | wl-copy
