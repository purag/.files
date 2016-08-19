" +-------------------------+
" | .vimrc                  |       
" | Author: Purag Moumdjian |
" | Date: 14 Jul 2016       |
" +-------------------------+

let mapleader = "\\"

" +---------+
" | plugins |
" +---------+
"{{{

call plug#begin('~/.vim/plugged')

Plug 'metakirby5/codi.vim' " {{{
" }}}

Plug 'junegunn/vim-peekaboo' " {{{
" }}}

Plug 'airblade/vim-gitgutter' " {{{
  let g:gitgutter_map_keys = 0
  nmap <leader>ga <Plug>GitGutterStageHunk
  nmap <leader>gu <Plug>GitGutterUndoHunk
  nmap <leader>gp <Plug>GitGutterPreviewHunk
  nmap <leader>g] <Plug>GitGutterNextHunk
  nmap <leader>g[ <Plug>GitGutterPrevHunk
" }}}

Plug 'Yggdroot/indentline' " {{{
  set conceallevel=1
  let g:indentLine_conceallevel = 1
  let g:indentLine_color_term = 0
" }}}

Plug 'haya14busa/incsearch.vim' " {{{
" }}}

Plug 'osyo-manga/vim-over' " {{{
" }}}

Plug 'sheerun/vim-polyglot' " {{{
" }}}

if (version >= 704)
  Plug 'ludovicchabant/vim-gutentags' " {{{
  " }}}
endif

Plug 'jiangmiao/auto-pairs' " {{{
" }}}

call plug#end()

command! PI PlugInstall
command! PU PlugUpdate | PlugUpgrade

" }}}

" +-------------+
" | indentation |
" +-------------+
" {{{

" Change tabs to spaces
set expandtab

" Two-space tabwidth
set sw=2
set softtabstop=2

" auto-indent
set ai

" 8-wide tabs in assembly files
autocmd FileType asm set noexpandtab
autocmd FileType asm set sw=8
autocmd FileType asm set softtabstop=8

" 8-space indents in c++ files
autocmd FileType cpp set sw=8
autocmd FileType cpp set softtabstop=8

" 4-space indents in java files
autocmd FileType java set sw=4
autocmd FileType java set softtabstop=8

" }}}

" +--------------+
" | visual aides |
" +--------------+
" {{{

" Enable syntax highlighting
syntax on

" Show line numbers
set nu

" Set the color scheme to desert
colors desert

" }}}

" +----------------+
" | normalize keys |
" +----------------+
" {{{

" Make backspace work right.
set backspace=2

" auto-complete comments
set fo+=r

" }}}

" +--------+
" | search |
" +--------+
" {{{

  set ignorecase
  set smartcase
  set incsearch
  set showmatch
  set hlsearch

" }}}

" +------+
" | misc |
" +------+
" {{{

" set ctags file
set tags=~/tags

" enable mouse
set mouse=a

" scrolling settings
set scrolloff=5
set sidescrolloff=5

" disable bells
set noerrorbells
set visualbell
set t_vb=

" }}}

" +--------------+
" | key mappings |
" +--------------+
" {{{

" save and close a buffer using ctrl+x
inoremap <c-x>   <esc>:x<cr>
noremap  <c-x>   :x<cr>

" close a buffer using ctrl+w
" inoremap <c-w>   <esc>:q<cr>
" noremap  <c-w>   <esc>:q<cr>
" The above bindings kinda suck.

" force-close a buffer
inoremap <c-q>   <esc>:q!<cr>
noremap  <c-q>   :q!<cr>

" create a new tab using ctrl+t
noremap  <c-t>   <esc>:tabnew<cr>

" un-indent more easily
inoremap <s-tab> <c-d>
vnoremap >       >gv
vnoremap <       <gv
noremap  <tab>   I<c-t><esc>
noremap  <s-tab> I<c-d><esc>

" Fix pasting
nnoremap  p       ]p

" Fix undo
inoremap <c-z>   <esc>ua
noremap  <c-z>   u

" efficiency ftw
inoremap jj      <esc>
nnoremap ;       :

" }}}

" +-------------+
" | FOLDING FTW |
" +-------------+
" vim: syntax=vim foldmethod=marker foldlevel=0
