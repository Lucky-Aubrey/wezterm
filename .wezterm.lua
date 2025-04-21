-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Get rid of the native window bar
config.window_decorations = "RESIZE"

-- Remove padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Fontsize
config.font_size = 10.0

-- Color scheme
-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "rose-pine"
-- config.color_scheme = "Github Dark"

-- Cyberdream (best with transparency)
-- config.colors = {
-- 	foreground = "#ffffff",
-- 	background = "#16181a",
--
-- 	cursor_bg = "#ffffff",
-- 	cursor_fg = "#16181a",
-- 	cursor_border = "#ffffff",
--
-- 	selection_fg = "#ffffff",
-- 	selection_bg = "#3c4048",
--
-- 	scrollbar_thumb = "#16181a",
-- 	split = "#16181a",
--
-- 	ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
-- 	brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
-- 	indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
-- }

-- config.window_background_opacity = 1.0
config.text_background_opacity = 0.3

-- function for toggling opacity
-- adjust these to the three levels you want:
local opacity_levels = { 1.0, 0.8, 0.3, 0.1 }

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	-- figure out what the current effective opacity is (default to 1.0)
	local current = overrides.window_background_opacity or 1.0

	-- find it in our list and pick the next one
	local next_index = 1
	for i, v in ipairs(opacity_levels) do
		if math.abs(current - v) < 1e-3 then
			next_index = (i % #opacity_levels) + 1
			break
		end
	end

	-- set up the override and apply it
	overrides.window_background_opacity = opacity_levels[next_index]
	window:set_config_overrides(overrides)
end)

config.front_end = "WebGpu" -- Dont know what this does
-- config.window_close_confirmation = "AlwaysPrompt"
config.default_workspace = "main"
config.scrollback_lines = 3000

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.8,
}

-- Keybindings
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("CounterClockwise") },
	{ key = "O", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	-- Use millions tabs and navigate through TabNavigator
	{ key = "e", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "c",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Renaming Tab Title...:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Toggle opacity
	{
		key = "b",
		mods = "LEADER",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	-- Lastly, workspace (TODO: Make launcher f)
	-- { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}
-- Move to tabs with number keys
for i = 1, 9 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}
-- Skip confirmation when closing last pane
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
	"pwsh.exe",
}

-- Tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

-- platform specific settings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
end

-- Everything below here is copied from another repository TODO find out from who for contribution (i think it was a youtuber)
wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#f7768e"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)
-- and finally, return the configuration to wezterm

return config
