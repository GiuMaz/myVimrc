" --- Plugins ---
call plug#begin('~/.vim/plugged')

" repeat plugin command using dot
Plug 'tpope/vim-repeat'

" NERD tree
Plug 'scrooloose/nerdTree', { 'on' : 'NERDTreeToggle' }

" gruvbox color scheme
Plug 'morhetz/gruvbox'

" easy code alignment
Plug 'godlygeek/tabular'

" surround text object
Plug 'tpope/vim-surround'

" autocompletation engine
Plug 'Valloric/YouCompleteMe', { 'do' : './install.py --clang-completer' }

" undo tree
Plug 'mbbill/undotree'
let g:undotree_WindowLayout=3 "open on the right side

" gutentags ctags manager
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = "~/.vim/gutentag" "gutentag cache directory

" asynchronous linter
Plug 'w0rp/ale'
let g:ale_enabled = 0 " disabled by default
" show what linter create the message
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" specify linter for some language
let g:ale_linters = { 'cpp': ['cppcheck','clangtidy'] }
" remove some unwanted warning (for clang-tidy in cpp)
let g:ale_cpp_clangtidy_checks = ['*',
            \ '-google-*',
            \ '-llvm-header-*',
            \ '-hicpp-*',
            \ '-fuchsia-*',
            \ '-readability-braces-around-statements']

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" fzf color
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" syntax highlight for smt2 file
Plug 'https://github.com/bohlender/vim-smt2'

" antlr4 file syntax hightlight
Plug 'jrozner/vim-antlr'

" clang-format support
Plug 'rhysd/vim-clang-format'

" Latex support
Plug 'lervag/vimtex'
" enable ycm support
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" Plug end
call plug#end()


" --- Vim options ---

" syntax highlighting
syntax on

" set leader to space
nnoremap <SPACE> <NOP>
let mapleader = "\<space>"
let maplocalleader = "\<space>"

" using gruvbox colorscheme
colorscheme gruvbox

" dark background
set background=dark

" Show (partial) command in status line
set showcmd

" no function preview in split
set completeopt-=preview

" Show matching brackets
set showmatch

" encoding
set encoding=utf-8

" no timeout for leader key and co
set notimeout
set nottimeout

" Do case insensitive matching
set ignorecase

" Do smart case matching
set smartcase

" Smart indentation
set smartindent

" smart tab
set smarttab

" Incremental search
set incsearch

" Hide buffers when they are abandoned
set hidden

" Enable mouse usage (all modes)
set mouse=a

" Enable highlight for the cursor line
set cursorline

" copy and past to the system clipboard
set clipboard=unnamedplus

" Better command-line completion
set wildmenu

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Indentation settings
set shiftwidth=4
set tabstop=4
set expandtab

" 80 char bar
set colorcolumn=80

" Display line numbers on the left
set number

" always show signcolumn
set signcolumn=yes

" scrolloff 3 lines
set scrolloff=3

" open new orizontal tab below
set splitbelow
" open new vertical tab on the right
set splitright

" save undo history across sessions
set undofile
set undodir=~/.vim/undohistory

" backup and swap file in specific location
set directory=~/.vim/swap
set backupdir=~/.vim/backup

" set simbol for (some) invisible characterG      
set listchars=tab:▸\ ,nbsp:·
set list

" statusline (default)
set laststatus=2

" --- Key mapping ---

" new line insert in normal mod
nnoremap <Leader>o mro<Esc>`r
nnoremap <Leader>O mrO<Esc>`r

" fzf file finder
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffer<CR>

" use ag as grep combined with fzf
nnoremap <Leader>g :Ag!<CR>

" exit visual mode wiht v
xnoremap v <Esc>

" n and N zoom in the middle of the screen
nnoremap <Silent> n nzz
nnoremap <Silent> N Nzz

" split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map <F2> to open/close nerd tree
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" map <F3> to toggle undotree
nnoremap <silent> <F3> :UndotreeToggle<cr>

" toggle linter
nnoremap <silent> <F7> :ALEToggle<cr>

" --- Autocomands ---

" close vim if NERD tree is the only buffer open
augroup close_vim_if_only_NERDTree
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 &&
            \ exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
