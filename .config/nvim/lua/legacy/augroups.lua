
-- https://github.com/jeffkreeftmeijer/vim-numbertoggle
-- vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
-- Maintainer:        <https://jeffkreeftmeijer.com>
-- Version:           2.1.2

vim.cmd [[augroup smartnumbertoggle ]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif]]
    vim.cmd [[autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif]]
vim.cmd [[augroup end ]]

