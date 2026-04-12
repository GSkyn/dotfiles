#!/usr/bin/env bash

# This function maps window names to specific font icons
get_icon() {
    # Convert the window class name to lowercase for easier matching
    local class=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    
    case "$class" in
        *"chromium"|*"chrome"|*"brave"*) echo "" ;;
        *"firefox"|*"librewolf"*) echo "" ;;
        *"kitty"|*"alacritty"|*"st"|*"terminal"*) echo "" ;;
        *"nemo"|*"thunar"|*"dolphin"*) echo "" ;;
        *"code"|*"vscode"*) echo "󰨞" ;;
        *"spotify"*) echo "" ;;
        *"discord"*) echo "" ;;
        *"gimp"*) echo "" ;;
        *"minecraft"*|*"lunarclient"*) echo "󰍳" ;;
        *"steam"*) echo "" ;;
        *"obs"*) echo "󰐌" ;;
        *"vlc"|*"mpv"|*"mplayer"*) echo "󰕼" ;;
        # Default icon for any app not listed above
        *) echo "" ;; 
    esac
}

get_windows() {
    # Get all window nodes in the current focused desktop
    windows=$(bspc query -N -n .local.window 2>/dev/null)
    output=""
    
    if [ -z "$windows" ]; then
        echo ""
        return
    fi
    
    for win in $windows; do
        # Extract the application name
        class=$(xprop -id "$win" WM_CLASS 2>/dev/null | awk -F '"' '{print $4}')
        
        if [ -z "$class" ]; then
            class="App"
        fi
        
        # Get the matching icon for the app
        icon=$(get_icon "$class")
        
        # Check if this window is currently focused
        focused=$(bspc query -N -n focused.local 2>/dev/null)
        
        if [ "$win" = "$focused" ]; then
            # Active Window: Highlighted (Pink)
            output="$output%{A1:bspc node $win -f:}%{F#eb6f92}$icon%{F-}%{A}  "
        else
            # Inactive Window: Subdued (Purple)
            output="$output%{A1:bspc node $win -f:}%{F#908caa}$icon%{F-}%{A}  "
        fi
    done
    
    echo "$output"
}

# Print initially on startup
get_windows

# Listen to bspwm events to update the bar instantly
bspc subscribe desktop_focus node_focus node_add node_remove node_transfer | while read -r event; do
    get_windows
done
