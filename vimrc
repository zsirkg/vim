"------------------------------------------------------------------------------
" File:     $HOME/.vimrc
" Author:   zsir <zsirkg@yahoo.com>
" Version:  0.1
"
" Based on https://github.com/s3rvac/dotfiles/blob/master/vim/.vimrc
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
" VundleVim (https://github.com/VundleVim/Vundle.vim).
"-----------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/csapprox'
Plugin 'Valloric/YouCompleteMe'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-utils/vim-man'

" vim-scripts repos  
Plugin 'ifdef-highlighting'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"------------------------------------------------------------------------------
" General.
"-----------------------------------------------------------------------------

syntax on

set t_Co=256
set magic               " 支持正则表达式等
set hidden              " 允许在未保存的buffer中切换

set number              " 显示行号
set relativenumber      " 显示相对行号

set scrolloff=10        " 垂直移动时保持n行固定
set sidescroll=5        " 水平移动时保持n列固定

set tabstop=4           " 制表符等于几个空格 
set shiftwidth=4        " 制表符缩进时应用几个空格
set noexpandtab         " 不使用扩展制表符

set wrap                " 文本回滚
set fencs=utf-8,gb18030 " 打卡文件时优先选择编码格式
set ffs=unix,dos,mac    " 文件结束符
set autoread            " 自动读取文件的修改(其他软件的修改)
set nofoldenable		" 关闭折叠

set hlsearch            " 搜索时高亮
set incsearch           " 搜索输入高亮
set nowrapscan          " 关闭搜索回滚
set ignorecase          " 搜索时忽略大小写

set showcmd             " 在状态栏中显示命令
set history=200         " 存储命令历史最大个数

set mouse=              " 关闭鼠标使用

" 关闭错误时声音
set noerrorbells
set novisualbell
set t_vb=

" 补全命令设置
set wildmenu
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg

" 状态栏
set laststatus=2        " 总是显示状态栏

"------------------------------------------------------------------------------
" Background
"-----------------------------------------------------------------------------

" 设置vim的本色方案
set background=dark
colorscheme desert_my

if has("gui_gtk2")
	set guifont=consolas\ 16
elseif has("gui_macvim")
	set guifont=consolas:h12
elseif has("gui_win32")
	set guifont=consolas:h11
end


"------------------------------------------------------------------------------
" Map
"-----------------------------------------------------------------------------

let g:mapleader = ","

" 快速重载配置文件
nnoremap <leader>s :source ~/.vimrc<cr> 
nnoremap <leader>e :e! ~/.vimrc<cr>

" 赋值到系统剪切版
noremap Y "+y
noremap P "+p

" ESC
inoremap jk <Esc>
inoremap <C-L> <Esc>

"------------------------------------------------------------------------------
" Function.
"-----------------------------------------------------------------------------

" 自动跳转到上一次打开的位置
autocmd BufReadPost *
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\ exe "normal! g'\"" |
			\ endif 

"------------------------------------------------------------------------------
" Plugin.
"-----------------------------------------------------------------------------

" Nerdtree
noremap <F7> :NERDTreeToggle<CR> 
noremap <C-N> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1 
noremap <F8> :TagbarToggle<CR>
noremap <C-M> :TagbarToggle<CR>

" bufexplorer
nnoremap <C-L> :ToggleBufExplorer<CR>

" YCM
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
