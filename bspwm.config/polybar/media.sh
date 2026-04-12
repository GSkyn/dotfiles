#!/usr/bin/env bash

# Get the current status (Playing, Paused, or Stopped)
status=$(playerctl status 2>/dev/null)

# Polybar color tags for the icon (Rosé Pine Moon 'rose' color)
color="%{F#ea9a97}"
reset="%{F-}"

# Set the icon based on the status
if [ "$status" = "Playing" ]; then
    # FontAwesome Pause Icon
    icon="${color}${reset}"
elif [ "$status" = "Paused" ]; then
    # FontAwesome Play Icon
    icon="${color}${reset}"
else
    # If nothing is playing, output nothing and exit
    echo ""
    exit 0
fi

# Get the artist and title
metadata=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)

# Output the icon and the text
echo "$icon $metadata"
