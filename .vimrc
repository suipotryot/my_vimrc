" Gus vimrc
" Installation {{{
" If vundle is not installed, do it first
if (!isdirectory(expand('$HOME/.vim/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.vim/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.vim/repos/github.com/Shougo/dein.vim'))
endif
" }}}
" Colors {{{
colorscheme badwolf
set colorcolumn=100
set cursorline
" }}}
" Misc {{{
syntax on
set encoding=utf8
set nu
set rnu
set noshowmode          " Let airline tell me my status
filetype on
set wrap linebreak nolist
set wildmenu            " Menu when command and tab in vim
set lazyredraw          " redraw only when we need to.
" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
inoremap jk <esc>
" Folding code
set foldmethod=indent
" Make vim save tmp files somewhere else
set backupdir=/tmp/
set directory=/tmp/
" For this file deidicated option at last line
set modelines=1
" }}}
" Spaces & Tabs {{{
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
" }}}
" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" }}}
" Leader Shortcuts {{{
" turn off search highlight
let mapleader=","       " leader is coma"
nnoremap <leader><space> :nohlsearch<CR>
" save session
nnoremap <leader>s :mksession<CR>
nnoremap <leader>t :NERDTreeTabsToggle<CR>
nnoremap <leader>u :GundoToggle<CR>
" open ack.vim
nnoremap <leader>a :Ack!<Space>
" }}}
" Movement {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}}
" Custom commands {{{
autocmd BufRead * normal zz
autocmd! BufEnter *.feature :set nowrap
" Clean a .feature file pasted from github markdown:
" 1. remove ** arround words
" 2. remove empty lines
" 3. remove header separator like "|--|--|--|"
command! CleanFeature :%s/\*\*//ge | :%s/ \?## \?//ge | :exe 'g/^\s*$/d' | :exe 'g/^|--/d' |
            \  :exe 'g/^| --/d' | :%s/powerKW/kw/ge | :%s/TD/td/ge |
            \ execute "normal gg=G" | :exe 'g/^\s\+|/:Tab/|'
" }}}
" Nerdtree {{{
" nerdtree
map <F2> :NERDTreeTabsToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc', '__pycache__']
" Open NERDTree if no file was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}
" Statusline {{{
set statusline+=%#warningmsg#
set statusline+=%*
" }}}
" Syntastic {{{
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}
" Tsuquyomi {{{
nnoremap <C-A> :TsuDefinition<CR>
nnoremap <C-I> :TsuImport<CR>
" }}}
" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" w0rp / ALE (Asynchronous Lint Engine) {{{
" only check syntax on save
let g:ale_set_highlights = 0 
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" }}}
" Ctrlp {{{
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <C-O> :CtrlP .<CR>
" Ignore .gitignore files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}}
" Gundo {{{
let g:gundo_prefer_python3 = 1
" }}}
" Custom mapping {{{
" go up and down faster
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>
" Save with <C-S>, quit with <C-Q>
nnoremap <C-S> :w<CR>
nnoremap <C-Q> :q<CR>
" Change tabs with C-N and C-P
nnoremap <C-P> :tabp<CR>
nnoremap <C-N> :tabn<CR>
" * In visual mode search for visual selection
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
" Change split with C- HJKL
nmap <C-K> :wincmd k<CR>
nmap <C-J> :wincmd j<CR>
nmap <C-H> :wincmd h<CR>
nmap <C-L> :wincmd l<CR>
" }}}
" Prosero {{{
let g:posero_default_mappings = 1
" }}}
" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Common plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
" gundo for tree use of undo
Plugin 'sjl/gundo.vim'
" ack for grep search
Plugin 'mileszs/ack.vim'
" For typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'ruanyl/vim-sort-imports'
Plugin 'Quramy/tsuquyomi'
Plugin 'godlygeek/tabular'
Plugin 'Shougo/vimproc.vim'
Plugin 'jiangmiao/auto-pairs'
" For global search/replace
Plugin 'yegappan/greplace'
" For presentation
Plugin 'alfredodeza/posero.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" vim:foldmethod=marker:foldlevel=0
