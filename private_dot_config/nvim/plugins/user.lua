return {
  {
    "folke/todo-comments.nvim",
    dependencies={"nvim-lua/plenary.nvim"},
   
    opts={},
    event = "User AstroFile",
    cmd = {"TodoQuickFix"},
    keys={
      {
        "<leader>T", "<cmd>TodoTelescope<cr>", desc="Open TODOs in Telescope",
    },
  },
  },
  {
      "m4xshen/hardtime.nvim",
     opts = {}
  },

  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   opts = {
  -- tools = { -- rust-tools options
  --
  --   -- how to execute terminal commands
  --   -- options right now: termopen / quickfix / toggleterm / vimux
  --   executor = require("rust-tools.executors").termopen,
  --
  --   -- callback to execute once rust-analyzer is done initializing the workspace
  --   -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
  --   on_initialized = nil,
  --
  --   -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
  --   reload_workspace_from_cargo_toml = true,
  --
  --   -- These apply to the default RustSetInlayHints command
  --   inlay_hints = {
  --     -- automatically set inlay hints (type hints)
  --     -- default: true
  --     auto = true,
  --
  --     -- Only show inlay hints for the current line
  --     only_current_line = false,
  --
  --     -- whether to show parameter hints with the inlay hints or not
  --     -- default: true
  --     show_parameter_hints = true,
  --
  --     -- prefix for parameter hints
  --     -- default: "<-"
  --     parameter_hints_prefix = "<- ",
  --
  --     -- prefix for all the other hints (type, chaining)
  --     -- default: "=>"
  --     other_hints_prefix = "=> ",
  --
  --     -- whether to align to the length of the longest line in the file
  --     max_len_align = false,
  --
  --     -- padding from the left if max_len_align is true
  --     max_len_align_padding = 1,
  --
  --     -- whether to align to the extreme right or not
  --     right_align = false,
  --
  --     -- padding from the right if right_align is true
  --     right_align_padding = 7,
  --
  --     -- The color of the hints
  --     highlight = "Comment",
  --   },
  --
  --   -- options same as lsp hover / vim.lsp.util.open_floating_preview()
  --   hover_actions = {
  --
  --     -- the border that is used for the hover window
  --     -- see vim.api.nvim_open_win()
  --     border = {
  --       { "╭", "FloatBorder" },
  --       { "─", "FloatBorder" },
  --       { "╮", "FloatBorder" },
  --       { "│", "FloatBorder" },
  --       { "╯", "FloatBorder" },
  --       { "─", "FloatBorder" },
  --       { "╰", "FloatBorder" },
  --       { "│", "FloatBorder" },
  --     },
  --
  --     -- Maximal width of the hover window. Nil means no max.
  --     max_width = nil,
  --
  --     -- Maximal height of the hover window. Nil means no max.
  --     max_height = nil,
  --
  --     -- whether the hover action window gets automatically focused
  --     -- default: false
  --     auto_focus = false,
  --   },
  --
  --   -- settings for showing the crate graph based on graphviz and the dot
  --   -- command
  --   crate_graph = {
  --     -- Backend used for displaying the graph
  --     -- see: https://graphviz.org/docs/outputs/
  --     -- default: x11
  --     backend = "x11",
  --     -- where to store the output, nil for no output stored (relative
  --     -- path from pwd)
  --     -- default: nil
  --     output = nil,
  --     -- true for all crates.io and external crates, false only the local
  --     -- crates
  --     -- default: true
  --     full = true,
  --
  --     -- List of backends found on: https://graphviz.org/docs/outputs/
  --     -- Is used for input validation and autocompletion
  --     -- Last updated: 2021-08-26
  --     enabled_graphviz_backends = {
  --       "bmp",
  --       "cgimage",
  --       "canon",
  --       "dot",
  --       "gv",
  --       "xdot",
  --       "xdot1.2",
  --       "xdot1.4",
  --       "eps",
  --       "exr",
  --       "fig",
  --       "gd",
  --       "gd2",
  --       "gif",
  --       "gtk",
  --       "ico",
  --       "cmap",
  --       "ismap",
  --       "imap",
  --       "cmapx",
  --       "imap_np",
  --       "cmapx_np",
  --       "jpg",
  --       "jpeg",
  --       "jpe",
  --       "jp2",
  --       "json",
  --       "json0",
  --       "dot_json",
  --       "xdot_json",
  --       "pdf",
  --       "pic",
  --       "pct",
  --       "pict",
  --       "plain",
  --       "plain-ext",
  --       "png",
  --       "pov",
  --       "ps",
  --       "ps2",
  --       "psd",
  --       "sgi",
  --       "svg",
  --       "svgz",
  --       "tga",
  --       "tiff",
  --       "tif",
  --       "tk",
  --       "vml",
  --       "vmlz",
  --       "wbmp",
  --       "webp",
  --       "xlib",
  --       "x11",
  --     },
  --   },
  -- },
  --
  -- -- all the opts to send to nvim-lspconfig
  -- -- these override the defaults set by rust-tools.nvim
  -- -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  -- server = {
  --   -- standalone file support
  --   -- setting it to false may improve startup time
  --   standalone = true,
  -- }, -- rust-analyzer options
  --
  -- -- debugging stuff
  --     dap = {
  --       adapter = {
  --         type = "executable",
  --         command = "lldb-vscode",
  --         name = "rt_lldb",
  --       },
  --     },
  --   }
  --
  -- },
  {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
  {
  "olimorris/onedarkpro.nvim",
  priority = 1000 -- Ensure it loads first
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
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},
{
  'xbase-lab/xbase',
    build = 'make install', -- or "make install && make free_space" (not recommended, longer build time)
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim", -- optional
      "nvim-lua/plenary.nvim", -- optional/requirement of telescope.nvim
      -- "stevearc/dressing.nvim", -- optional (in case you don't use telescope but something else)
    },
    config = function()
      require("lspconfig").sourcekit.setup({})
      require'xbase'.setup({})  -- see default configuration bellow
    end
}
}--
