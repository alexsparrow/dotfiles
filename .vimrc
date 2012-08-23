syntax on

"use auto-indenting by 4 spaces. ensure tabs are never inserted and
" tab key indents by 4 spaces.
set autoindent shiftwidth=4 expandtab tabstop=4 textwidth=0
set smartindent
set hlsearch
set number

filetype indent plugin on

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

call pathogen#infect() 
set background=dark
"let g:solarized_termtrans = 1
"colorscheme solarized
"togglebg#map("<F5>") 
"colorscheme sunburst
"colorscheme wombat
colorscheme Tomorrow-Night-Eighties

autocmd FileType markdown set foldmethod=syntax
set foldlevelstart=99

set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs

set wildmenu
set wildmode=longest:full,full

"Unmap arrow keys to learn
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
