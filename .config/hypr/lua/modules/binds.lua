-- ==========================================================
-- FILE: lua/workflow/binds.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Owns every Hyprland keybind, including the old DMS-generated bind map.
--
-- WHY IT EXISTS
-- -------------
-- Keeping all binds in Hyprland Lua creates one source of truth. DMS remains
-- available as a service, but it no longer owns keybind configuration.
--
-- HOW IT WORKS
-- ------------
-- Hyprland Lua uses:
--
--   hl.bind("KEYS", dispatcher, flags)
--
-- DMS actions are still called through:
--
--   hl.dsp.exec_cmd("dms ipc call ...")
--
-- FLOW
-- ----
-- Key press
-- -> Hyprland Lua bind
-- -> Hyprland dispatcher or DMS IPC command
--
-- BEGINNER NOTES
-- --------------
-- The old DMS binds.conf should NOT be sourced when this file is active.
--
-- Old Hyprlang flag mapping:
--
--   bind   -> normal bind
--   bindl  -> { locked = true }
--   binde  -> { repeating = true }
--   bindel -> { locked = true, repeating = true }
--   bindd  -> { description = "..." }
--   bindmd -> { mouse = true, description = "..." }

local M = {}

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function bind(keys, dispatcher, flags)
    hl.bind(keys, dispatcher, flags or {})
end

local function dms(keys, command, flags)
    bind(keys, exec("dms ipc call " .. command), flags)
end

local function legacy_dispatch(keys, dispatcher, params, flags)
    -- Compatibility fallback for older/simple dispatcher names that do not yet
    -- have a clean Lua wrapper in this config.
    --
    -- If Hyprland changes this external compatibility path, replace these
    -- helpers with the native Lua dispatcher for that action.
    local command = "hyprctl dispatch " .. dispatcher
    if params and params ~= "" then
        command = command .. " " .. params
    end
    bind(keys, exec(command), flags)
end

-- ==========================================================
-- Application launchers
-- ==========================================================

bind("SUPER + T", exec("kitty"))
bind("SUPER + E", exec("dolphin"))

dms("SUPER + SPACE", "spotlight toggle")
dms("SUPER + V", "clipboard toggle")
dms("SUPER + M", "processlist focusOrToggle")
dms("SUPER + comma", "settings focusOrToggle")
dms("SUPER + N", "notifications toggle")
dms("SUPER + SHIFT + N", "notepad toggle")
dms("SUPER + Y", "dankdash wallpaper")
dms("SUPER + TAB", "hypr toggleOverview")
dms("SUPER + X", "powermenu toggle")

-- ==========================================================
-- Cheat sheet
-- ==========================================================

dms("SUPER + SHIFT + Slash", "keybinds toggle hyprland")

-- ==========================================================
-- Security
-- ==========================================================

dms("SUPER + ALT + L", "lock lock")
bind("SUPER + SHIFT + E", hl.dsp.exit())
dms("CTRL + ALT + Delete", "processlist focusOrToggle")

-- ==========================================================
-- Audio controls
-- ==========================================================

dms("XF86AudioRaiseVolume", "audio increment 3", { locked = true, repeating = true })
dms("XF86AudioLowerVolume", "audio decrement 3", { locked = true, repeating = true })
dms("XF86AudioMute", "audio mute", { locked = true })
dms("XF86AudioMicMute", "audio micmute", { locked = true })
dms("XF86AudioPause", "mpris playPause", { locked = true })
dms("XF86AudioPlay", "mpris playPause", { locked = true })
dms("XF86AudioPrev", "mpris previous", { locked = true })
dms("XF86AudioNext", "mpris next", { locked = true })
dms("CTRL + XF86AudioRaiseVolume", "mpris increment 3", { locked = true, repeating = true })
dms("CTRL + XF86AudioLowerVolume", "mpris decrement 3", { locked = true, repeating = true })

-- ==========================================================
-- Brightness controls
-- ==========================================================

dms("XF86MonBrightnessUp", 'brightness increment 5 ""', { locked = true, repeating = true })
dms("XF86MonBrightnessDown", 'brightness decrement 5 ""', { locked = true, repeating = true })

-- ==========================================================
-- Window management
-- ==========================================================

bind("SUPER + Q", hl.dsp.window.close())
bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bind("SUPER + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
bind("SUPER + W", hl.dsp.group.toggle())
dms("SUPER + SHIFT + W", "window-rules toggle")

-- ==========================================================
-- Focus navigation
-- ==========================================================

bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
bind("SUPER + down", hl.dsp.focus({ direction = "d" }))
bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
bind("SUPER + right", hl.dsp.focus({ direction = "r" }))

bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

-- ==========================================================
-- Window movement
-- ==========================================================

bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- ==========================================================
-- Column navigation
-- ==========================================================

legacy_dispatch("SUPER + Home", "focuswindow", "first")
legacy_dispatch("SUPER + End", "focuswindow", "last")

-- ==========================================================
-- Monitor navigation
-- ==========================================================

bind("SUPER + CTRL + left", hl.dsp.focus({ monitor = "l" }))
bind("SUPER + CTRL + right", hl.dsp.focus({ monitor = "r" }))
bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "l" }))
bind("SUPER + CTRL + J", hl.dsp.focus({ monitor = "d" }))
bind("SUPER + CTRL + K", hl.dsp.focus({ monitor = "u" }))
bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "r" }))

-- ==========================================================
-- Move window to monitor
-- ==========================================================

bind("SUPER + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
bind("SUPER + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }))
bind("SUPER + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }))
bind("SUPER + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))

bind("SUPER + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
bind("SUPER + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))
bind("SUPER + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
bind("SUPER + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- ==========================================================
-- Workspace navigation
-- ==========================================================

bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
bind("SUPER + U", hl.dsp.focus({ workspace = "e+1" }))
bind("SUPER + I", hl.dsp.focus({ workspace = "e-1" }))

bind("SUPER + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }))
bind("SUPER + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }))

-- ==========================================================
-- Workspace management
-- ==========================================================

dms("CTRL + SHIFT + R", "workspace-rename open")

-- ==========================================================
-- Move workspaces
-- ==========================================================

bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- ==========================================================
-- Mouse wheel navigation
-- ==========================================================

bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- ==========================================================
-- Numbered workspaces
-- ==========================================================

for workspace = 1, 9 do
    local key = tostring(workspace)

    bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
    bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

-- ==========================================================
-- Column management
-- ==========================================================

bind("SUPER + bracketleft", hl.dsp.layout("preselect l"))
bind("SUPER + bracketright", hl.dsp.layout("preselect r"))

-- ==========================================================
-- Sizing and layout
-- ==========================================================

bind("SUPER + R", hl.dsp.layout("togglesplit"))
legacy_dispatch("SUPER + CTRL + F", "resizeactive", "exact 100% 100%")

-- ==========================================================
-- Move/resize windows with mainMod + mouse dragging
-- ==========================================================

bind("SUPER + mouse:272", hl.dsp.window.drag(), {
    mouse = true,
    description = "Move window",
})

bind("SUPER + mouse:273", hl.dsp.window.resize(), {
    mouse = true,
    description = "Resize window",
})

-- ==========================================================
-- Described resizing binds
-- ==========================================================

bind("SUPER + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), {
    description = "Expand window left",
})

bind("SUPER + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), {
    description = "Shrink window left",
})

-- ==========================================================
-- Manual sizing
-- ==========================================================

legacy_dispatch("SUPER + minus", "resizeactive", '"-10% 0"', { repeating = true })
legacy_dispatch("SUPER + equal", "resizeactive", '"10% 0"', { repeating = true })
legacy_dispatch("SUPER + SHIFT + minus", "resizeactive", '"0 -10%"', { repeating = true })
legacy_dispatch("SUPER + SHIFT + equal", "resizeactive", '"0 10%"', { repeating = true })

-- ==========================================================
-- Screenshots
-- ==========================================================
--
-- Original DMS Print-screen binds are preserved.
-- SUPER + P variants are added because this keyboard does not have Print.

bind("SUPER + P", exec("dms screenshot"))
bind("SUPER + SHIFT + P", exec("dms screenshot full"))
bind("SUPER + ALT + P", exec("dms screenshot window"))

-- ==========================================================
-- System controls
-- ==========================================================

bind("SUPER + SHIFT + O", hl.dsp.dpms({ action = "toggle" }))

return M
