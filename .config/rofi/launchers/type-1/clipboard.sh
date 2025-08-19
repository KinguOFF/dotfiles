#!/usr/bin/env bash
# cliphist-rofi — pick from cliphist via rofi and copy to clipboard


dir="$HOME/.config/rofi/launchers/type-1"
theme='style-1'   # e.g. adi1090x packs

cliphist list \
  | rofi -dmenu -display-columns 2 -p 'Clipboard' -theme "$dir/${theme}.rasi" \
  | cliphist decode \
  | wl-copy


