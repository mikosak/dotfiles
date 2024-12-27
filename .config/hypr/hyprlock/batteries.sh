#!/usr/bin/env bash

upower -e > /tmp/batteries
while read p
	do upower -i "$p" > /tmp/battery_details && grep 'model' /tmp/battery_details >/dev/null && grep -E 'model|percentage' /tmp/battery_details
	rm /tmp/battery_details
done </tmp/batteries
rm /tmp/batteries
