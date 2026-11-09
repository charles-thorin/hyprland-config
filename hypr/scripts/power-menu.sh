#!/usr/bin/env bash
# Power menu (the Knight on the bar, or Super + Escape).
# Uses wlogout if it's installed, otherwise a simple list in fuzzel.
if command -v wlogout >/dev/null; then
    pgrep -x wlogout >/dev/null && { pkill -x wlogout; exit 0; }
    exec wlogout -b 5
fi

choice=$(printf '%s\n' "Rest (lock)" "Leave (log out)" "Sleep" "Reboot" "Shut down" \
    | fuzzel --dmenu --prompt "Power  " --lines 5 --width 24)

case "$choice" in
    "Rest (lock)")     loginctl lock-session ;;
    "Leave (log out)") hyprctl dispatch 'hl.dsp.exit()' ;;
    "Sleep")           systemctl suspend ;;
    "Reboot")          systemctl reboot ;;
    "Shut down")       systemctl poweroff ;;
esac
