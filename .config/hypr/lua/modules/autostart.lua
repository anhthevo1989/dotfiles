-- ==========================================================
-- FILE: lua/core/autostart.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Starts Hyprland session services.
--
-- WHY IT EXISTS
-- -------------
-- The old Hyprlang config used exec-once for DBus/systemd integration. Lua uses
-- the hyprland.start event for startup commands.
--
-- HOW IT WORKS
-- ------------
-- hl.on("hyprland.start", function() ... end) runs once when Hyprland starts.
--
-- FLOW
-- ----
-- Hyprland starts
-- -> DBus environment is updated
-- -> hyprland-session.target starts
--
-- BEGINNER NOTES
-- --------------
-- hl.exec_cmd() is asynchronous. You do not need to append "&".

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)
