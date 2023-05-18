local helpers = require('user.helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd

-- Line numbers
-- vim.opt.number = true
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

-- Mouse scroll in terminal
vim.opt.mouse = 'a'

-- Every wrapped line will continue visually indented
-- vim.opt.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs & spaces
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Display tabs and trailing spaces as special characters
--
-- Tip: In insert mode, type 'C-v u' then hex code to insert special character.
-- Tip: When the cursor is on the character, type 'ga' to display it's code on
-- command line.
vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '␣', extends = '»', precedes = '«' }

-- Minimal screen lines/columns to keep when moving cursor
-- 'scrolloff' also affects quickfix list so don't set it too high
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Conceal
vim.opt.concealcursor = 'nc'
vim.opt.conceallevel = 0

-- Command line height
vim.opt.cmdheight = 1

-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- Show signcolumn
vim.opt.signcolumn = 'yes'

-- Don't show things like '-- INSERT --' in command line
-- opt.showmode = false

-- Options with default values
-- I wrote them to remind myself, because they may be useful in future.
vim.opt.undofile = false
vim.opt.smartindent = false

-- Global status line
vim.opt.laststatus = 3

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- File type extension
vim.filetype.add({
  extension = {
    livemd = 'markdown'
  }
})

-- Highlight cursor line for current window
augroup('CursorLine', function(group)
  autocmd({ 'WinEnter', 'BufWinEnter' }, {
    group = group,
    pattern = '*',
    callback = function() vim.opt_local.cursorline = true end
  })

  autocmd('WinLeave', {
    group = group,
    pattern = '*',
    callback = function() vim.opt_local.cursorline = false end
  })
end)

-- Time (ms) to wait for a mapped sequence to complete
-- also affect which-key plugin
-- opt.timeoutlen = 500

-- Yank highlight
augroup('YankHighlight', function(group)
  autocmd('TextYankPost', {
    group = group,
    pattern = '*',
    callback = function()
      vim.highlight.on_yank({ timeout = 200 })
    end,
  })
end)

augroup("GitConfigHighlight", function(group)
  autocmd({ "BufNewFile", "BufReadPost" }, {
    group = group,
    pattern = { "gitconfig", "gitconfig_local" },
    callback = function()
      vim.bo.filetype = 'gitconfig'
    end,
  })
end)

augroup("SshConfigHighlight", function(group)
  autocmd("BufRead", {
    group = group,
    pattern = "*/ssh/config",
    callback = function()
      vim.bo.filetype = 'sshconfig'
    end,
  })
end)

-- Abbriviations
-- Enter current date with format YYYY-MM-DD
vim.cmd [[
  inorea <expr> ymd strftime('%Y-%m-%d')
]]
