" vim:fileencoding=utf-8:ft=vim:foldmethod=marker

lua << EOF

-- Python hosts
-- python2(unnused) vim.g.python_host_prog = "~/.pyenv/versions/neovim2/bin/python"
vim.g.python3_host_prog = '~/.config/nvim/py3nvim/venv/bin/python'

-- Packer plugin config file 
-- when possible / convenient plugin configuration is declared there
require('plugins')

-- Neovim vanilla settings
require('settings')

-- Color themes
require('themes')

-- LSP (langauge server protocol) configuration
require('lsp')

-- Keymappings
require('keymappings')

-- Dap (debug adaptor protocol) configuration
-- require('dap')

-- Legacy section (vimscrit being used by lua)
-- autocmds
-- legacy/autocms and legacy/augroups section are coded with vimscript
-- because augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378
--
-- There is no equivalent to the :set command in Lua, you either set an option
-- globally or locally. If you're setting options from your init.lua,
-- some of them will require you to set both vim.o.{option} and vim.{wo/bo}.{option} to work properly.
-- see: https://github.com/nanotee/nvim-lua-guide#caveats-3
-- see: https://github.com/neovim/neovim/pull/13479
require('legacy/autocmds')
require('legacy/augroups')

-- debugpy MUST be installed inside dap-python venv: `pip install debugpy` inside it
-- See: https://github.com/mfussenegger/nvim-dap-python
-- TODO: bugfix, for some reson dap-python doesn't work when not called directly from init.vim
require'dap-python'.setup('/Users/development/.config/nvim/debug-adaptors/debugpy/venv/bin/python')

EOF

" {{{ vimscript

" Remap quickly press of `jk` keys to <Esc> when in INSERT mode
:imap jk <Esc>

" {{{ Tabs, spaces, splits and panes configuration

" General: use tab equals 4 spaces, and expand tabs as spaces
set tabstop=4 " show <tab> charcter as 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" nvim panes
" open new split panes to right and below
set splitright
set splitbelow

" }}}

" {{{ nvim terminal

" uses zsh instead of bash
"function! OpenTerminal()
"  split term://zsh
"  " zsh terminal column size
"  resize 10
"endfunction
"
"" open terminal on ctrl+n
"" nnoremap <c-n> :call OpenTerminal()<CR>
"nnoremap <leader>t :call OpenTerminal()<CR>
"
"" start terminal in insert mode
"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
"
"" turn terminal to normal mode with escape
"tnoremap <Esc> <C-\><C-n>
"
"" }}}

" {{{ Leader key change
" map space to leader key
" See: https://stackoverflow.com/questions/25341062/vim-let-mapleader-space-annoying-cursor-movement
nmap <space> <leader>
" }}}

" Plugins:
" {{{ vim-telescope
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').treesitter()<CR>
" }}}

" nvim-dap-python {{{
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dd :lua require('dap').continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>`
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
" }}}

" }}}

