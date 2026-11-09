-- ── Your programs ───────────────────────────────
-- Change these and every keybind follows.
return {
    terminal = "kitty",
    browser  = "flatpak run app.zen_browser.zen",   -- Zen from GNOME Software (Flatpak)
    paint    = "krita",
    launcher = "fuzzel",
    files    = "kitty -e yazi",      -- or "thunar", "nautilus", "dolphin"…
    scripts  = "~/.config/hypr/scripts",
}
