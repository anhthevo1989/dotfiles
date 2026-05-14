-- ==========================================================
-- FILE: lua/ui/animations.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines Hyprland animations.
--
-- WHY IT EXISTS
-- -------------
-- Keeps motion settings separate from theme and layout settings.
--
-- HOW IT WORKS
-- ------------
-- Hyprland Lua uses hl.animation() calls instead of the old Hyprlang animation
-- lines.
--
-- FLOW
-- ----
-- Hyprland -> animations.lua -> windows/workspaces/fade/border animations
--
-- BEGINNER NOTES
-- --------------
-- The old config used the default curve. These Lua calls preserve that intent.

hl.config({
    animations = {
        enabled = true,
    },
})

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })
