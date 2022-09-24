local wezterm = require("wezterm")
local io = require("io")
local act = wezterm.action

local theme_file = wezterm.home_dir .. "/.local/share/wezterm/colors.json"

local left_decor = utf8.char(0xe0ba)
local right_decor = utf8.char(0xe0b8)

wezterm.on("format-tab-title", function(tab, _, _, config, hover, max_width)
	local colors = config.color_schemes[config.color_scheme]
	if colors == nil then
		return
	end

	local background = colors.tab_bar.inactive_tab.bg_color
	local foreground = colors.tab_bar.inactive_tab.fg_color

	if tab.is_active or hover then
		background = colors.tab_bar.active_tab.bg_color
		foreground = colors.tab_bar.active_tab.fg_color
	end

	local edge_background = colors.tab_bar.background
	local edge_foreground = background

	local tab_title = tab.tab_title
	if tab_title == nil or #tab_title == 0 then
		tab_title = tab.active_pane.title
	end

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local title = " " .. wezterm.truncate_right(tab_title, max_width - 4) .. " "

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_decor },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = right_decor },
	}
end)

wezterm.on("update-right-status", function(window)
	local status = ""
	if window:active_key_table() ~= nil then
		status = " "
	end
	window:set_right_status(status)
end)

-- Set a tab title
function Title(title)
	---@diagnostic disable-next-line:undefined-field
	local gui_window = _G.window
	local window = wezterm.mux.get_window(gui_window:window_id())
	for _, tab_info in ipairs(window:tabs_with_info()) do
		if tab_info.is_active then
			tab_info.tab:set_title(title)
			break
		end
	end
end

-- Run a command, return the output.
local run = function(cmd)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	s = s:gsub("^%s+", "")
	s = s:gsub("%s+$", "")
	s = s:gsub("[\n\r]+", " ")
	return s
end

-- Run a command, return the output.
local runw = function(cmd)
	local success, stdout, _ = wezterm.run_child_process(cmd)
	local lines = {}
	if success then
		for s in stdout:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end
	end
	return lines
end

local vim_dir_map = {
	Up = "up",
	Down = "down",
	Left = "left",
	Right = "right",
}

local arch = run("arch")
local homebrew_base = "/opt/homebrew/bin"
if arch == "i386" then
	homebrew_base = "/usr/local"
end
local timeout = homebrew_base .. "/bin/timeout"
local nvim = homebrew_base .. "/bin/nvim"

-- Return an action callback for managing movement between panes
local move_action = function(dir)
	return wezterm.action_callback(function(window, pane)
		local name = pane:get_foreground_process_name()
		if name ~= nil and pane:get_foreground_process_name():sub(-4) == "nvim" then
			-- Try to do the move in vim. If it doesn't work, do the move in
			-- wezterm. Use timeout because `nvim --remote-expr` will hang
			-- indefinitely if the messages area is focused in nvim.
			local result = run(
				timeout
					.. " 0.2 "
					.. nvim
					.. " --server /tmp/nvim-wt"
					.. pane:pane_id()
					.. ' --remote-expr \'v:lua.require("user.wezterm").go_'
					.. vim_dir_map[dir]
					.. "()' 2>&1"
			)
			if result ~= "" and not result:find("SIGTERM") then
				return
			end
		end
		window:perform_action(act.ActivatePaneDirection(dir), pane)
	end)
end

-- Return an action callback for cycling through changing color schemes
local change_scheme_action = function(dir)
	return wezterm.action_callback(function(window)
		local config = window:effective_config()

		local schemes = {}
		for name, _ in pairs(wezterm.get_builtin_color_schemes()) do
			table.insert(schemes, name)
		end

		local current_scheme = config.color_scheme
		local new_scheme
		if dir == "next" then
			for i, name in ipairs(schemes) do
				if name == current_scheme then
					local new_i = i + 1
					if new_i > #schemes then
						new_i = 1
					end
					new_scheme = schemes[new_i]
					break
				end
			end
		else
			for i = #schemes, 1, -1 do
				if schemes[i] == current_scheme then
					local new_i = i - 1
					if new_i < 1 then
						new_i = #schemes
					end
					new_scheme = schemes[new_i]
					break
				end
			end
		end

		if new_scheme == nil then
			new_scheme = schemes[1]
		end

		print('Setting scheme to "' .. new_scheme .. '"')

		local scheme_data = wezterm.get_builtin_color_schemes()[new_scheme]
		local bg = wezterm.color.parse(scheme_data.background)
		local _, _, l, _ = bg:hsla()

		local scheme_json = {
			name = new_scheme,
			is_dark = l < 0.5,

			bg_0 = scheme_data.background,
			fg_0 = scheme_data.foreground,

			bg_1 = scheme_data.ansi[1],
			red = scheme_data.ansi[2],
			green = scheme_data.ansi[3],
			yellow = scheme_data.ansi[4],
			blue = scheme_data.ansi[5],
			magenta = scheme_data.ansi[6],
			cyan = scheme_data.ansi[7],
			dim_0 = scheme_data.ansi[8],

			bg_2 = scheme_data.brights[1],
			br_red = scheme_data.brights[2],
			br_green = scheme_data.brights[3],
			br_yellow = scheme_data.brights[4],
			br_blue = scheme_data.brights[5],
			br_magenta = scheme_data.brights[6],
			br_cyan = scheme_data.brights[7],
			fg_1 = scheme_data.brights[8],

			orange = scheme_data.indexed[18] or scheme_data.ansi[2],
			violet = scheme_data.indexed[20] or scheme_data.ansi[5],
			br_orange = scheme_data.indexed[19] or scheme_data.brights[2],
			br_violet = scheme_data.indexed[21] or scheme_data.brights[5],
		}

		local file = assert(io.open(theme_file, "w"))
		file:write(wezterm.json_encode(scheme_json))
		file:close()

		local overrides = window:get_config_overrides() or {}
		overrides.color_scheme = new_scheme
		window:set_config_overrides(overrides)

		local lines = runw({ homebrew_base .. "/bin/nvr", "--serverlist" })
		local servers = { table.unpack(lines, 2, #lines) }
		for _, server in ipairs(servers) do
			runw({
				timeout,
				"0.2",
				nvim,
				"--server",
				server,
				"--remote-expr",
				"v:lua.require('user.colors.wezterm').apply_theme()",
			})
		end
	end)
end

local copy_mode_action = function()
	return wezterm.action_callback(function(window, pane)
		if window:active_key_table() == "window_ops" then
			window:perform_action(act.PopKeyTable, pane)
		end
		window:perform_action(act.ActivateCopyMode, pane)
	end)
end

local save_win_state = function()
	local data = {}

	local windows = {}
	for _, win in ipairs(wezterm.mux.all_windows()) do
		local gui_win = win:gui_window()
		local dims = gui_win:get_dimensions()

		local tabs = {}
		for _, tab in ipairs(win:tabs()) do
			local panes = {}
			for _, pane in ipairs(tab:panes_with_info()) do
				table.insert(panes, {
					top = pane.top,
					left = pane.left,
					width = pane.width,
					height = pane.height,
				})
			end
			table.insert(tabs, {
				id = tab:tab_id(),
				panes = panes,
			})
		end

		table.insert(windows, {
			id = win:window_id(),
			width = dims.pixel_width,
			height = dims.pixel_height,
			tabs = tabs,
		})
	end

	data.windows = windows

	local filename = wezterm.home_dir .. "/.local/share/wezterm/win_state.json"
	local file = assert(io.open(filename, "w"))
	file:write(wezterm.json_encode(data))
	file:close()
end

local scheme = "Selenized Light"

local file = io.open(theme_file, "r")
if file ~= nil then
	-- If a theme file exists, use the scheme specified there
	local text = assert(file:read("*a"))
	file:close()
	local theme = wezterm.json_parse(text)
	scheme = theme.name
else
	-- Otherwise, switch between light and dark themes based on the system theme
	if wezterm.gui.get_appearance():find("Dark") then
		scheme = "Selenized Black"
	end
end

return {
	color_scheme = scheme,

	color_scheme_dirs = { "./colors" },

	font_size = 13,

	-- disable ligatures
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	hide_tab_bar_if_only_one_tab = true,

	key_tables = {
		copy_mode = {
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },

			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },

			{ key = " ", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },

			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

			{
				key = "y",
				action = act.Multiple({
					act.CopyTo("ClipboardAndPrimarySelection"),
					act.CopyMode("Close"),
				}),
			},

			{ key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		},

		window_ops = {
			{ key = "j", action = move_action("Down") },
			{ key = "k", action = move_action("Up") },
			{ key = "h", action = move_action("Left") },
			{ key = "l", action = move_action("Right") },
			{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 4 }) },
			{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 4 }) },
			{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 4 }) },
			{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 4 }) },
			{ key = "m", action = act.PaneSelect({ mode = "SwapWithActive" }) },
			{ key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
			{ key = "\\", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
			{ key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
			{ key = "Escape", action = act.PopKeyTable },
			{ key = "c", action = copy_mode_action() },
			{ key = "c", mods = "CTRL", action = act.PopKeyTable },
			{ key = "w", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		},
	},

	keys = {
		{ key = "j", mods = "CTRL", action = move_action("Down") },
		{ key = "k", mods = "CTRL", action = move_action("Up") },
		{ key = "h", mods = "CTRL", action = move_action("Left") },
		{ key = "l", mods = "CTRL", action = move_action("Right") },
		{ key = "t", mods = "CTRL", action = act.SpawnTab("DefaultDomain") },
		{
			key = "\\",
			mods = "CMD|CTRL",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "CMD|CTRL",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "LeftArrow", mods = "CMD|SHIFT", action = act.MoveTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|SHIFT", action = act.MoveTabRelative(1) },
		{
			key = "s",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "window_ops",
				one_shot = false,
				timeout_milliseconds = 1000,
				until_unknown = true,
				replace_current = true,
			}),
		},
		{
			key = "/",
			mods = "ALT",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|COMMANDS|LAUNCH_MENU_ITEMS" }),
		},
		{ key = "/", mods = "CMD", action = act.ShowDebugOverlay },
		{
			key = "s",
			mods = "CMD|CTRL",
			action = wezterm.action_callback(save_win_state),
		},
		{ key = "<", mods = "CMD|SHIFT|CTRL", action = change_scheme_action("prev") },
		{ key = ">", mods = "CMD|SHIFT|CTRL", action = change_scheme_action("next") },
	},

	term = "wezterm",

	use_fancy_tab_bar = false,

	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
}
