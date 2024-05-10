local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"

-- Font settings
config.font = wezterm.font {
  family = 'Iosevka Term',
  stretch = 'Expanded',
  weight = 'Regular',
}
config.font_size = 15.0
config.line_height = 1.2
config.bold_brightens_ansi_colors = false

-- Color scheme
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'nordfox'
  else
    return 'dayfox'
  end
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

-- Key bindings
config.disable_default_key_bindings = true
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1001 }

config.keys = {
  -- Copy
  {
    key = 'c',
    mods = 'SUPER',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  -- Paste
  {
    key = 'v',
    mods = 'SUPER',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- Split vertical
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Split horizontal
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Toggle zoom pane
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- New tab
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'DefaultDomain',
  },
  -- Open command palette
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateCommandPalette,
  },
  -- Show debug overlay
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ShowDebugOverlay,
  },
  -- Activate key table resize_pane
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },
  -- Activate key table activate_pane
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'activate_pane',
      one_shot = false,
    },
  },
}

-- Select tab 1..9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = 'h', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
    { key = 'Escape', action = wezterm.action.PopKeyTable },
  },
  activate_pane = {
    { key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'Escape', action = wezterm.action.PopKeyTable },
  },
}

return config
