-- ==========================================================
-- FILE: lua/workflow/layouts.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines layout-specific behavior.
--
-- WHY IT EXISTS
-- -------------
-- Layout options belong with workflow behavior, not visual styling.
--
-- HOW IT WORKS
-- ------------
-- Hyprland layout options are set through hl.config().
--
-- FLOW
-- ----
-- Hyprland -> layouts.lua -> dwindle/master behavior
--
-- BEGINNER NOTES
-- --------------
-- Dwindle is your active layout. Master settings are kept because they existed
-- in the previous config and may matter if you switch layouts later.

hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        mfact = 0.5,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})
