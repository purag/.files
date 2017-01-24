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
  let g:indentLine_color_term = 0
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
" }}}

Plug 'terryma/vim-multiple-cursors' " {{{
" }}}

Plug 'junegunn/fzf', { 'do': './install --bin' }

Plug 'junegunn/fzf.vim' " {{{
  nnoremap <leader>zf <esc>:Files<cr>
  nnoremap <leader>zh <esc>:History<cr>
  nnoremap <leader>zg <esc>:GFiles<cr>
" }}}

Plug 'sickill/vim-monokai' " {{{
" }}}

Plug 'rakr/vim-two-firewatch' " {{{
" }}}

Plug 'tpope/vim-commentary' " {{{
" }}}

Plug 'vim-airline/vim-airline' " {{{
  let g:airline_powerline_fonts = 1
  set laststatus=2
" }}}

Plug 'vim-airline/vim-airline-themes' " {{{
  function! ToggleAirlineTheme()
    if g:airline_theme == "raven"
      AirlineTheme wombat
    else
      AirlineTheme raven
    endif
  endfunction
  nnoremap <leader>at :call ToggleAirlineTheme()<cr>

  let g:airline_theme = 'wombat'
" }}}

Plug 'mhinz/vim-startify' " {{{
" }}}

Plug 'oguzbilgic/sexy-railscasts-theme' " {{{
" }}}

Plug 'mhartington/oceanic-next' " {{{
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

" Highlight the current line
set cursorline

" Show line numbers
set nu

" Set the color scheme to desert
colors OceanicNext

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

" enable modelines
set modeline

" enable wildmenu for smart tab complete
set wildmenu

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

" Fix pasting
nnoremap  p       ]p

" Fix undo
inoremap <c-z>   <esc>ua
noremap  <c-z>   u

" efficiency ftw
inoremap jj      <esc>
nnoremap ;       :

" clear highlights on redraw
nnoremap <c-l>   :nohl<cr><c-l>

" }}}

" +-------------+
" | FOLDING FTW |
" +-------------+
" vim: syntax=vim foldmethod=marker foldlevel=0
