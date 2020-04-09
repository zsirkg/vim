"------------------------------------------------------------------------------
" File:     $HOME/.vimrc
" Author:   zsir <zsirkg@yahoo.com>
" Version:  0.1
"
" Based on https://github.com/s3rvac/dotfiles/blob/master/vim/.vimrc
"------------------------------------------------------------------------------

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'justinmk/vim-syntax-extra'
Plug 'godlygeek/csapprox'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-utils/vim-man'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/peaksea'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'gregsexton/gitv'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/ifdef-highlighting'

" Initialize plugin system
call plug#end()

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

set tabstop=2           " 制表符等于几个空格
set shiftwidth=2        " 制表符缩进时应用几个空格
set expandtab           " 使用扩展制表符
set autoindent          " Auto indent
set si                  " Smart indent
set smarttab

set wrap                " 文本回滚
set fencs=utf-8,gb18030 " 打卡文件时优先选择编码格式
set ffs=unix,dos,mac    " 文件结束符
set autoread            " 自动读取文件的修改(其他软件的修改)
set nofoldenable        " 关闭折叠
set clipboard=unnamed   " 复制使用系统剪切板

set hlsearch            " 搜索时高亮
set incsearch           " 搜索输入高亮
set nowrapscan          " 关闭搜索回滚
set ignorecase          " 搜索时忽略大小写
set smartcase           " 搜索中含有大写则搜索大写

set showcmd             " 在状态栏中显示命令
set history=200         " 存储命令历史最大个数

set directory-=.        " swap文件不存储在当前文件夹

set list                " show trailing whitespace
set listchars=tab:▸\ ,trail:▫

" 退格键支持
set backspace=indent,eol,start

" 关闭gvim菜单
set guioptions-=m
set guioptions-=T

" 关闭错误时声音
set noerrorbells
set novisualbell
set t_vb=

" 补全命令设置
set wildmenu
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg

" 状态栏
set laststatus=2        " 总是显示状态栏

" 类缩进
set cino=g0

"------------------------------------------------------------------------------
" Background
"-----------------------------------------------------------------------------

" 设置vim的本色方案
syntax enable
if has('gui_running')
    set mouse=a
    "set background=light
    set background=dark
    colorscheme solarized
else
    set mouse=              " 关闭鼠标使用
    set background=dark
    " colorscheme solarized
    colorscheme peaksea
endif

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

" 移动支持折行
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" 窗口切换
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" 复制粘贴
" vnoremap d "1d
" vnoremap P "1p


" 保存
noremap <silent> <leader>w :w<CR>

" ESC
inoremap jk <Esc>

" tab切换
noremap <silent> <Left> :bp<CR>
noremap <silent> <Right> :bn<CR>

" 重新加载vimrc配置
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

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
noremap <silent> <leader>d :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>

" buffere
noremap <silent> <leader>b :ToggleBufExplorer<CR>

" easymotion
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

" YCM
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:max_diagnostics_to_display = 0
nnoremap <c-]> :YcmCompleter GoTo<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<cword><cr>

" a.vim
nnoremap <Leader>s :IHS<CR>:A<CR>
