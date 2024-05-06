return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
          ["vue"] = { "biome" },
          ["css"] = { "biome" },
          ["scss"] = { "biome" },
          ["less"] = { "biome" },
          ["html"] = { "biome" },
          ["json"] = { "biome" },
          ["jsonc"] = { "biome" },
          ["yaml"] = { "biome" },
          ["graphql"] = { "biome" },
          ["handlebars"] = { "biome" },
          ["astro"] = { "prettier" },
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
