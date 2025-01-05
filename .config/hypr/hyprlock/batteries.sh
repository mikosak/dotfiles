#!/usr/bin/env bash

upower -e | while read -r p; do
    upower -i "$p" | grep -q 'model' && upower -i "$p" | grep -E 'model|percentage'
done
