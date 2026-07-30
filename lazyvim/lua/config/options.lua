-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- -- Force root to current working directory
-- vim.g.root_spec = { "cwd" }

-- Abbriviations
-- Enter current date with format YYYY-MM-DD
vim.cmd([[
  inorea <expr> ymd strftime('%Y-%m-%d')
]])
