#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit
killall -q polybar

# Launch the bar (replace 'mybar' with your bar name from the config)
polybar 

echo "Polybar launched..."

