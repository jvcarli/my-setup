" vim:fileencoding=utf-8:ft=vim:foldmethod=marker
" TODO: migrate init.vim to LUA init.lua and vimscript plugins to lua ones

" Vim Plug and Plugins {{{
call plug#begin("~/.local/share/nvim/plugged") " use default nvim location instead of ~/.vim

  " Themes
  " Vim editor colors
  Plug 'ayu-theme/ayu-vim'
  " Vim airline
  Plug 'vim-airline/vim-airline'
  " Vim airline themes
  Plug 'vim-airline/vim-airline-themes'

  " Syntax Highlighting - Vim Polyglot
  " https://github.com/sheerun/vim-polyglot
  Plug 'sheerun/vim-polyglot'

  " Language Client - CoC (Conquer of Completion)
  " https://github.com/neoclide/coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

  " Golang Language Client
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " File Explorer with Icons
  " NERDTree - https://github.com/preservim/nerdtree
  " NERD tree will be loaded on the first invocation of NERDTreeToggle command
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  " Vim Devicons - https://github.com/ryanoasis/vim-devicons
  Plug 'ryanoasis/vim-devicons' " nvim-web-devicons doesn't work with NERDTree

  " File Search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Git enhancements
  " gitsigns.nvim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'

call plug#end()

" }}}

" TODO: include updatetime explanation
set updatetime=300

" {{{ Tabs, spaces, splits and panes configuration

" TODO: do separate config of tabs and spaces for golang, gofmt uses both
" show existing tab with 4 spaces width
set tabstop=4
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4
"set noexpandtab

" nvim panes
" open new split panes to right and below
set splitright
set splitbelow

" }}}

" {{{ Hybrid line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" }}}

" {{{ nvim terminal

" uses zsh instead of bash
function! OpenTerminal()
  split term://zsh
  " zsh terminal column size
  resize 10
endfunction

" open terminal on ctrl+n
nnoremap <c-n> :call OpenTerminal()<CR>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" }}}

" {{{ Theme & colors

" {{{ Colors
 if (has("termguicolors"))
  set termguicolors
  let ayucolor="light" "options: light / dark / mirage
  colorscheme ayu

  let g:airline_theme='ayu_light' "options: light / dark / mirage
  "TODO: make italics work with ayu theme:
  " highlight Comment cterm=italic
  
 endif
" }}}

" {{{ Remove tildes - Set the color of non text characters to be the same as the background color
" https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim
hi NonText guifg=bg
" }}}

" TODO: Is this necessary?
" Theme
" syntax enable

" }}}

" {{{ Plugin configuration

" {{{ vimscript

" NERDTree {{{
" Show hidden files
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeShowLineNumbers = 0
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree with ctrl-b
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" }}}

" {{{ fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" requires silversearcher-ag, you can install it with
" `$ brew install the_silver_searcher`
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" }}}

" {{{ TODO: revisit this configuration, macos doesn't have a alt key,
" maybe use kitty config option to use option key as alt
" use alt+hjkl to move between split/vsplit panels
" tnoremap <A-h> <C-\><C-n><C-w>h
" tnoremap <A-j> <C-\><C-n><C-w>j
" tnoremap <A-k> <C-\><C-n><C-w>k
" tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l
" }}}

" {{{ Coc configuration

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" }}}

" }}}

" {{{ Lua plugins
lua << EOF

-- {{{ gitsigns
require('gitsigns').setup{
  -- enable yadm support
  yadm = {
    enable = true
  }
}
-- }}}

EOF
" }}}

" }}}
