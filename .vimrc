" Requirements: Install Vundle and YouCompleteMe

" Basic
syntax on
set t_Co=256
" set showmatch          
set mouse=a            
set number
" set backspace=indent,eol,start
set ruler
" set list

" Better search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set regexpengine=0
set wrap

" Don't need backups
set nobackup
set nowb
set noswapfile

" Fix issues escaping
set noesckeys
set timeoutlen=1000 ttimeoutlen=0

" Vundle setup
set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'

" ADD ALL PLUGINS BEFORE THIS
call vundle#end()            
filetype plugin indent on 

" Install plugins with vim +PluginInstall +qall or :PluginInstall
let g:ycm_enable_semantic_highlighting=1
