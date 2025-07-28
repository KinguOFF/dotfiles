#!/usr/bin/env bash

# Variables
time=$(date "+%H:%M:%S")
date=$(date "+%d/%m/%Y")
battery=$(acpi -b | awk -F', ' '{print $2 " (" $1 ")"}')

# Combine into one message string
status="Time: $time | Date: $date | Battery: $battery"

# Show in rofi (just a dummy menu with small message font)
echo " " | rofi -dmenu \
  -p "" \
  -mesg "$status" \
  -theme ~/dotfiles/.config/rofi/scripts/theme.rasi
