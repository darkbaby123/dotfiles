-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy current buffer path to '+' register
-- Useful when running test external
vim.keymap.set("n", "<Leader>cp", function()
  vim.cmd([[let @+ = expand('%')]])
  print("Current file path copied!")
end, { silent = true })

-- In insert mode
-- Move foward/backward one character
vim.keymap.set("i", "<C-f>", "<C-o>a")
vim.keymap.set("i", "<C-b>", "<C-o>h")
