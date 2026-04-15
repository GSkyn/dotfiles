#!/usr/bin/env bash

# Define the menu options with FontAwesome icons
shutdown=" "
reboot=" "
lock=" "
logout=""

# Pass the options to Rofi and store the result
options="$shutdown\n$reboot\n$lock\n$logout"
chosen="$(echo -e "$options" | rofi -theme ~/.config/rofi/bspwm/power.rasi -dmenu -selected-row 0)"

# Execute the corresponding command
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        betterlockscreen -l dim
        ;;
    $logout)
        # Exits BSPWM gracefully
        pkill x
        ;;
esac
