#!/bin/bash

# Define your meta-menu options with Nerd Font icons
options=" App Launcher\n Wallpapers\n System Monitor\n Audio Control\n Power Menu"

# Pipe the options into Rofi using your app_menu theme. 
# We pass -p "󰣆" to put the Arch icon inside the prompt box!
chosen=$(echo -e "$options" | rofi -dmenu -i -p "󰣆" -theme ~/.config/rofi/app_menu.rasi)

# Launch the corresponding script based on what you click
case "$chosen" in
    *"App Launcher") 
        rofi -show drun 
        ;;
    *"Wallpapers") 
        # Update this path to wherever your actual wallpaper script is located
        ~/.config/custom-script/wall-select.sh 
        ;;
    *"System Monitor") 
        kitty btop 
        ;;
    *"Audio Control") 
        pavucontrol
        ;;
    *"Power Menu") 
        ~/.config/custom_script/power.sh 
        ;;
esac
