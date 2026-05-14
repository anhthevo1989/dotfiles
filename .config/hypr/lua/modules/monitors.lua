-- ==========================================================
-- FILE: lua/core/monitors.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines monitor layout.
--
-- WHY IT EXISTS
-- -------------
-- The current setup uses a safe automatic monitor rule.
--
-- HOW IT WORKS
-- ------------
-- An empty output name means Hyprland applies the rule to any monitor.
--
-- FLOW
-- ----
-- Hyprland -> monitor rule -> preferred mode, automatic position, automatic scale
--
-- BEGINNER NOTES
-- --------------
-- Replace output = "" with a real monitor name from:
--
--   hyprctl monitors
--
-- if you want explicit monitor placement.

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})
