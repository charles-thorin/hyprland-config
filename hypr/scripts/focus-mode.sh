#!/usr/bin/env bash
# Focus mode: hide the bar, silence notifications, remove gaps,
# dim everything except the window you're working in.
# Run again to come back.
STATE="${XDG_RUNTIME_DIR:-/tmp}/hypr-focus-mode"

if [[ -f "$STATE" ]]; then
    rm -f "$STATE"
    hyprctl reload >/dev/null                 # restores gaps/dim from looks.conf
    makoctl mode -r do-not-disturb >/dev/null
    pgrep -x waybar >/dev/null || setsid -f waybar >/dev/null 2>&1
    notify-send -t 2500 "Awake" "Hallownest stirs once more."
else
    touch "$STATE"
    notify-send -t 1500 "Focus" "Silence falls over Hallownest."
    sleep 1.5
    makoctl mode -a do-not-disturb >/dev/null
    pkill -x waybar
    hyprctl --batch "\
        keyword general:gaps_in 0 ; \
        keyword general:gaps_out 0 ; \
        keyword decoration:rounding 0 ; \
        keyword decoration:dim_strength 0.35" >/dev/null
fi
