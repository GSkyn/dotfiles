#!/usr/bin/env bash


# Define the options with Nerd Font icons

SHUTDOWN="⏻"
REBOOT=""
LOCK=""
EXIT="󰗼"

# Pipe options into rofi
SELECTED=$(echo -e "$SHUTDOWN\n$REBOOT\n$LOCK\n$EXIT" | rofi -dmenu -i -theme ~/.config/rofi/powermenu.rasi)

# Execute the corresponding command
case "$SELECTED" in
    "$LOCK")
        hyprlock & # Or swaylock
        ;;
    "$EXIT")
        bind = $mainMod, M, exec, sh -c 'loginctl terminate-session $XDG_SESSION_ID'
        ;;
    "$REBOOT")
        reboot
        ;;
    "$SHUTDOWN")
        poweroff
        ;;
esac
