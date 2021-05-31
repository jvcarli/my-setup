" Minimal Neovim init file
" So Neovim opens really fast
" when used as a scrollback buffer with kitty
"
" See: kitty config file: ~/.config/kitty/kitty.conf
" See: https://sw.kovidgoyal.net/kitty/#the-scrollback-buffer

" Show line numbers
set number

" Disable numbers selection when selecting text with the mouse
set mouse=a

" Maps q and escape keys for existing vim in NORMAL mode"
nnoremap q :q!<CR>
nnoremap <ESC> :q!<CR>

" use the OS clipboard for copy and pasting
set clipboard=unnamedplus
