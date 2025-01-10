#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  # wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2 * 100)}'
  # wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}'
  wpctl get-volume @DEFAULT_SINK@
}

function is_mute {
  wpctl get-volume @DEFAULT_SINK@ | grep -o '\[MUTED\]' >/dev/null
}

function send_notification {
  # volume=$(get_volume)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  # bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
  # Send the notification
  # dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "    $bar"
  dunstify -t 1000 -r 1579 -u normal "$(get_volume)"
}

case $1 in
up)
  # Set the volume on (if it was muted)
  # wpctl set-mute @DEFAULT_SINK@ 0 >/dev/null
  # Up the volume (+ 5%)
  wpctl set-volume @DEFAULT_SINK@ 5%+
  send_notification
  ;;
down)
  # wpctl set-mute @DEFAULT_SINK@ 0 >/dev/null
  wpctl set-volume @DEFAULT_SINK@ 5%-
  send_notification
  ;;
mute)
  # Toggle mute
  wpctl set-mute @DEFAULT_SINK@ toggle >/dev/null
  if is_mute; then
    # dunstify -i audio-volume-muted -t 1000 -r 2593 -u normal "Mute"
    dunstify -t 1000 -r 1579 -u normal "Mute"
  else
    send_notification
  fi
  ;;
esac
