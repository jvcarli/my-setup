vim.cmd [[augroup numbertoggle]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd BufEnter,FocusGained,InsertLeave * set relativenumber]]
    vim.cmd [[autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber ]]
vim.cmd [[augroup END]]

