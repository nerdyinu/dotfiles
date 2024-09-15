return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescript = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          ["vue"] = { "eslint_d" },
          ["css"] = { "eslint_d" },
          ["scss"] = { "eslint_d" },
          ["less"] = { "eslint_d" },
          ["html"] = { "eslint_d" },
          ["json"] = { "eslint_d" },
          ["jsonc"] = { "eslint_d" },
          ["yaml"] = { "eslint_d" },
          ["graphql"] = { "eslint_d" },
          ["handlebars"] = { "eslint_d" },
          ["astro"] = { "eslint_d" },
        },
        format_on_save = {
          -- I recommend these options. See :help conform.format for details.
          lsp_fallback = true,
          timeout_ms = 500,
        },
      })
    end,
  },
}
