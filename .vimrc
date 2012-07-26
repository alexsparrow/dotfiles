syntax on

"use auto-indenting by 4 spaces. ensure tabs are never inserted and
" tab key indents by 4 spaces.
set autoindent shiftwidth=4 expandtab tabstop=4 textwidth=0
set smartindent
set hlsearch

filetype indent plugin on

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

call pathogen#infect() 
set background=dark
"colorscheme solarized
colorscheme sunburst
"colorscheme wombat
"set background=dark

"let g:solarized_termcolors=256


autocmd FileType markdown set foldmethod=syntax
set foldlevelstart=99
