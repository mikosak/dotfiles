#!/usr/bin/bash

DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_RUNTIME_DIR="/run/user/1000"
HOSTNAME=$(uname -n)

echo "Setup enviroment"

# Process each battery line separately and skip Unknown batteries
acpi -b | while IFS= read -r line; do
    # Skip if the battery status is Unknown
    if [[ $line == *"Unknown"* ]]; then
        echo "Skipping unknown battery: $line"
        continue
    fi

    # Process valid battery data
    echo "Processing battery: $line"
    echo "$line" | awk -F'[,%]' '{print $2, $4, $5}' | {
        read -r capacity timeleft status
        echo "Obtained battery values $capacity, $status and $timeleft"
        [ "$capacity" -lt 20 ] && [ "$status" = "remaining" ] && {
            dunstify -r 9993 -t 10000 -u critical "Battery low" "$capacity% of battery left.\nTime left: $timeleft."
        }
    }
done
