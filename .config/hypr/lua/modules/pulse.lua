-- ==========================================================
-- FILE: lua/ui/pulse.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides Pulse fallback colors for Hyprland.
--
-- WHY IT EXISTS
-- -------------
-- DMS can generate colors, but this config should still look coherent if DMS
-- is removed or stops generating color files.
--
-- HOW IT WORKS
-- ------------
-- Hyprland Lua accepts border colors through the general.col table.
--
-- FLOW
-- ----
-- Hyprland -> pulse.lua -> fallback Pulse border styling
--
-- BEGINNER NOTES
-- --------------
-- active_border can be a gradient table with colors and angle.

hl.config({
    general = {
        col = {
            active_border = {
                colors = {
                    "rgba(7AA2F7ff)",
                    "rgba(BD93F9ff)",
                },
                angle = 45,
            },
            inactive_border = "rgba(6B7394aa)",
        },
    },
    group = {
        col = {
            border_active = "rgb(7aa2f7)",
            border_inactive = "rgb(6b7394)",
            border_locked_active = "rgb(ff5555)",
            border_locked_inactive = "rgb(6b7394)",
        },
        groupbar = {
            col = {
                active = "rgb(7aa2f7)",
                inactive = "rgb(6b7394)",
                locked_active = "rgb(ff5555)",
                locked_inactive = "rgb(6b7394)",
            },
        },
    },
})
