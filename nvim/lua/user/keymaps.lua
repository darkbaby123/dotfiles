--[[
# maps

## Key name convension

Key names should align with Help doc. For example, write <Esc> instead of <esc>.
It's more clear, and you can't prevent using capital letters for key maps.

## Modes

  normal_mode = 'n',
  insert_mode = 'i',
  visual_mode = 'v',
  visual_block_mode = 'x',
  term_mode = 't',
  command_mode = 'c',

--]]

local map = vim.keymap.set

-- Global and local leader keys
map('', '<Space>', '<Nop>')

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Open init.lua in a new tab
map('n', '<Leader>fed', ':tabnew ~/.config/nvim/init.lua<CR>')


-- Leave terminal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- Copy current buffer path to '+' register
-- Useful when running test external
map('n', '<Leader>cp', function()
  vim.cmd([[let @+ = expand('%')]])
  print('Current file path copied!')
end, { silent = true })

-- Cancel highlight search
map('n', '<Leader>sc', ':nohlsearch<CR>')

-- In insert mode
-- Move foward/backward one character
map('i', '<C-f>', '<C-o>a')
map('i', '<C-b>', '<C-o>h')

-- Save file
map('n', '<Leader>ww', ':w<CR>')

-- Delete buffer but keep window
map('n', '<Leader>bd', function()
  vim.cmd('bp')
  vim.cmd('bw #')
end, { silent = true, desc = 'Buffer: Delete buffer' })

-- Quickfix
map('n', '[c', ':cprevious', { desc = 'Previous quickfix item' })
map('n', ']c', ':cnext', { desc = 'Next quickfix item' })

-- Location list
map('n', '[l', ':lprevious', { desc = 'Previous location list item' })
map('n', ']l', ':lnext', { desc = 'Next location list item' })
