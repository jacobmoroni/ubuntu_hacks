set nocompatible              " be improved, required
set laststatus=2              " show which mode you are in and filename 
set encoding=utf-8            " sets default encoding
filetype off                  " required
set relativenumber            " shows relative line numbers 
set number                    " turns line numbers on

set clipboard=unnamedplus     " link to system clipboard
set tags=tags

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'flazz/vim-colorschemes'
Plugin 'lervag/vimtex'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'honza/vim-snippets'
"Plugin 'taketwo/vim-ros'
Plugin 'Raimondi/delimitMate'

" All of your Plugins must be added before the following line
call vundle#end()            " required
set completeopt-=preview     " sets autocomplete style
set lazyredraw               " load and paste quicker

filetype plugin indent on    " required
filetype plugin on           " lets plugins detect filetype
syntax on                    " turns on syntax highlighting
set tabstop=4                " sets default tab width to 4 spaces
set shiftwidth=4             " sets shift > to 4 spaces
set mouse=a                  " turns on mouse usage
set expandtab                " converts tabs to spaces
set t_Co=256                 " sets default color interpreter
colorscheme gruvbox          " sets colorscheme (from vim-colorschemes plugin)
set background=dark          " tells vim that the background is dark

let mapleader = "\\"         " sets leader to be
" maps spacebar to be the leader
nmap <space> <leader>        
vmap <space> <leader>
set backspace=indent,eol,start

" Escape Mappings for insert and visual modes
inoremap jk <esc>
vnoremap jk <esc>

" Mappings to edit .vimrc and source/save .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Mapping to edit ~/.vim/.ycm_extra_conf.py
nnoremap <leader>ycm :vsplit ~/.vim/.ycm_extra_conf.py<cr>

" Mappings to move between panes
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>

" Mapping for jumping
nnoremap <S-Tab> <C-O>

" Mappings for Git (vim-fugitive and git-gutter)
nnoremap <leader>gc :Gcommit <CR>
nnoremap <leader>gp :Gpush <CR>
nnoremap <leader>gb :Gbrowse <CR>
nmap <leader>ga <Plug>GitGutterStageHunk
nmap <leader>gd <Plug>GitGutterPreviewHunk
nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk

" Mappings to go to end of line and beginning of line
nnoremap L $
vnoremap L $
nnoremap H 0
vnoremap H 0

" Mappings to move up and down faster
nnoremap J 10j
nnoremap K 10k
vnoremap J 10j

vnoremap K 10k

" Mappings for tree list netrw
nnoremap <leade>ex :Vex <CR>
let g:netrw_banner = 0
let g:netrw_winsize = 20

autocmd FileType make set noexpandtab softtabstop=0

augroup cpp
  autocmd!
  set tabstop=2
  set shiftwidth=2
augroup END

au FileType c,cpp setlocal comments-=:// comments+=f://
inoremap {<CR> {<CR>}<Esc>ko

" Remap for latex compiling
nnoremap <leader>ll :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <leader>lv :!mupdf %:r.pdf &<CR><CR>

" This is for airline and powerline
" Note: If symbols don't appear install them with
" `sudo apt install fonts-powerline` Ubuntu
" or from https://github.com/powerline/fonts for macOS
" Note: there is a fix for iTerm2 mentioned in their README
let g:airline_powerline_fonts = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
au BufRead,BufNewFile *.launch set filetype=xml
au BufRead,BufNewFile *.rosrc set filetype=sh

" map Ctrl-s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" map Ctrl-q to soft quit
nmap <C-_> <leader>c<SPACE><CR>
vmap <C-_> <leader>c<SPACE><CR>
imap <C-_> <ESC><leader>c<SPACE><CR>

" map Alt-q to quit without saving
execute "set <M-q>=\eq"
noremap <silent><M-q> :quit!<CR>
vnoremap <silent><M-q> <C-C>:quit!<CR>
inoremap <silent><M-q> <C-O>:quit!<CR>

" map Alt-x to save and quit
execute "set <M-x>=\ex"
noremap <silent><M-x> :x<CR>
vnoremap <silent><M-x> <C-C>:x<CR>
inoremap <silent><M-x> <C-O>:x<CR>

" detect filetype for comments
filetype plugin on

" ctrl+/ to toggle comments
nmap <C-_> <leader>c<SPACE><CR>
vmap <C-_> <leader>c<SPACE><CR>
imap <C-_> <ESC><leader>c<SPACE><CR>

" Move lines with ctrl-up and ctrl-down
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
nmap <M-j> :m .+1<CR>==
nmap <M-k> :m .-2<CR>==
imap <M-j> <Esc>:m .+1<CR>==gi
imap <M-k> <Esc>:m .-2<CR>==gi
vmap <M-j> :m '>+1<CR>gv=gv
vmap <M-k> :m '<-2<CR>gv=gv
