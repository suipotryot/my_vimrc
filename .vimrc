" Gus vimrc
" Installation {{{
" If plugin manager is not installed, do it first
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}
" Plugins {{{
call plug#begin('~/.vim/plugged')
" Common plugins
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jmcantrell/vim-virtualenv'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors' " multiple cursors
Plug 'janko-m/vim-test' " To autorun tests
" Line numbers only in current window
Plug 'auwsmit/vim-active-numbers'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'junkblocker/patchreview-vim'
Plug 'codegram/vim-codereview'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
" Make vim-surround repeatable with .
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
" use vim as a personal wiki
Plug 'vimwiki/vimwiki'
" gundo for tree use of undo
Plug 'sjl/gundo.vim'
" ctrlp.vim for file fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" ack for grep search
Plug 'mileszs/ack.vim'
" For GOlang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" For typescript
Plug 'leafgarland/typescript-vim'
Plug 'ruanyl/vim-sort-imports'
Plug 'Quramy/tsuquyomi'
Plug 'godlygeek/tabular'
Plug 'Shougo/vimproc.vim'
Plug 'jiangmiao/auto-pairs'
" For javascript
Plug 'pangloss/vim-javascript'
" For Python
Plug 'davidhalter/jedi-vim'
" For global search/replace
Plug 'yegappan/greplace'
" For presentation
Plug 'alfredodeza/posero.vim'
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()
" }}}
" Colors {{{
colorscheme badwolf
set colorcolumn=100
set cursorline
" }}}
" Unit tests {{{
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" make test commands execute using make
let test#javascript#mocha#executable = "make test"
" Auto test on save
augroup test
  autocmd!
  autocmd BufWrite * if test#exists() |
    \   TestFile |
    \ endif
augroup END
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
set foldlevel=2
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
set ignorecase          " Commands ignore case
set smartcase           " Case sensitive if uppercase in pattern
" }}}
" Leader Shortcuts {{{
" turn off search highlight
let mapleader=","       " leader is coma"
nnoremap <leader><space> :nohlsearch<CR>
" save session
nnoremap <leader>s :mksession! ~/.vim/Session.vim<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>u :GundoToggle<CR>
" open ack.vim
nnoremap <leader>a :Ack!<Space>
" nex hunk
nnoremap <leader>n <Plug>GitGutterNextHunk
nnoremap <leader>p <Plug>GitGutterPrevHunk
" Deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}
" Golang {{{
au FileType go nnoremap <leader>d :GoDef<CR>
au FileType go nnoremap <leader>i :GoImport
" }}}
" Tsuquyomi (typescript) {{{
au FileType typescript nnoremap <leader>d :TsuDefinition<CR>
au FileType typescript nnoremap <leader>i :TsuImport<CR>
" }}}
" Python {{{
" highlight trailing whitespaces
"""let g:pymode_rope_goto_definition_bind = '<leader>d'
let g:jedi#completions_command = "<leader>d"
let g:jedi#rename_command = "<leader>r"
" }}}
" }}}
" Movement {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}}
" Custom commands {{{
autocmd! BufEnter *.posero :set nowrap
autocmd! BufEnter *.posero :set foldmethod=manual
autocmd BufRead * normal zz
autocmd! BufEnter *.feature :set nowrap
" Clean a .feature file pasted from github markdown:
" 1. remove ** arround words
" 2. remove empty lines
" 3. remove header separator like "|--|--|--|"
command! CleanFeature :%s/\*\*//ge | :%s/ \?## \?//ge | :exe 'g/^\s*$/d' | :exe 'g/^|--/d' |
            \  :exe 'g/^| --/d' | :%s/powerKW/kw/ge | :%s/TD/td/ge |
            \ execute "normal gg=G" | :exe 'g/^\s\+|/:Tab/|'
nmap =j :%!python -m json.tool<CR>
" }}}
" Custom mapping {{{
" exit terminal-mode with 
tnoremap jk <C-\><C-n>
" go up and down faster
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>
" Open a terminal easily
nnoremap <C-W><C-T> :terminal<CR>i
" Save with <C-S>, quit with <C-Q>
nnoremap <C-S> :w<CR>
nnoremap <C-Q> :q<CR>
" Change tabs with C-N and C-P
" nnoremap <C-P> :tabp<CR>
" nnoremap <C-N> :tabn<CR>
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
" vim wiki {{{
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'go': 'go', 'sh': 'sh'}
let g:vimwiki_list = [wiki]
let g:vimwiki_autowriteall = 0

au FileType vimwiki nnoremap <Space> :VimwikiToggleListItem<CR>
" }}}
" Ctrlp {{{
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
" Ignore .gitignore files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}}
" Git gutter {{{
set updatetime=100
" }}}
" Gundo {{{
let g:gundo_prefer_python3 = 1
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
" Prosero {{{
let g:posero_default_mappings = 1
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
" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<C-B>"
let g:UltiSnipsJumpForwardTrigger="<C-B>"
let g:UltiSnipsJumpBackwardTrigger="<C-Z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Where to look for snippets
let g:UltiSnipsSnippetDirectories=["Ultisnips", "custom_snippets"]
" Where to save snippets
let g:UltiSnipsSnippetsDir="~/.vim/custom_snippets"
" Load django snippets for python files
autocmd FileType python UltiSnipsAddFiletypes django
" }}}
" w0rp / ALE (Asynchronous Lint Engine) {{{
" only check syntax on save
let g:ale_set_highlights = 0 
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let b:ale_linters = {'javascript': ['es6']}
" }}}
" vim:foldmethod=marker:foldlevel=0
