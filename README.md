# Hallownest — a calm Hyprland setup

A Hyprland **0.57+** setup (Lua config) built for focus, themed after Hollow Knight: pale spectral
white on near-black, masks for workspaces, and infection orange only when
something needs you.

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│                              your windows                                │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│ ♞   ◆ ◆ ◇ ◆            Sunday 08 November · 14:32         🌐 🐱 🎨  ᛒ  │
└──────────────────────────────────────────────────────────────────────────┘
  ↑   ↑                          ↑                                  ↑
power  workspaces as masks       date (hover: calendar)       open apps
menu   (grows with workspaces)                         (click: focus, middle: close)
                                                                    ᛒ = Bluetooth (click: devices)
```

## What's inside

| Folder     | What it is                                                    |
|------------|---------------------------------------------------------------|
| `hypr/`    | Hyprland: `hyprland.lua`, split into small commented files in `conf/`, plus lock screen (hyprlock) and idle (hypridle) |
| `waybar/`  | The bar: power menu, workspaces, date, open apps              |
| `wlogout/` | Power menu                                                    |
| `mako/`    | Notifications                                                 |
| `fuzzel/`  | App launcher and the keybind list                             |
| `waypaper/`| Wallpaper picker settings (copied once by `install.sh`)       |
| `kitty/`   | Terminal colors                                               |

## Install

**1. Packages** (names from Arch; other distros use similar ones)

```bash
sudo pacman -S hyprland hyprlock hypridle waybar mako fuzzel kitty bluez bluez-utils blueman grim slurp wl-clipboard brightnessctl playerctl jq libnotify ttf-nerd-fonts-symbols
```

```bash
yay -S awww krita waypaper wlogout
```

If you use swww instead of awww, the wallpaper script handles that too.

Zen is set up as the Flatpak version, installed from GNOME Software or with
`flatpak install flathub app.zen_browser.zen`. If you install it some other
way, change `browser` in `hypr/conf/programs.lua`.

`hyprlock` and `hypridle` are required: in Hyprland, locking (the power menu's
"Rest", `Super + Alt + L`, and the 10-minute idle lock) goes through them. If
you also use GNOME, its own lock screen only works inside the GNOME session,
and nothing here changes it.

**2. Fonts.** Install them however you like:
- **Cinzel**: titles, clock, power menu (close to the game's Trajan lettering)
- **EB Garamond**: notifications, launcher, tooltips
- **Symbols Nerd Font**: small status icons

**3. Icons.** Put your art in `waybar/icons/` and `wlogout/icons/`. Each
folder has a README that lists the file names the theme expects.

**4. Link it**

```bash
./install.sh
```

It backs up anything already in `~/.config` before linking. It adds the kitty
theme to your existing `kitty.conf` without replacing it.

**5. Wallpapers.** Put them in `~/Pictures/Wallpapers` (subfolders work too).
`Super + T` opens a picker with thumbnails: click one to set it, and press
`Super + T` again to close the picker. `Super + W` picks one at random. The
wallpaper you chose comes back at the next login.

## Keybinds

Press **`Super + H`** (help) to see them all and search them.
The keyboard is set to **AZERTY** (`fr`).

| Keys                     | Action                                   |
|--------------------------|------------------------------------------|
| `Super + Q` / `Return`   | Terminal                                 |
| `Super + F`              | Zen (browser)                            |
| `Super + P`              | Krita                                    |
| `Super + E`              | Files                                    |
| `Super + Space`          | Launcher                                 |
| `Super + Z`              | **Focus mode** (press again to exit)     |
| `Super + H`              | Show all keybinds                        |
| `Super + C`              | Close window                             |
| `Super + Page Up`        | Maximize / restore window                |
| `Super + Shift + Page Up`| Fullscreen / restore                     |
| `Super + V`              | Float / tile                             |
| `Super + arrows`         | Move focus                               |
| `Super + Shift + arrows` | Move window                              |
| `Super + Ctrl + arrows`  | Resize                                   |
| `Super + & é " ' ( - è _ ç à` | Go to workspace 1–10 (number row)  |
| `Super + Shift + number row` | Send window to workspace 1–10        |
| `Super + Tab`            | Previous workspace                       |
| `Super + S`              | Scratchpad (`Shift` sends a window there)|
| `Super + T`              | Wallpaper picker (press again to close)  |
| `Super + W`              | Random wallpaper                         |
| `Super + Escape`         | Power menu                               |
| `Super + Alt + L`        | Lock                                     |
| `Print` / `Shift+Print`  | Screenshot region / screen → clipboard   |

## Bluetooth

Click the Bluetooth icon at the right end of the bar. A list shows your
paired devices, with connected ones first (●). Pick one to connect it, or to
disconnect it if it's connected. The list also has **Open Bluetooth
settings…**, for pairing a new device, and an entry to turn Bluetooth on or
off. Right-clicking the icon opens the settings directly. The settings window
is Blueman (GNOME Settings shows nothing outside GNOME). If Blueman isn't
installed, a terminal with `bluetoothctl` opens instead.

Bluetooth needs its service running: `sudo systemctl enable --now bluetooth`.

## Focus mode

`Super + Z` hides the bar, silences notifications, removes gaps, and dims
every window except the one you're working in. Press it again to bring
everything back.

The rest of the setup is quiet too. Inactive windows are slightly dimmed, apps
can't steal focus, and the screen dims after 5 minutes, locks after 10 and
turns off after 15.

## Customizing

- **Different apps:** edit `hypr/conf/programs.lua`.
- **Bar:** `waybar/config.jsonc` (modules) and `waybar/style.css` (looks).
  Changes to `style.css` apply as soon as you save.
- **Keyboard:** `kb_layout` / `kb_variant` in `hypr/conf/input.lua`.
- **Colors:** the palette is listed at the top of `hypr/conf/looks.lua` and
  `waybar/style.css`.
- **Window rules / blur behind the bar:** `hypr/conf/rules.lua`.

## Hyprland 0.57 notes

- Hyprland 0.57 reads only `hyprland.lua`; the old `hyprland.conf` format is gone.
- `hyprctl keyword` no longer exists. Use `hyprctl eval 'hl.config({ ... })'` to
  change settings live. `hyprctl dispatch` now takes Lua, for example
  `hyprctl dispatch 'hl.dsp.exit()'`.
- If something doesn't load, run `hyprctl configerrors` to see what Hyprland
  rejected.
