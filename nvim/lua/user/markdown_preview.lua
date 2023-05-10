local helpers = require('user.helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd
local map = vim.keymap.set

vim.g.vim_markdown_toc_autofit = 1

augroup('MarkdownPreview', function(group)
  autocmd('FileType', {
    group = group,
    pattern = 'markdown',
    callback = function()
      local opts = { buffer = true }

      map('n', '<LocalLeader>pp', '<Plug>MarkdownPreviewToggle', opts)
      map('n', '<LocalLeader>pd', '<Plug>MarkdownPreviewStop', opts)
      map('n', '<LocalLeader>tf', '<Cmd>TableFormat<CR>', opts)

      map('n', '<LocalLeader>tc', function()
        -- open table of content, then go back to previous window
        vim.cmd('Toc')
        vim.cmd([[exe 'normal \<C-W>p']])
      end, opts)
    end
  })
end)
