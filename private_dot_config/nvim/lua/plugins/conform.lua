return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      local conform = require("conform")
      local util = require("conform.util")

      -- Deepcopy base formatter to customize multiple times
      local base = vim.deepcopy(require("conform.formatters.prettier"))

      local function with_args(args)
        local copy = vim.deepcopy(base)
        util.add_formatter_args(copy, args, { append = false })
        return copy
      end

      -- Merge new formatters
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        prettier_css = with_args({ "--single-quote", "true", "--tab-width", "4", "--prose-wrap", "preserve" }),
        prettier_json = with_args({ "--tab-width", "4" }),
        prettier_jsonc = with_args({ "--tab-width", "2" }),
        prettier_graphql = with_args({ "--tab-width", "2" }),
        prettier_js = with_args({ "--tab-width", "4" }),
        prettier_markdown = with_args({ "--prose-wrap", "always", "--print-width", "80" }),
        prettier = {
          prepend_args = { "--single-quote", "true", "--tab-width", "4", "--prose-wrap", "preserve" },
        },
        rustfmt = {
          prepend_args = { "--config", "group_imports=StdExternalCrate" },
        },
      })

      -- Merge formatters_by_ft
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "prettier_js" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        css = { "prettier_css" },
        scss = { "prettier_css" },
        less = { "eslint_d" },
        html = { "eslint_d" },
        json = { "prettier_json" },
        jsonc = { "prettier_jsonc" },
        graphql = { "prettier_graphql" },
        markdown = { "prettier_markdown" },
        yaml = { "prettier" },
        handlebars = { "eslint_d" },
        astro = { "eslint_d" },
        rust = { "rustfmt" },
        toml = { "taplo" },
        gitcommit = { "prettier_markdown" },
      })

      -- Optional: set log level and format_on_save if needed
      opts.log_level = vim.log.levels.DEBUG
      opts.format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      }
    end,

    config = function(_, opts)
      require("conform").setup(opts)

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
