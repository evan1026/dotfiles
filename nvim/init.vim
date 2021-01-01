call plug#begin(stdpath('data') . '/plugged')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'doums/darcula'
call plug#end()

syntax on
set nu!
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap
set confirm

set termguicolors
colorscheme darcula

hi Normal guibg=black
hi LineNr guibg=black

set backspace=indent,eol,start
autocmd! BufNewFile,BufRead *.pde,*.ino setlocal ft=arduino

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set fillchars+=vert:\   "this comment is only here to suppress trailing whitespace warnings
hi VertSplit ctermbg=236 ctermfg=236
hi StatusLine ctermbg=236 ctermfg=236

nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <C-T> :tabnew<CR>

nnoremap <C-E> :Explore<CR>

nnoremap <C-N> :set nu!<CR>

highlight SignColumn ctermbg=none
set updatetime=1000

set wildignore=*.swp

set foldmethod=syntax
"hi Folded ctermbg=235 ctermfg=245 cterm=bold
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
set foldlevelstart=99

function! MyFoldText() " {{{
   let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . repeat(" ",fillcharcount) . foldedlinecount . ' lines '
endfunction " }}}
set foldtext=MyFoldText()

let g:deoplete#enable_at_startup = 1

