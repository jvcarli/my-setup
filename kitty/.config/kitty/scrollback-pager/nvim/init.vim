" vim:fileencoding=utf-8:foldmethod=marker
" Minimal Neovim init file so Neovim opens really fast
" when used as a scrollback buffer with kitty
"
" This configuration file is invoked from scrollback-buffer
" command and shortcut defined in: ~/.config/kitty/kitty.conf
" See: https://sw.kovidgoyal.net/kitty/#the-scrollback-buffer

" Packer plugins {{{

packadd zenbones.nvim
packadd hop.nvim
packadd vim-wordmotion

" }}}

" general settings {{{

" numbers
set relativenumber
set number

" Disable numbers selection when selecting text with the mouse
set mouse=a

" use the OS clipboard for copy and pasting
set clipboard=unnamedplus

" colorscheme
" set g:zenbones_compat=1 " lush.nvim won't be needed here, see: https://github.com/mcchrish/zenbones.nvim#installation
set termguicolors
set background=light " or dark
colorscheme zenbones

" virtualedit
" makes sense for this type of operation
set virtualedit=all

" }}}

" functions {{{

" Go to the last non whitespace char
" See: https://stackoverflow.com/questions/33663205/vim-jump-to-last-non-whitespace-character-of-a-file
" TODO: make LastChar() work
" function! LastChar()
"   let oldsearch = @/
"   let oldhls = &hls
"   let oldz = @z
"
"   norm G$"zyl
"   if match(@z, '\S')
"     exe "norm ?\\S\<CR>"
"   endif
"
"   let @/ = oldsearch
"   let &hls = oldhls
"   let @z = oldz
" endfunction

" }}}

" autocmds {{{

" autocmd BufWinEnter * :execute "normal \call LastChar()"
" autocmd FileType * :execute "normal \call LastChar()"
" autocmd FileType * :execute "normal \<Plug>SimpleFold_Foldsearch"

" autocmd BufWinEnter * call LastChar() " calling works but gives error

" TODO: insert autocommand to evoke LastChar function and then
" TODO: place the line to the bottom of the screen (zb)
" See: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim

" }}}

" mappings {{{

" Maps q and escape keys for existing vim in NORMAL mode"
nnoremap q :q!<CR>
nnoremap <ESC> :q!<CR>

" }}}

" lua config {{{

lua << EOF

-- Remap space as leader key
-- taken from defaults.nvim: https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

-- IT WORKS IHA! <space> is leader and "\" char (default leader) works independetly
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- hop.nvim
require'hop'.setup()
vim.api.nvim_set_keymap("n", "<leader>ow", "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua require'hop'.hint_lines()<cr>", {})

EOF

" }}}
