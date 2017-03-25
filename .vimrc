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

set fillchars+=vert:\ 
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

let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

let g:netrw_sort_options = "i"
let g:netrw_sort_sequence = "[\/]$,\<core\%(\.\d\+\)\=\>,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$)"

set completeopt-=preview
