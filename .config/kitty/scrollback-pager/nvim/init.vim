" Minimal Neovim init file
" So Neovim opens really fast
" when used as a scrollback buffer with kitty
"
" See: kitty config file: ~/.config/kitty/kitty.conf
" See: https://sw.kovidgoyal.net/kitty/#the-scrollback-buffer

lua << EOF

require("hop")
require("keymaps")

EOF

" Show line numbers
set number

" Disable numbers selection when selecting text with the mouse
set mouse=a

" Maps q and escape keys for existing vim in NORMAL mode"
nnoremap q :q!<CR>
nnoremap <ESC> :q!<CR>

" use the OS clipboard for copy and pasting
set clipboard=unnamedplus

" The jump-to-word command.
command! HopWord lua require'hop'.hint_words()

" The jump-to-pattern command.
command! HopPattern lua require'hop'.hint_patterns()

" The jump-to-char-1 command.
command! HopChar1 lua require'hop'.hint_char1()

" The jump-to-char-2 command.
command! HopChar2 lua require'hop'.hint_char2()

" The jump-to-line command.
command! HopLine lua require'hop'.hint_lines()

colorscheme tokyonight

" Go to the last non whitespace char
" See: https://stackoverflow.com/questions/33663205/vim-jump-to-last-non-whitespace-character-of-a-file
function! LastChar()
  let oldsearch = @/
  let oldhls = &hls
  let oldz = @z

  norm G$"zyl
  if match(@z, '\S')
    exe "norm ?\\S\<CR>"
  endif

  let @/ = oldsearch
  let &hls = oldhls
  let @z = oldz
endfunction

" autocmd BufWinEnter * :execute "normal \call LastChar()"
" autocmd FileType * :execute "normal \call LastChar()"
" autocmd FileType * :execute "normal \<Plug>SimpleFold_Foldsearch"

" autocmd BufWinEnter * call LastChar() " calling works but gives error

" TODO: insert autocommand to evoke LastChar function and then
" TODO: place the line to the bottom of the screen (zb)
" See: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim
