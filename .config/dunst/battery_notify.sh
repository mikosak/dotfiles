#!/usr/bin/bash

DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_RUNTIME_DIR="/run/user/1000"
HOSTNAME=$(uname -n)

echo "Setup enviroment"

acpi -b | awk -F'[,%]' '{print $2, $4, $5}' | {
    read -r capacity timeleft status
    echo "Obtained battery values $capacity, $status and $timeleft"

    [ "$capacity" -lt 20 ] && [ "$status" = "remaining" ] && {
        dunstify -r 9993 -t 10000 -u critical "Battery low" "$capacity% of battery left.\nTime left: $timeleft."
    }
}
