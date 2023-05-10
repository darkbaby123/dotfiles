require('nvim-tree').setup({
  remove_keymaps = {
    -- remove "remove" keymap, use trash instead
    'd',
  },
  trash = {
    cmd = 'trash'
  },
})

vim.keymap.set('n', '<Leader>tt', '<Cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>to', '<Cmd>NvimTreeOpen<CR>')
vim.keymap.set('n', '<Leader>tc', '<Cmd>NvimTreeClose<CR>')
