-- ==========================================================
-- FILE: lua/workflow/rules.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines window and layer rules.
--
-- WHY IT EXISTS
-- -------------
-- Rules decide which apps tile, float, round, pin, or skip focus.
--
-- HOW IT WORKS
-- ------------
-- Hyprland 0.55 uses hl.window_rule() and hl.layer_rule().
--
-- FLOW
-- ----
-- Hyprland -> rules.lua -> app/window behavior
--
-- BEGINNER NOTES
-- --------------
-- Rule order matters. Keep specific rules near the relevant app group.

hl.window_rule({
    name = "tile-wezterm",
    match = { class = "^(org\\.wezfurlong\\.wezterm)$" },
    tile = true,
})

hl.window_rule({
    name = "round-gnome-windows",
    match = { class = "^(org\\.gnome\\.)" },
    rounding = 12,
})

hl.window_rule({
    name = "tile-gnome-control-center",
    match = { class = "^(gnome-control-center)$" },
    tile = true,
})

hl.window_rule({
    name = "tile-pavucontrol",
    match = { class = "^(pavucontrol)$" },
    tile = true,
})

hl.window_rule({
    name = "tile-network-editor",
    match = { class = "^(nm-connection-editor)$" },
    tile = true,
})

hl.window_rule({
    name = "float-gnome-calculator-appid",
    match = { class = "^(org\\.gnome\\.Calculator)$" },
    float = true,
})

hl.window_rule({
    name = "float-gnome-calculator-class",
    match = { class = "^(gnome-calculator)$" },
    float = true,
})

hl.window_rule({
    name = "float-galculator",
    match = { class = "^(galculator)$" },
    float = true,
})

hl.window_rule({
    name = "float-blueman-manager",
    match = { class = "^(blueman-manager)$" },
    float = true,
})

hl.window_rule({
    name = "float-nautilus",
    match = { class = "^(org\\.gnome\\.Nautilus)$" },
    float = true,
})

hl.window_rule({
    name = "float-xdg-desktop-portal",
    match = { class = "^(xdg-desktop-portal)$" },
    float = true,
})

hl.window_rule({
    name = "steam-notification-no-focus",
    match = {
        class = "^(steam)$",
        title = "^(notificationtoasts)",
    },
    no_focus = true,
})

hl.window_rule({
    name = "steam-notification-pin",
    match = {
        class = "^(steam)$",
        title = "^(notificationtoasts)",
    },
    pin = true,
})

hl.window_rule({
    name = "firefox-picture-in-picture-float",
    match = {
        class = "^(firefox)$",
        title = "^(Picture-in-Picture)$",
    },
    float = true,
})

hl.window_rule({
    name = "zoom-float",
    match = { class = "^(zoom)$" },
    float = true,
})

hl.layer_rule({
    name = "no-animation-quickshell",
    match = { namespace = "^(quickshell)$" },
    no_anim = true,
})

hl.layer_rule({
    name = "no-animation-dms",
    match = { namespace = "^dms:.*" },
    no_anim = true,
})
