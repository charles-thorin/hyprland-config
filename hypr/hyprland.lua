--  ╭──────────────────────────────────────────────╮
--  │  HALLOWNEST · a calm Hyprland setup (0.57+)  │
--  │  Each part lives in conf/ — edit what you    │
--  │  need, nothing else has to change.           │
--  ╰──────────────────────────────────────────────╯

local programs = require("conf.programs")   -- which apps you use (edit first!)

require("conf.monitors")                     -- screens
require("conf.env")                          -- environment variables
require("conf.input")                        -- keyboard (AZERTY), mouse, touchpad
require("conf.looks")                        -- colors, gaps, blur, animations
require("conf.keybinds")(programs)           -- shortcuts (Super + H lists them all)
require("conf.rules")                        -- per-window rules
require("conf.autostart")(programs)          -- what starts at login
