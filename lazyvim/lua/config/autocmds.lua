-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("my_markdown", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
--   group = vim.api.nvim_create_augroup("my_git", { clear = true }),
--   pattern = { "gitconfig", "gitconfig_local" },
--   callback = function()
--     vim.bo.filetype = "gitconfig"
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufRead", {
--   group = vim.api.nvim_create_augroup("my_ssh", { clear = true }),
--   pattern = "*/ssh/config",
--   callback = function()
--     vim.bo.filetype = "sshconfig"
--   end,
-- })
