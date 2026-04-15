#!/bin/bash

KBD_NAME="melgeek-made68-keyboard" # Remember to put your 70% keyboard name back here
DATA=$(hyprctl devices -j)

LAYOUT=$(echo "$DATA" | jq -r ".keyboards[] | select(.name == \"$KBD_NAME\") | .active_keymap")
CAPS=$(echo "$DATA" | jq -r ".keyboards[] | select(.name == \"$KBD_NAME\") | .capsLock")

if [[ "$LAYOUT" == *"Thai"* ]] || [[ "$LAYOUT" == *"th"* ]]; then
    LANG="TH"
else
    LANG="EN"
fi

if [[ "$CAPS" == "true" ]]; then
    # Lightmode: Cream icon box, red text
    TEXT="<span color='#cc241d' bgcolor='#fbf1c7' >  </span> <span color='#cc241d'>$LANG</span>"
    CLASS="caps-on"
else
    # Darkmode: Aqua icon box, normal text
    TEXT="<span color='#202020' bgcolor='#8ec07c' >  </span> $LANG"
    CLASS="caps-off"
fi

echo "{\"text\": \"$TEXT\", \"class\": \"$CLASS\"}"
