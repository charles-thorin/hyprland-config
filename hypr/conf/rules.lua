-- ── Window & layer rules ────────────────────────
hl.window_rule({
    name  = "float-volume-mixer",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
})

hl.window_rule({
    name  = "pip-float-pin",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
})

-- Wallpaper picker (Super + T): a floating window in the middle of the screen
hl.window_rule({
    name   = "wallpaper-picker",
    match  = { class = "^(waypaper)$" },
    float  = true,
    size   = "1100 700",
    center = true,
})

-- Blur behind the bar, notifications, launcher and power menu
hl.layer_rule({
    name  = "blur-ui",
    match = { namespace = "^(waybar|notifications|launcher|logout_dialog)$" },
    blur  = true,
})
