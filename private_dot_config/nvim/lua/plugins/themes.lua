return {

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = false,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        alpha = true,
        aerial = true,
        dap = { enabled = true, enable_ui = true },
        mason = true,
        neotree = true,
        notify = true,
        nvimtree = false,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        ts_rainbow = false,
        which_key = true,
      },
    },
  },
}
