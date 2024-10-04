local wezterm = require("wezterm")
local config = {}

-- Window settings
config.window_decorations = "NONE"
config.initial_cols = 145
config.initial_rows = 35
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false

-- Colors
local current_theme = "Catppuccin Macchiato (Gogh)"
config.color_scheme = current_theme
local colors = wezterm.color.get_builtin_schemes()[current_theme]
config.colors = {
	tab_bar = {
		background = colors.background,
		active_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
			-- italic = true,
			intensity = "Bold",
			underline = "Single",
		},
		inactive_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
		new_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
	},
}

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

-- keybindings
local act = wezterm.action
config.disable_default_key_bindings = true
config.keys = {

	-- Commands
	{ key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
	{ key = "v", mods = "SUPER", action = act.ActivateCopyMode },

	-- Copy - paste
	{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	-- Arrow moving
	{ key = "h", mods = "ALT", action = act.SendKey({ key = "LeftArrow" }) },
	{ key = "j", mods = "ALT", action = act.SendKey({ key = "DownArrow" }) },
	{ key = "k", mods = "ALT", action = act.SendKey({ key = "UpArrow" }) },
	{ key = "l", mods = "ALT", action = act.SendKey({ key = "RightArrow" }) },
	{ key = "l", mods = "ALT|CTRL", action = act.SendKey({ key = "RightArrow", mods = "CTRL" }) },

	-- Panes
	{ key = "'", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "Backspace", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },

	-- Tabs
	{ key = "\\", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "Backspace", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },

	--binds CTRL 1-9 to switch tabs
	require("tab_activation").set_keybindings(),
}

return config
