local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("Adwaita Mono Nerd Font")
config.enable_tab_bar = false

config.color_scheme = "jellybeans"

config.color_schemes = {
  ["jellybeans"] = {
    foreground = "#e8e8d3",
    background = "#151515",
    cursor_fg = "#151515",
    cursor_bg = "#e8e8d3",
    cursor_border = "#e8e8d3",
    selection_fg = "#151515",
    selection_bg = "#888888",
    compose_cursor = "#e8e8d3",
    visual_bell = "#40000a",
    ansi = {
      "#101010",
      "#B05050",
      "#99ad6a",
      "#dad085",
      "#8197bf",
      "#c6b6ee",
      "#2B5B77",
      "#c7c7c7",
    },
    brights = {
      "#404040",
      "#cf6a4c",
      "#99ad6a",
      "#ffb964",
      "#8fbfdc",
      "#c6b6ee",
      "#668799",
      "#ffffff",
    },
    indexed = {
      [16] = "#cf6a4c",
      [17] = "#d8ad4c",
      [18] = "#1c1c1c",
      [19] = "#303030",
      [20] = "#636363",
      [21] = "#c7c7c7",
    },
    tab_bar = {
      background = "#151515",
      active_tab = {
        bg_color = "#1c1c1c",
        fg_color = "#e8e8d3",
      },
      inactive_tab = {
        bg_color = "#101010",
        fg_color = "#888888",
      },
      inactive_tab_hover = {
        bg_color = "#1c1c1c",
        fg_color = "#a0a8b0",
      },
      new_tab = {
        bg_color = "#101010",
        fg_color = "#888888",
      },
      new_tab_hover = {
        bg_color = "#1c1c1c",
        fg_color = "#a0a8b0",
      },
    },
  },
}

return config
