#!/usr/bin/env bash

# Get the name of the active player (e.g., spotify, chromium, firefox)
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [ -n "$PLAYER" ]; then
    # Clean up browser instance names (e.g., "chromium.instance123" becomes "chromium")
    APP_NAME=$(echo "$PLAYER" | cut -d'.' -f1)

    # Use wmctrl to find the window class, switch to its workspace, and focus it
    wmctrl -x -a "$APP_NAME"
fi
