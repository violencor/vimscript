syntax enable
syntax on
set t_Co=256
colorscheme material-monokai
" colorscheme wombat256mod
colorscheme cpp
set nu
set shiftwidth=4
set tabstop=4
set expandtab
set hls
set incsearch
" se smartindent
set autoindent
set cindent
set foldmethod=syntax
set foldlevelstart=99
set ff=unix
set fileencoding=utf-8
set wildmenu
set wildmode=longest,list
set nostartofline
set notimeout ttimeout ttimeoutlen=200
set textwidth=79
highlight ColorColumn ctermbg=DarkGray guibg=lightgrey

" stateline
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
set statusline+=\ %F
set statusline+=\ %m
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

set nocompatible              " be iMproved, required
filetype off                  " required

" treat keywords as space
" set iskeyword-=_                 " remove '_' from keywords

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" YCM
Plugin 'Valloric/YouCompleteMe'
"
" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'https://github.com/suan/vim-instant-markdown.git'

" vim grep
Plugin 'https://github.com/yegappan/grep.git'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" set <Space> to <leader>
let mapleader = "\<Space>"
"让Vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu
" 复制所在单词
nnoremap <C-c> viwy
