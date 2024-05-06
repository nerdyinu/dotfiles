-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- if is_available("neo-tree.nvim") then
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>o", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd.wincmd("p")
  else
    vim.cmd.Neotree("focus")
  end
end, {
  desc = "Toggle Explorer Focus",
})
if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    vim.lsp.inlay_hint.enable(nil)
  end, { desc = "Toggle Inlay Hints" })
end
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if opts.desc then
      opts.desc = "keymaps.lua: " .. opts.desc
    end
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
vim.keymap.set("n", "<C-i>", "<C-I>")

vim.api.nvim_set_keymap("n", "<leader>spn", "<Plug>(SpotifySkip)", { silent = true }) -- Skip the current track
vim.api.nvim_set_keymap("n", "<leader>spp", "<Plug>(SpotifyPause)", { silent = true }) -- Pause/Resume the current track
vim.api.nvim_set_keymap("n", "<leader>sps", "<Plug>(SpotifySave)", { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap("n", "<leader>spo", ":Spotify<CR>", { silent = true }) -- Open Spotify Search window
vim.api.nvim_set_keymap("n", "<leader>spd", ":SpotifyDevices<CR>", { silent = true }) -- Open Spotify Devices window
vim.api.nvim_set_keymap("n", "<leader>spb", "<Plug>(SpotifyPrev)", { silent = true }) -- Go back to the previous track
vim.api.nvim_set_keymap("n", "<leader>sph", "<Plug>(SpotifyShuffle)", { silent = true }) -- Toggles shuffle mode
