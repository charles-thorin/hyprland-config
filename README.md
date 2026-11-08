# Hallownest — a calm Hyprland setup

A Hyprland setup built for focus, themed after Hollow Knight: pale spectral
white on near-black, masks for workspaces, and infection orange only when
something needs you.

```
┌─────────────┐
│ ◆ ◆ ◇ ◆     │  ← workspaces as masks (the tab grows/shrinks with them)
└─────────────┘



                                                             ╭──╮
                                                             │✦ │ ← fleur: click to unfold
                                                             │◎ │   clock · calendar · player ·
                                                             │🐱│   volume · network · battery
                                                             │✎ │
                                                             │♞ │ ← power menu
                                                             ╰──┘
```

## What's inside

| Folder     | What it is                                                    |
|------------|---------------------------------------------------------------|
| `hypr/`    | Hyprland, split into small commented files in `conf/`, plus lock screen (hyprlock) and idle (hypridle) |
| `waybar/`  | The workspace tab and the dock                                |
| `wlogout/` | Power menu                                                    |
| `mako/`    | Notifications                                                 |
| `fuzzel/`  | App launcher and the keybind list                             |
| `kitty/`   | Terminal colors                                               |

## Install

**1. Packages** (names from Arch; other distros use similar ones)

```bash
sudo pacman -S hyprland hyprlock hypridle waybar mako fuzzel kitty wlogout grim slurp wl-clipboard brightnessctl playerctl jq libnotify ttf-nerd-fonts-symbols
```

```bash
yay -S zen-browser-bin awww krita
```

If you use swww instead of awww, the wallpaper script handles that too.

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

**5. Wallpapers.** Put them in `~/Pictures/wallpapers/hollow-knight`. A random
one is picked at login, and `Super + W` switches to another.

## Keybinds

Press **`Super + /`** to see them all and search them.

| Keys                     | Action                                   |
|--------------------------|------------------------------------------|
| `Super + Return`         | Terminal                                 |
| `Super + B`              | Browser                                  |
| `Super + P`              | Krita                                    |
| `Super + E`              | Files                                    |
| `Super + Space`          | Launcher                                 |
| `Super + Z`              | **Focus mode** (press again to exit)     |
| `Super + Q`              | Close window                             |
| `Super + F` / `Shift+F`  | Fullscreen / maximize                    |
| `Super + V`              | Float / tile                             |
| `Super + arrows`         | Move focus                               |
| `Super + Shift + arrows` | Move window                              |
| `Super + Ctrl + arrows`  | Resize                                   |
| `Super + 1–9`            | Go to workspace (QWERTY and AZERTY)      |
| `Super + Shift + 1–9`    | Send window to workspace                 |
| `Super + Tab`            | Previous workspace                       |
| `Super + S`              | Scratchpad (`Shift` sends a window there)|
| `Super + W`              | Next wallpaper                           |
| `Super + Escape`         | Power menu                               |
| `Super + Alt + L`        | Lock                                     |
| `Print` / `Shift+Print`  | Screenshot region / screen → clipboard   |

## Focus mode

`Super + Z` hides the bar, silences notifications, removes gaps, and dims
every window except the one you're working in. Press it again to bring
everything back.

The rest of the setup is quiet too. Inactive windows are slightly dimmed, apps
can't steal focus, and the screen dims after 5 minutes, locks after 10 and
turns off after 15.

## Customizing

- **Different apps:** edit `hypr/conf/programs.conf`. The dock commands are
  at the bottom of `waybar/config.jsonc`.
- **Keyboard layout:** set `kb_layout` in `hypr/conf/input.conf` (`fr` for AZERTY).
- **Colors:** the palette is listed at the top of `hypr/conf/looks.conf` and
  `waybar/style.css`.
- **Window rules / blur behind the bar:** see `hypr/conf/rules.conf`. Uncomment
  the block for your Hyprland version (`hyprctl version`).
