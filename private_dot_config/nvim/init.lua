-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
---@class ParserConfig
parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {},
  pattern = {},
})
vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
              extraArgs = { "--profile", "rust-analyzer" },
            },
          },
        },
        hint = { enabled = true },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
