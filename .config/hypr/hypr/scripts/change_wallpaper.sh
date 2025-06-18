#!/bin/bash

wallpaper_path="$HOME/Pictures/Wallpapers/"
wallpaper=$(find "$wallpaper_path" -type f | shuf -n 1)

if [[ -z "$wallpaper" ]]; then
  echo "No wallpapers found in $wallpaper_path"
  exit 1
fi

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper ",$wallpaper"
