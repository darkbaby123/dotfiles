" ---------------------------------------
" Plugins
" ---------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

" Common plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'raimondi/delimitmate'    " Auto-insert brackets
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'danro/rename.vim'    " Rename file
" Plug 'godlygeek/tabular'

" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Completion
" Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ervandew/supertab'

"Search
" Plug 'mileszs/ack.vim'
" Plug 'dyng/ctrlsf.vim'

"Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'janko-m/vim-test'

" Markdown
" Plug 'plasticboy/vim-markdown'

" JavaScript
" Plug 'pangloss/vim-javascript'

" Themes
Plug 'romainl/flattened'    " Solarized with true color support
Plug 'dracula/vim'

call plug#end()



" ---------------------------------------
" System Settings
" ---------------------------------------

let mapleader = " "

set termguicolors
set background=dark

colorscheme flattened_dark
" colorscheme dracula

" Line numbers
set number
set relativenumber

" Tabs & spaces
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Minimal lines to keep above/below the cursor
set scrolloff=5

set conceallevel=2

" Don't show mode "-- INSERT --" in the command line
" Comment out it because i_CTRL-O "-- (insert) --" can't be shown on the airline
" set noshowmode


" ---------------------------------------
" Plugins Settings
" ---------------------------------------

" nerdtree
let NERDTreeCascadeSingleChildDir = 0

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-markdown
let g:vim_markdown_fenced_languages = ['elixir', 'javascript', 'html']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

" ultisnips
" NOTE: use the dir name "UltiSnips" so we don't need to customize "g:UltiSnipsSnippetDirectories"
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsEditSplit = 'vertical'

" ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
let g:ctrlp_max_history = 200
let g:ctrlp_show_hidden = 1
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
" let g:ctrlp_prompt_mappings = {
"   \ 'PrtDeleteEnt()':       ['<c-u>'],
"   \ }

" vim-test
let g:test#preserve_screen = 1
let test#strategy = 'neovim'



" ---------------------------------------
" Mappings
" ---------------------------------------

" Quick edit init.vim, key mapping is borrowed from Spacemacs
nnoremap <leader>fed <Esc>:e ~/.config/nvim/init.vim<CR>

noremap <C-\> :NERDTreeToggle<CR>

" Fuzzy finder
nnoremap <leader>ff <Esc>:CtrlP<CR>

" Search
nmap <leader>ss <Plug>CtrlSFPrompt
vmap <leader>ss <Plug>CtrlSFVwordPath
nnoremap <leader>st :CtrlSFToggle<CR>
nnoremap <leader>sc ::CtrlSFClearHL<CR>

" Buffers
nnoremap <leader>bb <Esc>:CtrlPBuffer<CR>
nnoremap <leader>bp <C-^>

" Bookmarks
nnoremap <leader>mm <Esc>:CtrlPBookmarkDir<CR>
nnoremap <leader>ma <Esc>:CtrlPBookmarkDirAdd

" WIndow navigations
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tests
nnoremap <silent> <leader>tc :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>

" Copy file relative path to the system clipboard
nnoremap <silent> <leader>cp :let @+ = expand("%")<CR>

" In terminal, key map to go to normal mode
tnoremap <C-o> <C-\><C-n>



" ---------------------------------------
" Auto commands
" ---------------------------------------

" Fix autoread issue, see https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work/2490635#2490635
au FocusGained,BufEnter * :silent! checktime
autocmd FocusGained * echo("Focus Gained")
