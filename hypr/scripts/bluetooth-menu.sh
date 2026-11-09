#!/usr/bin/env bash
# Bluetooth menu (click the Bluetooth icon on the bar).
# Lists paired devices: pick one to connect it, or to disconnect it if it's
# connected. Also: turn Bluetooth on/off, and open the settings to pair a new one.

# Clicking the icon again closes the menu
pkill -f 'fuzzel.*Bluetooth' && exit 0

SETTINGS="Open Bluetooth settings…"

# Blueman if installed (GNOME Settings shows nothing outside GNOME),
# otherwise bluetoothctl in a terminal.
open_settings() {
    if command -v blueman-manager >/dev/null; then
        setsid -f blueman-manager >/dev/null 2>&1
    else
        setsid -f kitty --title "Bluetooth" bluetoothctl >/dev/null 2>&1
    fi
}

[[ "$1" == "--settings" ]] && { open_settings; exit 0; }

if ! bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    choice=$(printf '%s\n' "Turn Bluetooth on" "$SETTINGS" \
        | fuzzel --dmenu --prompt "Bluetooth  " --lines 2 --width 32)
    case "$choice" in
        "Turn Bluetooth on") bluetoothctl power on >/dev/null && notify-send -t 2000 "Bluetooth" "On" ;;
        "$SETTINGS")         open_settings ;;
    esac
    exit 0
fi

# Paired devices (newer bluez: "devices Paired", older: "paired-devices")
paired=$(bluetoothctl devices Paired 2>/dev/null | grep '^Device')
[[ -z "$paired" ]] && paired=$(bluetoothctl paired-devices 2>/dev/null | grep '^Device')

declare -A mac_of connected_of
connected_lines=() other_lines=()
while read -r _ mac name; do
    [[ -z "$mac" ]] && continue
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        line="●  $name  — connected"; connected_lines+=("$line"); connected_of[$line]=1
    else
        line="○  $name"; other_lines+=("$line")
    fi
    mac_of[$line]=$mac
done <<< "$paired"

entries=("${connected_lines[@]}" "${other_lines[@]}" "$SETTINGS" "Turn Bluetooth off")
choice=$(printf '%s\n' "${entries[@]}" \
    | fuzzel --dmenu --prompt "Bluetooth  " --lines "${#entries[@]}" --width 40)
[[ -z "$choice" ]] && exit 0

case "$choice" in
    "$SETTINGS")          open_settings; exit 0 ;;
    "Turn Bluetooth off") bluetoothctl power off >/dev/null && notify-send -t 2000 "Bluetooth" "Off"; exit 0 ;;
esac

mac=${mac_of[$choice]}
name=${choice#*  }                 # drop the ● / ○ marker
name=${name%  — connected}
[[ -z "$mac" ]] && exit 0

if [[ -n "${connected_of[$choice]}" ]]; then
    timeout 10 bluetoothctl disconnect "$mac" >/dev/null && notify-send -t 2500 "Bluetooth" "Disconnected from $name"
else
    notify-send -t 2000 "Bluetooth" "Connecting to $name…"
    if timeout 15 bluetoothctl connect "$mac" | grep -q "successful"; then
        notify-send -t 2500 "Bluetooth" "Connected to $name"
    else
        notify-send -t 4000 "Bluetooth" "Couldn't connect to $name — is it on and nearby?"
    fi
fi
