#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Launch Calculator"
    
else
    kill `pidof rofi` 
    # so rofi doesn't complain "can't launch rofi inside rofi"
    rofi -show calc -no-bold -automatic-save-to-history -no-show-match -no-sort -kb-accept-entry '' -kb-accept-custom 'Return' -calc-command "echo -n '{result}' | wl-copy && pkill -x rofi"
fi
