set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'Valloric/YouCompleteMe'
    "Plugin 'scrooloose/syntastic'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    "Plugin 'majutsushi/tagbar'
    "Plugin 'mhinz/vim-signify'
    Plugin 'tpope/vim-sleuth'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'flazz/vim-colorschemes'
    Plugin 'LucHermitte/lh-vim-lib'
    Plugin 'LucHermitte/lh-tags'
    Plugin 'LucHermitte/lh-dev'
    Plugin 'LucHermitte/lh-brackets'
    Plugin 'LucHermitte/vim-refactor'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Bundle 'JuliaLang/julia-vim'
    Bundle 'octol/vim-cpp-enhanced-highlight'
    Plugin 'rdnetto/YCM-Generator'
    Plugin 'majutsushi/tagbar'
    Plugin 'vim-scripts/a.vim'
    Plugin 'xolox/vim-easytags'
    Plugin 'xolox/vim-misc'
    "Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on

syntax on
set nu!
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap
set confirm

set t_Co=256
colorscheme default

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

let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall'
let g:syntastic_cpp_compiler = 'clang++'

let g:netrw_list_hide_none = ''
let g:netrw_list_hide_hidden = '\(^\|\s\s\)\zs\.\S\+'

let g:netrw_liststyle = 3
let g:netrw_list_hide = g:netrw_list_hide_hidden

let g:netrw_sort_options = "i"
let g:netrw_sort_sequence = "[\/]$,\<core\%(\.\d\+\)\=\>,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$)"

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> <C-h> :call NetrwChangeHiddenFileState()<cr>
endfunction

function! NetrwChangeHiddenFileState()
    if g:netrw_list_hide ==# g:netrw_list_hide_none
        let g:netrw_list_hide = g:netrw_list_hide_hidden
        e.
    else
        let g:netrw_list_hide = g:netrw_list_hide_none
        e.
    endif
endfunction

command NetrwChangeHiddenFileState call NetrwChangeHiddenFileState()

set completeopt-=preview

set relativenumber

set foldmethod=syntax
hi Folded ctermbg=235 ctermfg=245 cterm=bold
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


nmap <F8> :TagbarToggle<CR>
hi TagbarHighlight guibg=Black ctermbg=Black
autocmd BufReadPost * nested :TagbarOpen
autocmd BufReadPost * nested :TagbarSetFoldlevel! 99

let g:e_tagbar_default_width = 30
let g:e_tagbar_expanded = 0
let g:tagbar_width = g:e_tagbar_default_width
function! TagbarWiden()
    if g:e_tagbar_expanded == 1
        let g:tagbar_width = g:e_tagbar_default_width
        let g:e_tagbar_expanded = 0
    else
        let g:tagbar_width = TagbarBufferWidth()
        let g:e_tagbar_expanded = 1
    endif
    :TagbarClose
    :TagbarOpen
endfunction
command TagbarSizeToggle call TagbarWiden()
nmap <F7> :TagbarSizeToggle<CR>
imap <F7> :TagbarSizeToggle<CR>

function! BufferWidth() abort
    let view = winsaveview()
    let max_col = 0
    g/^/let max_col=max([max_col, col('$') - 1])
    call histdel('search' -1)
    let @/ = histget('search', -1)
    call winrestview(view)
    return max_col
endfunction

function! TagbarBufferWidth()
    let current_win = winnr()
    call Win_by_bufname("Tagbar")
    let bwidth = BufferWidth()
    execute current_win 'wincmd w'
    return bwidth
endfunction

function! Win_by_bufname(bufname)
    let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
    let thewindow = filter(bufmap, 'v:val[0] =~ a:bufname')[0][1]
    execute thewindow 'wincmd w'
endfunction

hi YcmErrorSection cterm=underline ctermbg=52
hi YcmWarningSection cterm=underline ctermbg=94

let g:ycm_extra_conf_globlist = ['~/git/jackofclubs/', '~/git/ncurses-discord-cli', '~/git/blink1-control']
