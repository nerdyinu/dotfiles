-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
local function setupAllLsps()
  -- Enable snippets-completion (nvim_cmp) and folding (nvim-ufo)
  local lspCapabilities = vim.lsp.protocol.make_client_capabilities()

  lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
  lspCapabilities.textDocument.foldingRange =
  { dynamicRegistration = false, lineFoldingOnly = true }

  local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
      capabilities = lspCapabilities
      -- you can add other fields for setting up lsp server in this table
    })
  end
end
return {
  -- add gruvbox

  { "max397574/better-escape.nvim", event = "InsertCharPre", opts = { timeout = 300 } },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   -- event = "User AstroFile",
  --   opts = { suggestion = { auto_trigger = true, debounce = 150 } },
  -- },
  { "ellisonleao/gruvbox.nvim", enabled = false },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- change trouble config
  -- {
  --   "folke/trouble.nvim",
  --   -- opts will be merged with the parent spec
  --   opts = { use_diagnostic_signs = true },
  -- },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  -- override nvim-cmp and add cmp-emoji
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-emoji" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     table.insert(opts.sources, { name = "emoji" })
  --     opts.mapping = cmp.mapping.preset.insert({
  --       ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-u>"] = cmp.mapping.scroll_docs(4),
  --       ["<CR>"] = cmp.mapping.confirm({ select = false }),
  --     })
  --   end,
  -- },

  -- change some telescope options and a keymap to browse plugin files

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  -- add pyright to lspconfig

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        astro = {
          typescript = {
            serverPath = vim.fs.normalize(
              "~/.local/share/pnpm/global/5/node_modules/typescript/lib/tsserverlibrary.js"
            ),
          },
          settings = {
            hint = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
          },
        },
        cssls = {},
        unocss = {},
        svelte = {},
        elixirls = {},
        html = {},
        intelephense = {
          settings = {
            stubs = {
              "Core",
              "SPL",
              "imagick",
              "standard",
              "pcre",
              "date",
              "json",
              "ctype",
              "SimpleXML",
              "Reflection",
              "exif",
            },
          },
        },
        lua_ls = {
          settings = {

            Lua = {
              format = {
                enable = true,
              },
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                enable = true,
                callSnippet = "Replace",
              },
              hint = { enabled = true },
            },
          },
        },
      },
    },
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "gitsigns.nvim",
    opts = {
      current_line_blame = true,
      update_debounce = 100,
      auto_attach = true,
      attach_to_untracked = true,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map({ "n", "v" }, "<leader>gh", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gL", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Diff This ~")
      end,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", false, mode = { "i" } }
    end,
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "jose-elias-alvarez/typescript.nvim",
  --     init = function()
  --       require("lazyvim.util").lsp.on_attach(function(_, buffer)
  --         -- stylua: ignore
  --         vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
  --         vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
  --       end)
  --     end,
  --   },
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       -- tsserver will be automatically installed with mason and loaded with lspconfig
  --
  --       tsserver = {
  --         -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
  --         settings = {
  --           javascript = {
  --             inlayHints = {
  --               includeInlayEnumMemberValueHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayParameterNameHints = "all",
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --             },
  --           },
  --           typescript = {
  --             inlayHints = {
  --               includeInlayEnumMemberValueHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayParameterNameHints = "all",
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --             },
  --           },
  --         },
  --       },
  --     },
  --     -- you can do any additional lsp server setup here
  --     -- return true if you don't want this server to be setup with lspconfig
  --     ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --     setup = {
  --       -- example to setup with typescript.nvim
  --       tsserver = function(_, opts)
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --       -- Specify * to use this function as a fallback for any server
  --       -- ["*"] = function(server, opts) end,
  --     },
  --   },
  -- },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- add more treesitter parsers
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {

  --     },
  --   },
  -- },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter

      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "rust",
        "astro",
        "php",
        "elixir",
        "heex",
        "eex",
        "vue",
        "svelte",
        "mdx",
        "css",
      })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({

        auto_install = true,
        highlight = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
    "KadoBOT/nvim-spotify",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      local spotify = require("nvim-spotify")

      spotify.setup({
        -- default opts
        status = {
          update_interval = 10000, -- the interval (ms) to check for what's currently playing
          format = "%s %t by %a", -- spotify-tui --format argument
        },
      })
    end,
    build = "make",
  },
  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local status = require("nvim-spotify").status
      status:start()
      table.insert(opts.sections.lualine_x, status.listen)
      -- table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       --[[add your custom lualine config here]]
  --     }
  --   end,
  -- },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "rustfmt",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --           -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
  -- {
  --   'nvim-orgmode/orgmode',
  --   dependencies = {
  --     { 'nvim-treesitter/nvim-treesitter', lazy = true },
  --   },
  --   event = 'VeryLazy',
  --   config = function()
  --     -- Load treesitter grammar for org
  --     require('orgmode').setup_ts_grammar()
  --
  --     -- Setup treesitter
  --     require('nvim-treesitter.configs').setup({
  --       highlight = {
  --         enable = true,
  --         additional_vim_regex_highlighting = { 'org' },
  --       },
  --       ensure_installed = { 'org' },
  --     })
  --
  --     -- Setup orgmode
  --     require('orgmode').setup({
  --       org_agenda_files = '~/orgfiles/**/*',
  --       org_default_notes_file = '~/orgfiles/refile.org',
  --     })
  --   end,
  -- },

  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
  },
}
