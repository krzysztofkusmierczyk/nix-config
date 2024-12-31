local wezterm = require("wezterm")

-- TODO: https://alexplescan.com/posts/2024/08/10/wezterm/

local config = wezterm.config_builder()

local is_mac = wezterm.target_triple:find("darwin") ~= nil

local function does_directory_exist(path)
	local command = 'test -d "' .. path .. '"'
	local result = os.execute(command)
	return result == 0
end
-- For macos
local homebrew_bin_path = "/opt/homebrew/bin"
if does_directory_exist(homebrew_bin_path) then
	config.set_environment_variables = {
		PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
	}
end

config.front_end = "WebGpu"
config.color_scheme = "tokyonight_night"
config.font_size = is_mac and 15 or 12
config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30
config.keys = {
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Sends ESC + b and ESC + f sequence, which is used
	-- for telling your shell to jump back/forward.
	{
		-- When the left arrow is pressed
		key = "LeftArrow",
		-- With the "Option" key modifier held down
		mods = "OPT",
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	},
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}

return config
