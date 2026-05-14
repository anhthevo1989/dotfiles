-- ==========================================================
-- FILE: hyprland.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides the main Hyprland Lua configuration.
--
-- WHY IT EXISTS
-- -------------
-- Hyprland 0.55 supports Lua configuration. This file replaces the old
-- Hyprlang config while keeping everything flat, readable, and easy to recover.
--
-- HOW IT WORKS
-- ------------
-- Hyprland loads this file from:
--
--   ~/.config/hypr/hyprland.lua
--
-- This file does not use require(), package.path, or external modules.
--
-- FLOW
-- ----
-- Hyprland starts
-- -> loads hyprland.lua
-- -> applies monitors
-- -> applies environment variables
-- -> starts session services
-- -> applies config sections
-- -> applies rules
-- -> applies keybinds
--
-- BEGINNER NOTES
-- --------------
-- If this file breaks, move it out of the way:
--
--   mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.broken
--
-- Hyprland can then fall back to the old hyprland.conf while legacy support is
-- still available.
-- ==========================================================

-- ----------------------------------------------------------
-- MONITORS
-- ----------------------------------------------------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- ----------------------------------------------------------
-- ENVIRONMENT
-- ----------------------------------------------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- ----------------------------------------------------------
-- AUTOSTART
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- AUTOSTART
-- ----------------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("dms run")
end)

-- ----------------------------------------------------------
-- CORE CONFIG
-- ----------------------------------------------------------

hl.config({
	input = {
		kb_layout = "us",
		numlock_by_default = true,
	},

	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 2,
		layout = "master",

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

	decoration = {
		rounding = 12,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 30,
			render_power = 5,
			color = "rgba(0F0D18ee)",
		},
	},

	animations = {
		enabled = true,
	},

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

-- ----------------------------------------------------------
-- ANIMATIONS
-- ----------------------------------------------------------

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

-- ----------------------------------------------------------
-- WINDOW RULES
-- ----------------------------------------------------------

hl.window_rule({
	name = "tile-wezterm",
	match = { class = "^(org\\.wezfurlong\\.wezterm)$" },
	tile = true,
})

hl.window_rule({
	name = "round-gnome",
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
	name = "tile-nm-editor",
	match = { class = "^(nm-connection-editor)$" },
	tile = true,
})

hl.window_rule({
	name = "float-calculator",
	match = { class = "^(org\\.gnome\\.Calculator|gnome-calculator|galculator)$" },
	float = true,
})

hl.window_rule({
	name = "float-blueman",
	match = { class = "^(blueman-manager)$" },
	float = true,
})

hl.window_rule({
	name = "float-nautilus",
	match = { class = "^(org\\.gnome\\.Nautilus)$" },
	float = true,
})

hl.window_rule({
	name = "float-xdg-portal",
	match = { class = "^(xdg-desktop-portal)$" },
	float = true,
})

hl.window_rule({
	name = "steam-toast-no-focus",
	match = {
		class = "^(steam)$",
		title = "^(notificationtoasts)",
	},
	no_focus = true,
})

hl.window_rule({
	name = "steam-toast-pin",
	match = {
		class = "^(steam)$",
		title = "^(notificationtoasts)",
	},
	pin = true,
})

hl.window_rule({
	name = "firefox-pip",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
	},
	float = true,
})

hl.window_rule({
	name = "float-zoom",
	match = { class = "^(zoom)$" },
	float = true,
})

-- ----------------------------------------------------------
-- LAYER RULES
-- ----------------------------------------------------------

hl.layer_rule({
	name = "no-anim-quickshell",
	match = { namespace = "^(quickshell)$" },
	no_anim = true,
})

hl.layer_rule({
	name = "no-anim-dms",
	match = { namespace = "^dms:.*" },
	no_anim = true,
})

-- ----------------------------------------------------------
-- APPLICATION LAUNCHERS
-- ----------------------------------------------------------

hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))

hl.bind("SUPER + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))
hl.bind("SUPER + comma", hl.dsp.exec_cmd("dms ipc call settings focusOrToggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("dms ipc call dankdash wallpaper"))
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))

-- ----------------------------------------------------------
-- CHEAT SHEET
-- ----------------------------------------------------------

hl.bind("SUPER + SHIFT + Slash", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"))

-- ----------------------------------------------------------
-- SECURITY
-- ----------------------------------------------------------

hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))

-- ----------------------------------------------------------
-- AUDIO CONTROLS
-- ----------------------------------------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
hl.bind(
	"CTRL + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("dms ipc call mpris increment 3"),
	{ locked = true, repeating = true }
)
hl.bind(
	"CTRL + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("dms ipc call mpris decrement 3"),
	{ locked = true, repeating = true }
)

-- ----------------------------------------------------------
-- BRIGHTNESS CONTROLS
-- ----------------------------------------------------------

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd('dms ipc call brightness increment 5 ""'),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd('dms ipc call brightness decrement 5 ""'),
	{ locked = true, repeating = true }
)

-- ----------------------------------------------------------
-- WINDOW MANAGEMENT
-- ----------------------------------------------------------

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + W", hl.dsp.group.toggle())
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("dms ipc call window-rules toggle"))

-- ----------------------------------------------------------
-- FOCUS NAVIGATION
-- ----------------------------------------------------------

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

-- ----------------------------------------------------------
-- WINDOW MOVEMENT
-- ----------------------------------------------------------

hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- ----------------------------------------------------------
-- WORKSPACE NAVIGATION
-- ----------------------------------------------------------

hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + U", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + I", hl.dsp.focus({ workspace = "e-1" }))

-- ----------------------------------------------------------
-- MOVE WINDOWS BETWEEN WORKSPACES
-- ----------------------------------------------------------

hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }))

hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- ----------------------------------------------------------
-- WORKSPACE MANAGEMENT
-- ----------------------------------------------------------

hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"))

-- ----------------------------------------------------------
-- MOUSE WHEEL WORKSPACE NAVIGATION
-- ----------------------------------------------------------

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- ----------------------------------------------------------
-- NUMBERED WORKSPACES
-- ----------------------------------------------------------

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))

-- ----------------------------------------------------------
-- MOVE TO NUMBERED WORKSPACES
-- ----------------------------------------------------------

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))

-- ----------------------------------------------------------
-- LAYOUT CONTROLS
-- ----------------------------------------------------------

hl.bind("SUPER + bracketleft", hl.dsp.layout("preselect l"))
hl.bind("SUPER + bracketright", hl.dsp.layout("preselect r"))
hl.bind("SUPER + R", hl.dsp.layout("togglesplit"))

-- ----------------------------------------------------------
-- MOUSE WINDOW CONTROLS
-- ----------------------------------------------------------

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ----------------------------------------------------------
-- SCREENSHOTS
-- ----------------------------------------------------------

hl.bind("SUPER + P", hl.dsp.exec_cmd("dms screenshot"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("dms screenshot full"))
hl.bind("SUPER + ALT + P", hl.dsp.exec_cmd("dms screenshot window"))

-- ----------------------------------------------------------
-- DISPLAY POWER
-- ----------------------------------------------------------

hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.dpms({ action = \"toggle\" })'"))
