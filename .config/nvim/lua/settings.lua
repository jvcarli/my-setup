-- TODO: add more info about this option
-- nvim-compe prerequisite: "menuone,noselect"
vim.o.completeopt = "menuone,noselect"

-- in vim script: set termguicolors
-- TODO: list plugins that require this option
vim.o.termguicolors = true

-- Enable mouse scrolling in vim while in tmux
-- This will disable numbers selection when selecting
-- text with the mouse too
-- See: https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
-- See: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
vim.o.mouse = "a"

-- Enable access to system clipboard with +y operator
-- see: https://advancedweb.hu/working-with-the-system-clipboard-in-vim/
-- Set the + register as the default: :set clipboard=unnamedplus. 
-- Now every time you press y or p, Vim will use the system clipboard.
-- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
vim.o.clipboard = "unnamedplus"

-- Numbers
-- equivalent to vimscript `set number relativenumber`
vim.wo.number = true
vim.wo.relativenumber = true

--TODO: configure `wrapscan` option
-- When the search reaches the end of the file it will continue
-- at the start, unless the 'wrapscan' option has been reset.
