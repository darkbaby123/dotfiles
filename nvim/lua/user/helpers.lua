local augroup = function(name, callback)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  callback(group)
end

local M = {
  augroup = augroup,
  autocmd = vim.api.nvim_create_autocmd,
}

return M
