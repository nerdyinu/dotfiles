-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- === Autocommand Groups ===
local format_group = augroup("Format", { clear = true })
local whitespace_group = augroup("TrimWhitespace", { clear = true })
local ruler_group = augroup("FiletypeRulers", { clear = true })

-- === JS/TS Specific Formatting (with typescript-tools and conform.nvim) ===
autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.ts", "*.tsx", "*.jsx", "*.js" },
  callback = function(args)
    local tstools = require("typescript-tools.api")
    tstools.add_missing_imports(true)
    tstools.organize_imports(true)
    tstools.fix_all(true)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- === Global Format on Save (fallback for all files with LSP/conform) ===
autocmd("BufWritePre", {
  group = format_group,
  callback = function(args)
    -- Skip JS/TS files since they're handled above
    local ext = vim.fn.expand("%:e")
    if ext ~= "ts" and ext ~= "tsx" and ext ~= "js" and ext ~= "jsx" then
      require("conform").format({ bufnr = args.buf })
    end
  end,
})

-- === Trim trailing whitespace on save ===
autocmd("BufWritePre", {
  group = whitespace_group,
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

-- === Ensure file ends with newline on save ===
autocmd("BufWritePre", {
  group = whitespace_group,
  callback = function()
    local last_line = vim.api.nvim_buf_get_lines(0, -2, -1, false)[1]
    if last_line ~= "" then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
    end
  end,
})

-- === Set rulers (colorcolumn) by filetype ===
autocmd("FileType", {
  group = ruler_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.colorcolumn = "80"
  end,
})

autocmd("FileType", {
  group = ruler_group,
  pattern = "rust",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end,
})

autocmd("FileType", {
  group = ruler_group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.colorcolumn = "50,72"
  end,
})
