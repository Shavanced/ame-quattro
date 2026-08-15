-- ────────────────────────────────────────────────────────────
-- Rainy Theme — Omarchy 4 / Hyprland 0.55+
-- ────────────────────────────────────────────────────────────

-- Keep the Rainy window geometry, opacity and border styling.
hl.config({
	general = {
		border_size = 2,
		gaps_in = 2,
		gaps_out = 4,

		["col.active_border"] = "#cba6f7",
		["col.inactive_border"] = "#1a1b26",
	},

	animations = {
		enabled = true,
	},

	decoration = {
		rounding = 15,

		shadow = {
			enabled = false,
			range = 15,
			render_power = 4,
			offset = { 0, 0 },
		},

		-- This is the original Rainy blur, preserved intentionally.
		--
		-- Old config:
		--   size = 1
		--   passes = 4
		--   contrast = 1.1
		--   brightness = 1.1
		--   vibrancy = 0.2
		--   vibrancy_darkness = 0.2
		--   noise = 0.03
		--   ignore_opacity = true
		--   new_optimizations = on
		blur = {
			enabled = true,
			size = 1,
			passes = 4,
			contrast = 1.1,
			brightness = 1.1,
			vibrancy = 0.2,
			vibrancy_darkness = 0.2,
			noise = 0.03,
			ignore_opacity = true,
			new_optimizations = true,
		},

		active_opacity = 0.93,
		inactive_opacity = 0.92,
		fullscreen_opacity = 1.0,
	},

	-- Num Lock must start OFF.
	input = {
		numlock_by_default = false,
	},
})

-- Original Rainy animation curve:
-- bezier = calm, 0.25, 0.9, 0.35, 1
hl.curve("calm", {
	type = "bezier",
	points = {
		{ 0.25, 0.9 },
		{ 0.35, 1.0 },
	},
})

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "calm" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "calm" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "calm" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "calm" })

hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "calm" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "calm" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "calm" })

hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "calm" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "calm" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "calm" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "calm" })

-- ────────────────────────────────────────────────────────────
-- QUICKSHELL GLASS BLUR
-- ────────────────────────────────────────────────────────────
--
-- Quickshell's PanelWindow/WlrLayershell defaults its Wayland
-- namespace to "quickshell". Omarchy 4 runs the entire desktop
-- shell as one Quickshell process, so this restores the old
-- Waybar/Mako/Walker/SwayOSD layer-blur effect at the compositor
-- level instead of trying to fake blur with shell colors.
--
-- `ignore_alpha = 0.1` is the closest common rule to the old
-- Waybar/Vicinae ignore-alpha behavior and lets translucent
-- surfaces expose the blurred desktop behind them.
--
-- This also covers the Omarchy menu (Quattro's unified menu, see
-- shell.toml [menu]) since it's rendered by the same Quickshell
-- process under the "quickshell" namespace. How much of that blur
-- actually shows through is tuned via [menu].background-alpha in
-- shell.toml, not here.
hl.layer_rule({
	match = { namespace = "^quickshell$" },
	blur = true,
	ignore_alpha = 0.1,
	blur_popups = true,
})

-- Keep the old Vicinae blur behavior too.
hl.layer_rule({
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0.1,
})
