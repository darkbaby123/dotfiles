" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------


call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'lifepillar/vim-solarized8'

" Functional plugins
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'"
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Interesting stuff but not used
Plug 'junegunn/goyo.vim'
" Plug 'mhinz/vim-grepper'          " Replaced by coc-list
" Plug 'tpope/vim-projectionist'

call plug#end()


" ------------------------------------------------------------------------------
" Base settings
" ------------------------------------------------------------------------------


let mapleader = " "
let maplocalleader = ","

" Line numbers
set number
set relativenumber
set numberwidth=5

" Tabs & spaces
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Display tabs and trailing spaces as special characters
"
" Tip: In insert mode, type "C-v u" then hex code to insert special character.
" Tip: When the cursor is on the character, type "ga" to display it's code on
" command line.
set list
set listchars=tab:»·,trail:·,nbsp:␣,extends:»,precedes:«


" ------------------------------------------------------------------------------
" Solarized 8
" ------------------------------------------------------------------------------


set termguicolors
set background=dark
colorscheme solarized8

" Minimal lines to keep above/below the cursor
set scrolloff=5


" ------------------------------------------------------------------------------
" Coc
" ------------------------------------------------------------------------------


" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <Leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <Leader>f  <Plug>(coc-format-selected)
" nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" ------------------------------------------------------------------------------
" Test.vim
" ------------------------------------------------------------------------------


let test#strategy = 'neovim'


" ------------------------------------------------------------------------------
" vim-mix-format
" ------------------------------------------------------------------------------


let g:mix_format_on_save = 0


" ------------------------------------------------------------------------------
" indentline
" ------------------------------------------------------------------------------


let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileType = ['yaml']
" If indent line is opened in json, remember setting this
" let g:vim_json_syntax_conceal = 0


" ------------------------------------------------------------------------------
" vim-table-mode
" ------------------------------------------------------------------------------


" let g:table_mode_disable_mappings = 1
let g:table_mode_map_prefix = '<Leader>m'


" ------------------------------------------------------------------------------
" markdown-preview
" ------------------------------------------------------------------------------


let g:mkdp_auto_close = 0


" ------------------------------------------------------------------------------
" Key mappings
" ------------------------------------------------------------------------------


" Quick edit init.vim in new tab
nnoremap <silent> <Leader>fed  :<C-u>tabnew ~/.config/nvim/init.vim<CR>

" Back to normal mode in terminal mode
tnoremap <Esc> <C-\><C-n>

" Window navigations
nnoremap <silent> <Leader>wd  :<C-u>clo<CR>

" Cursor navigation in Insert Mode
" Move forward one char
inoremap <C-f>  <C-o>a
" Move backward one char
inoremap <C-b>  <C-o>h


" Search
" Open coc list
nnoremap <silent> <Leader>s.  :<C-u>CocList<CR>
" Do default action for next item.
nnoremap <silent> <Leader>sj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Leader>sk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>sl  :<C-u>CocListResume<CR>
" Show all files
nnoremap <silent> <Leader>sf  :<C-u>CocList files<CR>
nnoremap <C-p> :<C-u>CocList files<CR>
" Show all buffers
nnoremap <silent> <Leader>sb  :<C-u>CocList buffers<CR>
" Show mru
nnoremap <silent> <Leader>sm  :<C-u>CocList mru<CR>
" Show grep
nnoremap <silent> <Leader>sg  :<C-u>CocList grep<CR>
nnoremap <silent> <Leader>/  :<C-u>CocList grep<CR>
" Show all diagnostics
nnoremap <silent> <Leader>sa  :<C-u>CocList diagnostics<CR>
" Show outline
nnoremap <silent> <Leader>so  :<C-u>CocList outline<CR>
" Cancel highlight search
nnoremap <silent> <Leader>sc  :<C-u>nohlsearch<CR>

" Tests
" Run the test neareast to the cursor
nnoremap <silent> <Leader>tt  :TestNearest<CR>
" Run test file
nnoremap <silent> <Leader>tf  :TestFile<CR>
" Run test suite
nnoremap <silent> <Leader>ta  :TestSuite<CR>
" Run last test
nnoremap <silent> <Leader>tl  :TestLast<CR>

" Markdown
augroup markdown
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <Leader>pp :<C-U>MarkdownPreview<CR>
  autocmd FileType markdown nnoremap <buffer> <Leader>pd :<C-U>MarkdownPreviewStop<CR>
  autocmd FileType markdown nnoremap <buffer> <Leader>tt :<C-U>TableModeToggle<CR>
augroup END

" Local config
if filereadable($HOME  . '/.config/nvim/init_local.vim')
  source ~/.config/nvim/init_local.vim
end
