#!/bin/bash

entries="\uf023   Logout\n\uf186   Suspend\n\uf021   Reboot\n\uf011   Shutdown"

selected=$(echo -e $entries | wofi -n --width 200 --height 168 --dmenu -p "Power Menu" --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    exec hyprctl dispatch exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
