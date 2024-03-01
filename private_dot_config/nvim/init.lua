-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

---@class ParserConfig
parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}
require("typescript-tools").setup({
  on_attach = function()
    require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TSToolsOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>cR", "TSToolsRenameFile", { desc = "Rename File", buffer = buffer })
    end)
  end,
  settings = {
    tsserver_file_preferences = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
    tsserver_format_options = {
      allowIncompleteCompletions = true,
      allowRenameOfImportPath = true,
    },
  },
})
