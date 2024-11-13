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
vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
