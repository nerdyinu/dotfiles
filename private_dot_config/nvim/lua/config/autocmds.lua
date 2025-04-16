-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- === Autocommand Groups ===
local format_group = augroup("Format", { clear = true })
local whitespace_group = augroup("TrimWhitespace", { clear = true })
local ruler_group = augroup("FiletypeRulers", { clear = true })
local tabsize_group = augroup("FiletypeTabSize", { clear = true })

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
    local ft = vim.bo.filetype
    if not vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, ft) then
      require("conform").format({ bufnr = args.buf })
    end
  end,
})

-- === Trim trailing whitespace on save ===
autocmd("BufWritePre", {
  group = whitespace_group,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
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

-- === Set tab size per filetype ===
autocmd("FileType", {
  group = tabsize_group,
  pattern = { "css" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd("FileType", {
  group = tabsize_group,
  pattern = { "graphql", "jsonc" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

autocmd("FileType", {
  group = tabsize_group,
  pattern = { "javascript", "json" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- fallback if needed for markdown
autocmd("FileType", {
  group = tabsize_group,
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
