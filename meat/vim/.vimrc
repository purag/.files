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

Plug 'tpope/vim-fugitive' " {{{
  nmap <leader>gb :Gblame<cr>
  nmap <leader>gc :Gcommit<cr>
  nmap <leader>gp :Gpush<cr>
" }}}

Plug 'airblade/vim-gitgutter' " {{{
  let g:gitgutter_map_keys = 0
  nmap <leader>ga <Plug>GitGutterStageHunk
  nmap <leader>gu <Plug>GitGutterUndoHunk
  " nmap <leader>gp <Plug>GitGutterPreviewHunk
  nmap <leader>g] <Plug>GitGutterNextHunk
  nmap <leader>g[ <Plug>GitGutterPrevHunk
" }}}

Plug 'Yggdroot/indentline' " {{{
  set conceallevel=1
  let g:indentLine_conceallevel = 1
  let g:indentLine_color_term = 237
  let g:indentLine_char = '│'
" }}}

Plug 'haya14busa/incsearch.vim' " {{{
" }}}

Plug 'osyo-manga/vim-over' " {{{
  nnoremap <leader>s <esc>:OverCommandLine<cr>%s/
  vnoremap <leader>s <esc>gv:OverCommandLine<cr>s/
" }}}

Plug 'sheerun/vim-polyglot' " {{{
" }}}

if (version >= 704)
  Plug 'ludovicchabant/vim-gutentags' " {{{
  " }}}
endif

Plug 'jiangmiao/auto-pairs' " {{{
  let g:AutoPairsMultilineClose = 0
  let g:AutoPairsFlyMode = 1
" }}}

Plug 'terryma/vim-multiple-cursors' " {{{
" }}}

Plug 'junegunn/fzf', " {{{
  \ { 'do': './install --bin' }
" }}}

Plug 'junegunn/fzf.vim' " {{{
  nnoremap <leader>zf <esc>:Files<cr>
  nnoremap <leader>zh <esc>:History<cr>
  nnoremap <leader>zg <esc>:GFiles<cr>
" }}}

Plug 'tpope/vim-commentary' " {{{
" }}}

Plug 'vim-airline/vim-airline' " {{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  set encoding=utf-8
  set laststatus=2
" }}}

Plug 'vim-airline/vim-airline-themes' " {{{
  let g:default_airline_theme = 'neodark'
  let g:alt_airline_theme = 'raven'
  function! ToggleAirlineTheme()
    if g:airline_theme == g:alt_airline_theme
      exec 'AirlineTheme '.g:default_airline_theme
    else
      exec 'AirlineTheme '.g:alt_airline_theme
    endif
  endfunction
  nnoremap <leader>at :call ToggleAirlineTheme()<cr>

  exec 'AirlineTheme '.g:default_airline_theme
" }}}

Plug 'mhinz/vim-startify' " {{{
" }}}

Plug 'vim-syntastic/syntastic' " {{{
" }}}

Plug 'tpope/vim-surround' " {{{
" }}}

" Themes {{{

Plug 'oguzbilgic/sexy-railscasts-theme' " {{{
" }}}

Plug 'sickill/vim-monokai' " {{{
" }}}

Plug 'rakr/vim-two-firewatch' " {{{
" }}}

Plug 'mhartington/oceanic-next' " {{{
" }}}

Plug 'tyrannicaltoucan/vim-quantum' " {{{
" }}}

Plug 'KeitaNakamura/neodark.vim' " {{{
" }}}

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

" 4-space indents in c/c++ files
autocmd FileType c set sw=4
autocmd FileType c set softtabstop=4
autocmd FileType cpp set sw=4
autocmd FileType cpp set softtabstop=4

" 4-space indents in java files
autocmd FileType java set sw=4
autocmd FileType java set softtabstop=4

" }}}

" +--------------+
" | visual aides |
" +--------------+
" {{{

" Enable syntax highlighting
syntax on

" Highlight the current line
set cursorline

" Show line numbers
set nu

" Set the color scheme to desert
colors neodark

" 256 colors
set t_Co=256

" colorcolumn
silent! set colorcolumn=80

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
set scrolloff=10
set sidescrolloff=10

" disable bells
set noerrorbells
set visualbell
set t_vb=

" enable modelines
set modeline

" enable wildmenu for smart tab complete
set wildmenu

" source any local configs
silent! source ~/.vimrc_local

" }}}

" +--------------+
" | key mappings |
" +--------------+
" {{{

" save and close a buffer using ctrl+x
inoremap <c-x> <esc>:x<cr>
noremap <c-x> :x<cr>

" force-close a buffer
inoremap <c-q> <esc>:q!<cr>
noremap <c-q> :q!<cr>

" create a new tab using ctrl+t
noremap <c-t> <esc>:tabnew<cr>

" un-indent more easily
inoremap <s-tab> <c-d>
vnoremap > >gv
vnoremap < <gv

" Fix pasting
nnoremap p ]p

" efficiency ftw
inoremap jj <esc>
nnoremap ; :

" clear highlights on redraw
nnoremap <c-l> :nohl<cr><c-l>

" copy/paste from system clipboard
noremap <leader>y "+y
noremap <leader>yy "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" }}}

" +-------------+
" | FOLDING FTW |
" +-------------+
" vim: syntax=vim foldmethod=marker foldlevel=0
