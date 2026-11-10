#!/usr/bin/env bash
# Screenshot → clipboard (nothing is saved to disk).
#   screenshot.sh region   select an area with the mouse (Esc cancels)
#   screenshot.sh screen   the whole screen
# If something fails, a notification says what (details in the log below).
set -o pipefail
LOG="${XDG_RUNTIME_DIR:-/tmp}/screenshot.log"

fail() { notify-send -u critical "Screenshot failed" "$1"; echo "$(date) $1" >> "$LOG"; exit 1; }

for tool in grim slurp wl-copy; do
    command -v "$tool" >/dev/null || fail "'$tool' is not installed (packages: grim slurp wl-clipboard)"
done

case "${1:-region}" in
    region)
        area=$(slurp 2>>"$LOG") || exit 0      # Esc: cancelled, nothing copied
        grim -g "$area" - 2>>"$LOG" | wl-copy --type image/png 2>>"$LOG" \
            || fail "Couldn't capture or copy the area (see $LOG)" ;;
    screen)
        grim - 2>>"$LOG" | wl-copy --type image/png 2>>"$LOG" \
            || fail "Couldn't capture or copy the screen (see $LOG)" ;;
esac

notify-send -t 2000 "Screenshot" "Copied to clipboard"
