-- ── Keybinds ────────────────────────────────────
-- Every bind has a description, so  Super + H  (help) can list them all.
local mod = "SUPER"

-- bind("SUPER + Q", "What it does", dispatcher, { repeating = true, ... })
local function bind(keys, description, dispatcher, opts)
    opts = opts or {}
    opts.description = description
    hl.bind(keys, dispatcher, opts)
end

return function(p)
    local exec = hl.dsp.exec_cmd

    -- Apps (same order as the dock)
    bind(mod .. " + Return", "Open terminal",      exec(p.terminal))
    bind(mod .. " + B",      "Open browser",       exec(p.browser))
    bind(mod .. " + P",      "Open Krita (paint)", exec(p.paint))
    bind(mod .. " + E",      "Open file manager",  exec(p.files))
    bind(mod .. " + Space",  "App launcher",       exec(p.launcher))

    -- Focus & help
    bind(mod .. " + Z",       "Toggle focus mode", exec(p.scripts .. "/focus-mode.sh"))
    bind(mod .. " + H",       "Show all keybinds", exec(p.scripts .. "/keybinds.sh"))
    bind(mod .. " + T",       "Pick a wallpaper",  exec(p.scripts .. "/wallpaper-picker.sh"))
    bind(mod .. " + W",       "Random wallpaper",  exec(p.scripts .. "/wallpaper.sh random"))
    bind(mod .. " + Escape",  "Power menu",        exec("wlogout -b 5"))
    bind(mod .. " + ALT + L", "Lock screen",       exec("loginctl lock-session"))

    -- Windows
    bind(mod .. " + Q",         "Close window",         hl.dsp.window.close())
    bind(mod .. " + F",         "Fullscreen",           hl.dsp.window.fullscreen({ mode = "fullscreen" }))
    bind(mod .. " + SHIFT + F", "Maximize (keep bar)",  hl.dsp.window.fullscreen({ mode = "maximized" }))
    bind(mod .. " + V",         "Float / tile window",  hl.dsp.window.float({ action = "toggle" }))
    bind(mod .. " + J",         "Swap split direction", hl.dsp.layout("togglesplit"))

    -- Arrows: focus · Shift: move · Ctrl: resize
    local steps = { left = { -40, 0 }, right = { 40, 0 }, up = { 0, -40 }, down = { 0, 40 } }
    for dir, step in pairs(steps) do
        bind(mod .. " + " .. dir,         "Focus " .. dir,       hl.dsp.focus({ direction = dir }))
        bind(mod .. " + SHIFT + " .. dir, "Move window " .. dir, hl.dsp.window.move({ direction = dir }))
        bind(mod .. " + CTRL + " .. dir,  "Resize " .. dir,
             hl.dsp.window.resize({ x = step[1], y = step[2], relative = true }),
             { repeating = true })
    end

    -- Workspaces 1–10 on the AZERTY number row:  & é " ' ( - è _ ç à
    local row = { "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft",
                  "minus", "egrave", "underscore", "ccedilla", "agrave" }
    for i, key in ipairs(row) do
        bind(mod .. " + " .. key,         "Workspace " .. i,      hl.dsp.focus({ workspace = i }))
        bind(mod .. " + SHIFT + " .. key, "Send window to " .. i, hl.dsp.window.move({ workspace = i }))
    end
    bind(mod .. " + Tab",        "Previous workspace", hl.dsp.focus({ workspace = "previous" }))
    bind(mod .. " + mouse_down", "Next workspace",     hl.dsp.focus({ workspace = "e+1" }))
    bind(mod .. " + mouse_up",   "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))

    -- Scratchpad: a hidden workspace you can summon over anything
    bind(mod .. " + S",         "Show / hide scratchpad",    hl.dsp.workspace.toggle_special("scratch"))
    bind(mod .. " + SHIFT + S", "Send window to scratchpad", hl.dsp.window.move({ workspace = "special:scratch" }))

    -- Mouse: Super + drag to move, Super + right-drag to resize
    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Screenshots → clipboard
    bind("Print",         "Screenshot a region",   exec([[grim -g "$(slurp)" - | wl-copy]]))
    bind("SHIFT + Print", "Screenshot the screen", exec("grim - | wl-copy"))

    -- Media & hardware keys (work on the lock screen too)
    bind("XF86AudioRaiseVolume",  "Volume up",       exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    bind("XF86AudioLowerVolume",  "Volume down",     exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
    bind("XF86AudioMute",         "Mute",            exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
    bind("XF86AudioPlay",         "Play / pause",    exec("playerctl play-pause"),                           { locked = true })
    bind("XF86AudioNext",         "Next track",      exec("playerctl next"),                                 { locked = true })
    bind("XF86AudioPrev",         "Previous track",  exec("playerctl previous"),                             { locked = true })
    bind("XF86MonBrightnessUp",   "Brightness up",   exec("brightnessctl s 5%+"),                            { locked = true, repeating = true })
    bind("XF86MonBrightnessDown", "Brightness down", exec("brightnessctl s 5%-"),                            { locked = true, repeating = true })
end
