"
" Plugins
"

call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'lifepillar/vim-solarized8'

" Functional plugins
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim'
Plug 'junegunn/fzf'
Plug 'neoclide/jsonc.vim'"
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-mix-format'
Plug 'janko-m/vim-test'

" Interesting stuff but not used
" Plug 'junegunn/goyo.vim'

call plug#end()

"
" Solarized 8
"

set termguicolors
set background=dark
colorscheme solarized8


