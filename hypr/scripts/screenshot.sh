#!/usr/bin/env bash
# Screenshot: saved to ~/Pictures/Screenshots and copied to the clipboard.
#   screenshot.sh region   select an area with the mouse (Esc cancels)
#   screenshot.sh screen   the whole screen
# If something fails, a notification says what (details in the log below).
DIR="$HOME/Pictures/Screenshots"
LOG="${XDG_RUNTIME_DIR:-/tmp}/screenshot.log"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

fail() { notify-send -u critical "Screenshot failed" "$1"; echo "$(date) $1" >> "$LOG"; exit 1; }

for tool in grim slurp wl-copy; do
    command -v "$tool" >/dev/null || fail "'$tool' is not installed (packages: grim slurp wl-clipboard)"
done
mkdir -p "$DIR" || fail "Can't create $DIR"

case "${1:-region}" in
    region)
        area=$(slurp 2>>"$LOG") || exit 0      # Esc: cancelled, nothing saved
        grim -g "$area" "$FILE" 2>>"$LOG" || fail "grim couldn't capture the area (see $LOG)" ;;
    screen)
        grim "$FILE" 2>>"$LOG" || fail "grim couldn't capture the screen (see $LOG)" ;;
esac

wl-copy --type image/png < "$FILE" 2>>"$LOG" || fail "Saved, but copying to the clipboard failed (see $LOG)"
notify-send -t 2500 -i "$FILE" "Screenshot" "Copied, and saved as $(basename "$FILE")"
