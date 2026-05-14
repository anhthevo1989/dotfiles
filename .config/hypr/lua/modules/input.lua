-- ==========================================================
-- FILE: lua/core/input.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines keyboard/input behavior.
--
-- WHY IT EXISTS
-- -------------
-- Keeps input settings separate from visuals, rules, and keybinds.
--
-- HOW IT WORKS
-- ------------
-- hl.config() writes Hyprland configuration options.
--
-- FLOW
-- ----
-- Hyprland -> input.lua -> keyboard layout and NumLock behavior
--
-- BEGINNER NOTES
-- --------------
-- Add touchpad/mouse settings here later if needed.

hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
    },
})
