#!/usr/bin/env bash
# Screenshot → clipboard (Fn + Ins on most laptops, i.e. the Print key).
#   screenshot.sh region   select an area with the mouse (Esc cancels)
#   screenshot.sh screen   the whole screen
case "${1:-region}" in
    region) area=$(slurp) || exit 0          # Esc: cancelled, nothing copied
            grim -g "$area" - | wl-copy --type image/png ;;
    screen) grim - | wl-copy --type image/png ;;
esac && notify-send -t 2000 "Screenshot" "Copied to clipboard"
