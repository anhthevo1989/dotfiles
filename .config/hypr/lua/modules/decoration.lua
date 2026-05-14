-- ==========================================================
-- FILE: lua/ui/decoration.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines gaps, borders, opacity, rounding, and shadows.
--
-- WHY IT EXISTS
-- -------------
-- These settings were split between the base Hyprland config, colors.conf, and
-- DMS layout.conf. This file consolidates them into one Lua module.
--
-- HOW IT WORKS
-- ------------
-- hl.config() writes general and decoration options.
--
-- FLOW
-- ----
-- Hyprland -> decoration.lua -> gaps, borders, opacity, rounding, shadow
--
-- BEGINNER NOTES
-- --------------
-- DMS generated gaps_in = 4 and gaps_out = 4. Your base config used 5. This
-- config keeps the DMS-generated values because they were the final sourced
-- override in the old config.

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 2,
        layout = "dwindle",
    },

    decoration = {
        rounding = 12,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 30,
            render_power = 5,
            offset = "0 5",
            color = "rgba(0F0D18ee)",
        },
    },
})
