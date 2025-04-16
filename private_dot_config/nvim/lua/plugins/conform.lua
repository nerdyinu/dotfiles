return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, _)
      local conform = require("conform")
      local util = require("conform.util")
      -- Clone base prettier config
      local base = vim.deepcopy(require("conform.formatters.prettier"))
      -- JSON (tab width 4)
      local json_formatter = vim.deepcopy(base)
      util.add_formatter_args(json_formatter, { "--tab-width", "4" }, { append = false })
      ---@cast json_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_json = json_formatter
      -- JSONC (tab width 2)
      local jsonc_formatter = vim.deepcopy(base)
      util.add_formatter_args(jsonc_formatter, { "--tab-width", "2" }, { append = false })
      ---@cast jsonc_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_jsonc = jsonc_formatter
      -- GraphQL (tab width 2)
      local graphql_formatter = vim.deepcopy(base)
      util.add_formatter_args(graphql_formatter, { "--tab-width", "2" }, { append = false })
      ---@cast graphql_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_graphql = graphql_formatter
      -- JavaScript (tab width 4)
      local js_formatter = vim.deepcopy(base)
      util.add_formatter_args(js_formatter, { "--tab-width", "4" }, { append = false })
      ---@cast js_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_js = js_formatter
      -- CSS (tab width 4)
      local css_formatter = vim.deepcopy(base)
      util.add_formatter_args(
        css_formatter,
        { "--single-quote", "true", "--tab-width", "4", "--prose-wrap", "preserve" },
        { append = false }
      )
      ---@cast css_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_css = css_formatter
      -- Markdown (prose-wrap, print-width)
      local md_formatter = vim.deepcopy(base)
      util.add_formatter_args(md_formatter, {
        "--prose-wrap",
        "always",
        "--print-width",
        "80",
      }, { append = false })
      ---@cast md_formatter conform.FormatterConfigOverride
      conform.formatters.prettier_markdown = md_formatter
      conform.setup({
        log_level = vim.log.levels.DEBUG,
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
        formatters = {
          prettier_css = css_formatter,
          prettier_json = json_formatter,
          prettier_jsonc = jsonc_formatter,
          prettier_graphql = graphql_formatter,
          prettier_js = js_formatter,
          prettier_markdown = md_formatter,
          prettier = {
            prepend_args = { "--single-quote", "true", "--tab-width", "4" },
          },
          rustfmt = {
            prepend_args = { "--config", "group_imports=StdExternalCrate" },
          },
        },
        formatters_by_ft = {
          javascript = { "prettier_js" },
          javascriptreact = { "eslint_d" },
          typescript = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          vue = { "eslint_d" },
          css = { "prettier_css" }, -- This should be working now
          scss = { "prettier_css" }, -- This should be working now
          less = { "eslint_d" },
          html = { "eslint_d" },
          json = { "prettier_json" }, -- Removed prettierd as it might be conflicting
          jsonc = { "prettier_jsonc" }, -- Removed prettierd as it might be conflicting
          graphql = { "prettier_graphql" },
          markdown = { "prettier_markdown" },
          yaml = { "prettier" },
          handlebars = { "eslint_d" },
          astro = { "eslint_d" },
          rust = { "rustfmt" },
          toml = { "taplo" },
          gitcommit = { "prettier_markdown" },
        },
      })

      -- Force the formatter for specific filetypes
      local augroup = vim.api.nvim_create_augroup("ConformCustom", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "css", "scss" },
        group = augroup,
        callback = function()
          vim.b.conform_formatters = { "prettier_css" }
        end,
      })
    end,
  },
}
