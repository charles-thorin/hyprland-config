#!/usr/bin/env bash
# Super + T: open the wallpaper picker, or close it if it's already open.
if pgrep -x waypaper >/dev/null || pgrep -f 'python.*waypaper' >/dev/null; then
    pkill -x waypaper; pkill -f 'python.*waypaper'
    exit 0
fi
~/.config/hypr/scripts/wallpaper.sh daemon
setsid -f waypaper >/dev/null 2>&1
